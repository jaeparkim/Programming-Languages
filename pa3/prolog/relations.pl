% Helper functions
% not really useful?
list_member(X,[X|_]).
list_member(X,[_|TAIL]) :- list_member(X,TAIL).

list_append(A,T,T) :- list_member(A,T),!.
list_append(A,T,[A|T]).

print_list([]) :- writeln("").
print_list([H|TAIL]) :- print_list(TAIL), write(H).


siblings(Person, Sibling) :- % how to test more rigorously if these rules work
	parentOf(Z,Person), 
	parentOf(Z,Sibling), 
	Person \= Sibling.

firstCousins(Person, Cousin) :-
	parentOf(Y, Person),
	parentOf(Z, Cousin),
	siblings(Y, Z),
	Y \= Z.

hasAncestor(Person, Ancestor) :-
	childOf(Child, Ancestor), 
	(Child = Person -> true ; hasAncestor(Person, Child)).

hasDescendant(Person, Descendant) :-
	% hasAncestor(Descendant, Person).
	parentOf(Parent, Descendant),
	(Parent = Person -> true; hasDescendant(Person, Parent)).
	% parentOf(Descendant, Parent), 
	% (Parent = Person -> true ; hasDescendant(Person, Parent)).

listAncestors(Person, Ancestors) :-
	findall(X, hasAncestor(Person, X), Ancestors).

	% MY APPROACH
	%append([Person], Ancestors, Newlist),
	%parentOf(Parent, Person);
	%    parentOf(Parent, Person), !;
	%listAncestors(Parent, Newlist).

	% USEFUL SYNTAX?
	%parentOf(Parent, Person),
	
	% writeln("***"),
	% writeln(Parent),
	
	% list_append(Parent, Ancestors, Newlist),
	% Ancestors = Newlist, % how to maintain and update a list, can we use a global?
	% print_list(Ancestors),

	% append(Parent, Ancestors, Ancestors),

	% append([Person], Ancestors, Newlist);
	% parentOf(Parent, Person),
	% write(nl),
	%    print_list(Newlist), nl,
	% Ancestors = Newlist,
	% write(Parent),
	% listAncestors(Parent, Ancestors).


listDescendants(Person, Descendants) :-
	findall(Z, hasDescendant(Person, Z), Descendants).
	%append([Child], Descendants, Newlist),
	%childOf(Child, Person);
	%    childOf(Child, Person), !;
	%listDescendants(Child, Newlist).

hasHeir(Person, Heir) :-
	monarch(Person),
	findall(Year, (childOf(Child, Person), birthYear(Child, Year)), Years),
	min_list(Years, Min),
	birthYear(Heir, HeirYear),
	HeirYear = Min.


hasSuccessor(Person, Successor) :-
	monarch(Person),
	monarch(Successor),
	parentOf(Person, Successor).

heirIsSuccessor(Person) :-
	monarch(Person),
	findall(Year, (childOf(Child, Person), birthYear(Child, Year)), Years),
	min_list(Years, Min),
	birthYear(C, Min),
	monarch(C).
