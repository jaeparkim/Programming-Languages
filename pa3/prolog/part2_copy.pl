:- use_module(library(clpfd)).
:- [read_line].

read_loop(IDs, Cores, Areas, Costs, CoreC, AreaC, CostC) :-
	read_line(Line),
	length(Line, Len),
	(
		Len > 0,
		sentence(T, Line, []),
		(length(T, Length), Length =:= 4 -> 
			nth0(0, T, First),
			nth0(1, T, Second),
			nth0(2, T, Third),
			nth0(3, T, Fourth), 
			append(IDs, [First], NIDs), 
			append(Cores, [Second], NCores),
			append(Areas, [Third], NAreas),
			append(Costs, [Fourth], NCosts),
			append(CoreC, [], NCoreC),
			append(AreaC, [], NAreaC),
			append(CostC, [], NCostC);
			nth0(0, T, Attribute),
			(Attribute = core -> append(CoreC, T, NCoreC), append(AreaC, [], NAreaC), append(CostC, [], NCostC); true),
			(Attribute = area -> append(AreaC, T, NAreaC), append(CoreC, [], NCoreC), append(CostC, [], NCostC); true),
			(Attribute = cost -> append(CostC, T, NCostC), append(CoreC, [], NCoreC), append(AreaC, [], NAreaC); true),
			append(IDs, [], NIDs),
			append(Cores, [], NCores),
			append(Areas, [], NAreas),
			append(Costs, [], NCosts)
		),
		read_loop(NIDs, NCores, NAreas, NCosts, NCoreC, NAreaC, NCostC);
		Len =< 0,
		findall(R, optimize(Cores, Areas, Costs, CoreC, AreaC, CostC, R), Rs),
		print_recursive(Rs, IDs),
		true
	).

print_recursive(Rs, IDs) :-
	length(Rs, Length),
	(
		Length > 0,
		Rs = [H | T],
		print_inner_recursive(H, IDs),
		print_recursive(T, IDs);
		true
	).

print_inner_recursive(Row, IDs) :-
	length(Row, RLength),
	(
		RLength > 1,
		Row = [H | T],
		IDs = [HID | TID],
		write(HID),
		write(" = "),
		write(H),
		write(", "),
		print_inner_recursive(T, TID);
		RLength = 1,
		Row = [H | T],
		IDs = [HID | TID],
		write(HID),
		write(" = "),
		write(H),
		print_inner_recursive(T, TID);
		write(";"),
		nl
	).

main :-
	IDs = [], Cores = [], Areas = [], Costs = [], CoreC = [], AreaC = [], CostC = [],
	read_loop(IDs, Cores, Areas, Costs, CoreC, AreaC, CostC).

optimize(Cores, Areas, Costs, CoreC, AreaC, CostC, Results) :-
	length(Cores, LengthVal),
	length(Results, LengthVal),
	Results ins 0..16,
	nth0(1, CoreC, CoreComp),
	nth0(2, CoreC, CoreVal),
	nth0(1, AreaC, AreaComp),
	nth0(2, AreaC, AreaVal),
	nth0(1, CostC, CostComp),
	nth0(2, CostC, CostVal),
	(CoreComp = greater -> scalar_product(Cores, Results, #>, CoreVal); true),
	(CoreComp = less -> scalar_product(Cores, Results, #<, CoreVal); true),
	(CoreComp = equal -> scalar_product(Cores, Results, #=, CoreVal); true),
	(integer(CoreComp) -> scalar_product(Cores, Results, #>=, CoreComp), scalar_product(Cores, Results, #=<, CoreVal); true),
	(AreaComp = greater -> scalar_product(Areas, Results, #>, AreaVal); true),
	(AreaComp = less -> scalar_product(Areas, Results, #<, AreaVal); true),
	(AreaComp = equal -> scalar_product(Areas, Results, #=, AreaVal); true),
	(integer(AreaComp) -> scalar_product(Areas, Results, #>=, AreaComp), scalar_product(Areas, Results, #=<, AreaVal); true),
	(CostComp = greater -> scalar_product(Costs, Results, #>, CostVal); true),
	(CostComp = less -> scalar_product(Costs, Results, #<, CostVal); true),
	(CostComp = equal -> scalar_product(Costs, Results, #=, CostVal); true),
	(integer(CostComp) -> scalar_product(Costs, Results, #>=, CostComp), scalar_product(Costs, Results, #=<, CostVal); true),
	label(Results).

sentence([A, C, V]) --> attribute(A), imperative1, imperative2, [be], comparison(C), throwaway, value(V), [.].
sentence([A,V1,V2]) --> attribute(A), imperative1, imperative2, [be], interval, value(V1), [to], value(V2), [.].
sentence([I, C, A, D]) --> [processor], [type], id(I), [has],
	value(C), [cores], [,], [uses], value(A), [square], [centimeters], 
	[,], [and], [costs], value(D), [dollars], [.].

attribute(A) --> optional_article, constraint1(A), constraint2.
optional_article --> [the] | [].
constraint1(core) --> [core]. 
constraint1(area) --> [area].
constraint1(cost) --> [cost].
constraint2 --> [count] | [].

id(I) --> [I].

imperative1 --> [must] | [is].
imperative2 --> [] | [to].

comparison(equal) --> [equal].
comparison(less) --> [less].
comparison(greater) --> [greater].
throwaway --> [to] | [than].

interval --> [in], [the], [interval], [of].
interval --> [in], [the], [range], [of].

value(V) --> [V], {integer(V)}.