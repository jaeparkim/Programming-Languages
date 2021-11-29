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
	hasAncestor(Descendant, Person).
	% parentOf(Descendant, Parent), 
	% (Parent = Person -> true ; hasDescendant(Person, Parent)).

listAncestors(Person, Ancestors) :-
	parentOf(Parent, Person),
	% write(Parent),
	append([Parent], Ancestors, Ancestors), % how to maintain and update a list, can we use a global?
	listAncestors(Parent, Ancestors).

listDescendants(Person, Descendants) :-
	childOf(Person, Child),
	append([Child], Descendants, Descendants), % same question as above
	listDescendants(Child, Descendants).

hasHeir(Person, Heir) :-
	Minyear = 2000;
	Minchild = "";
	monarch(Person),
	childOf(Child, Person), birthYear(Child, Year), 
		(Year < Minyear -> 
			Minyear = Year, Minchild = Child; 
			write(Minchild), write(Minyear)
		),
		(Heir = Minchild ->
			true ; 
			false
		).

hasSuccessor(Person, Successor) :-
	monarch(Person),
	monarch(Successor),
	parentOf(Person, Successor).

heirIsSuccessor(Person) :-
	Minyear = 2000;
	Minchild = "";
	monarch(Person),
	childOf(Child, Person), birthYear(Child, Year), 
		(Year < Minyear -> 
			Minyear = Year, Minchild = Child; 
			write(Minchild), write(Minyear)
		),
	monarch(Minchild).	

