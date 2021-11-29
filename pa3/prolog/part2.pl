:- [read_line].

% how is this func working
read_loop :-
	read_line(Line),
	length(Line, Len),
	(
		Len > 0,
		write(Line), nl,
		language_processing(Line, Len),
		read_loop;
		Len =< 0,
		write('Read last line.'), nl
	).


language_processing(Line, Len) :-
	nth0(0, Line, First),
	(First = processor -> processor_def(Line, Len) ; constraint_def(Line, Len)).

% Are all processor definitions going to be the exact same structure
processor_def(Line, Len) :-
	writeln("Processor"),
	nth0(2, Line, Des),
	nth0(4, Line, Cores),
	nth0(8, Line, Area),
	nth0(14, Line, Cost),
	writeln(Des),
	writeln(Cores),
	writeln(Area),
	writeln(Cost). % How to create a data structure in prolog to save these variables

constraint_def(Line, Len) :-
	write("Constraint Len = "),
	writeln(Len).

% how should we go about this
sentence() :-
	true.


main :-
	read_loop.


% --> what does this mean
sentence(V) --> attribute, imperative, be, comparison, value.
sentence(V) --> attribute, imperative, be, interval, range.
attribute --> [the] | [].
imperative --> [must]| ["is to"].
be --> [be].
comparison --> ["equal to"] | ["less than"] | ["greater than"].
value --> []. % Constrain this to an integer?
interval --> ["in the interval of"]; ["in the range of"].
range --> [].% Constrain this to two integers?



