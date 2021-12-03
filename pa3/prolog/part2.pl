:- [read_line].
% listmember(X,[X|]).
% listmember(X,[|TAIL]) :- list_member(X,TAIL).

% list_append(A,T,T) :- list_member(A,T),!.
% list_append(A,T,[A|T]).

% print_list([]) :- writeln("").
% print_list([H|TAIL]) :- print_list(TAIL), write(H).


% how is this func working
read_loop(P, C) :-
	read_line(Line),
	length(Line, Len),
	(
		Len > 0,
		write(Line), nl,
		sentence(T, Line, []),
		writeln("Before if"),
		(length(T, Length), Length =:= 4 ->  
			append(C, [], NC),
			append(P, [T], NP);
			append(C, [T], NC),
			append(P, [], NP)
		),
		writeln(NP),
		writeln(NC),
		read_loop(NP, NC);
		Len =< 0,
		write('Read last line.'),
		optimize(P, C),
		% convert_constraints(C),
		nl
	).


main :-
	P = [],
	C = [],
	read_loop(P, C).

optimize(NP, NC) :-
	length(NP, Length),
	(
		
	)

% cores(NP, Constraint) :-
% 	nth0(0, Constraint, First),
% 	nth0(1, Constraint, Second),
% 	nth0(2, Constraint, Third),
% 	(Second = less -> )

% area() :-

% cost() :-


	
% convert_constraints(NC) :-
% 	length(NC, Len),
% 	(
% 		Len > 0,
% 		NC = [H|T],
% 		nth0(0, H, First),
% 		nth0(1, H, Second),
% 		nth0(2, H, Third),
% 		(integer(Second) -> ;
% 			(Second = less -> replace(less, 0, H, NewH)
% 		)
% 		replace(H, NewH, NC, ADF)
% 		writeln(H),
% 		convert_constraints(ADF);
% 		Len =< 0,
% 		write('Read last constraint.'),
% 		nl
% 	).



% constraint(A, B, C, D, Processor, Constraints) :-
	



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