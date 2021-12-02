:- [read_line].

% how is this func working
read_loop :-
	read_line(Line),
	length(Line, Len),
	(
		Len > 0,
		write(Line), nl,
		sentence(T, Line, []),
		writeln(T),
		% langauge_def(Line),
		read_loop;
		Len =< 0,
		write('Read last line.'), 
		nl
	).


% language_processing(Line, Len) :-
% 	nth0(0, Line, First),
% 	(First = processor -> processor_def(Line, Len) ; constraint_def(Line, Len)).

% Are all processor definitions going to be the exact same structure
langauge_processing(Line) :-
	% sentence(Line, [the]).
	sentence(T, Line, []),
	write(T),nl.

constraint_def(Len) :-
	write("Constraint Len = "),
	writeln(Len).

% how should we go about this
% sentence() :-
% 	true.


main :-
	read_loop.


% --> what does this mean
sentence(t(A, C, V)) --> attribute(A), imperative1, imperative2, be, comparison(C), throwaway, value(V), [.].
sentence(t(A,V1,V2)) --> attribute(A), imperative1, imperative2, be, interval, value(V1), [to], value(V2), [.].
sentence(t(I, C, A, D)) --> [processor], [type], id(I), [has],
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