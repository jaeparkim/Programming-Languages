% Helper functions
% not really useful?


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
	parentOf(Parent, Descendant),
	(Parent = Person -> true; hasDescendant(Person, Parent)).

listAncestors(Person, Ancestors) :-
	findall(X, hasAncestor(Person, X), Ancestors),
	write(Ancestors).

listDescendants(Person, Descendants) :-
	findall(Z, hasDescendant(Person, Z), Descendants).

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
