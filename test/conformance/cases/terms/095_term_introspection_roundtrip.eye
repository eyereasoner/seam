% Reference 9.10: term inspection can decompose and recompose compound terms.
materialize(answer, 2).
answer(functor_compound, pair(?name, ?arity)) :- functor(edge(a, b), ?name, ?arity).
answer(arg_first, ?x) :- arg(1, edge(a, b), ?x).
answer(arg_second, ?x) :- arg(2, edge(a, b), ?x).
answer(decompose, pair(?name, ?args)) :- compound_name_arguments(edge(a, b), ?name, ?args).
answer(recompose, ?x) :- compound_name_arguments(?x, edge, [a, b]).
answer(roundtrip, ?x) :- compound_name_arguments(edge(a, b), ?name, ?args), compound_name_arguments(?x, ?name, ?args).
