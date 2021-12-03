:- use_module(library(clpfd)).
:- [read_line].
% listmember(X,[X|]).
% listmember(X,[|TAIL]) :- list_member(X,TAIL).

% list_append(A,T,T) :- list_member(A,T),!.
% list_append(A,T,[A|T]).

% print_list([]) :- writeln("").
% print_list([H|TAIL]) :- print_list(TAIL), write(H).


% how is this func working
read_loop(IDs, Cores, Areas, Dollars, C, CoreStates, AreaStates, DollarStates) :-
	read_line(Line),
	length(Line, Len),
	(
		Len > 0,
		write(Line), nl,
		sentence(T, Line, []),
		writeln("Before if"),
		(length(T, Length), Length =:= 4 -> 
			nth0(0, T, First),
			nth0(1, T, Second),
			nth0(2, T, Third),
			nth0(3, T, Fourth), 
			append(C, [], NC),
			append(IDs, [First], NIDs), 
			append(Cores, [Second], NCores),
			append(Areas, [Third], NAreas),
			append(Dollars, [Fourth], NDollars);
			writeln(Length),
			append(C, [T], NC),
			append(IDs, [], NIDs),
			append(Cores, [], NCores),
			append(Areas, [], NAreas),
			append(Dollars, [], NDollars)
		),

		writeln(NIDs),
		writeln(NCores),
		writeln(NAreas),
		writeln(NDollars),
		writeln(NC),
		read_loop(NIDs, NCores, NAreas, NDollars, NC, CoreStates, AreaStates, DollarStates);
		Len =< 0,
		write('Read last line.'),
		optimize(IDs, Cores, Areas, Dollars, C, CoreStates, AreaStates, DollarStates),
		nl
	).


main :-
	IDs = [],
	Cores = [],
	Areas = [],
	Dollars = [],
	C = [],
	CoreStates = [],
	AreaStates = [],
	DollarStates = [],
	read_loop(IDs, Cores, Areas, Dollars, C, CoreStates, AreaStates, DollarStates).

core(Cores, Constraint, CS):-
	length(Cores, Length),
	(
		Length > 0,
		Cores = [HC | TC],
		Constraint = [First , Second , Third],
		writeln(Second),
		(Second = less -> A * HC in 0..Third; true),
		(Second = greater -> A * HC in Third..100000; true),
		(Second = equal -> A * HC #= Third; true),
		(integer(Second) -> A * HC in Second..Third; true),
		append(CS, A, NCS),
		core(TC, Constraint, NCS);
		Length =< 0,
		writeln(CS)
	).


area(Areas, Constraint, AS):-
	length(Areas, Length),
	(
		Length > 0,
		Areas = [HA | TA],
		Constraint = [First , Second , Third],
		(Second = less -> B * HA in 0..Third; true),
		(Second = greater -> B * HA in Third..100000; true),
		(Second = equal -> B * HA #= Third; true),
		(integer(Second) -> B * HA in Second..Third; true),
		append(AS, B, NAS),
		area(TA, Constraint, NAS);
		Length =< 0,
		writeln(AS)

	).


cost(Dollars, Constraint, DS):-
	length(Dollars, Length),
	(
		Length > 0,
		Dollars = [HD | TD],
		Constraint = [First , Second , Third],
		(Second = less -> C * HD in 0..Third; true),
		(Second = greater -> C * HD in Third..100000; true),
		(Second = equal -> C * HD #= Third; true),
		(integer(Second) -> C * HD in Second..Third; true),
		append(DS, C, NDS),
		cost(TD, Constraint, NDS);
		Length =< 0,
		writeln(DS)

	).

optimize(IDs, Cores, Areas, NDollars, C, CoreStates, AreaStates, DollarStates) :-
	C = [First, Second, Third],
	(First = [F, S, T], F = core -> CoreConstraint = First),
	core(Cores, CoreConstraint, CoreStates),
	area(Areas, C, AreaStates),
	cost(Dollars, C, DollarStates).
	% writeln(CoreStates),
	% writeln(AreaStates),
	% writeln(DollarStates),
	% labeling([],CoreStates),
	% labeling([],AreaStates),
	% labeling([],DollarStates).
	

	% nth0(0, C, First),
	% nth0(1, C, Second),
	% nth0(2, C, Third),
	% length(IDs, Length){
	% 	Length > 0,
	% 	Cores = [HCores | TCores],
	% 	(First = core -> (
	% 		nth0(1, First, Comp),
	% 		nth0(2, First, Val),
	% 		(Comp = less -> A * HCores < Val)
	% 	);
	% 	(Second = core -> (
	% 		nth0(1, Second, Comp),
	% 		nth0(2, Second, Val),
	% 		(Comp = less -> A * HCores < Val)
	% 	);
	% 	(Third = core -> (
	% 		nth0(1, Third, Comp),
	% 		nth0(2, Third, Val),
	% 		(Comp = less -> A * HCores < Val)

	% 	))
	% 	)
	% 	),
	% 	append(CoreStates, A, NCoreStates),
		



sentence([A, C, V]) --> attribute(A), imperative1, imperative2, be, comparison(C), throwaway, value(V), [.].
sentence([A,V1,V2]) --> attribute(A), imperative1, imperative2, be, interval, value(V1), [to], value(V2), [.].
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

be --> [be].

comparison(equal) --> [equal].
comparison(less) --> [less].
comparison(greater) --> [greater].
throwaway --> [to] | [than].

interval --> [in], [the], [interval], [of].
interval --> [in], [the], [range], [of].

value(V) --> [V], {integer(V)}.