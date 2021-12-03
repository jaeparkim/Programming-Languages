:- use_module(library(clpfd)).




main :-
    length(Results, 2),
    Results ins 0..10,
    nth0(0, Results, A),
    nth0(1, Results, B),
    A + B #>= 24,
    A #< B,
    scalar_product([1,1], Results, #=, 10),
    label(Results).