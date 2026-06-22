% Reference 9.1: term introspection/construction, term strings, and forall/2.
materialize(answer, 2).
item(1).
item(2).
item(3).
answer(functor, pair(?name, ?arity)) :- functor(edge(a, b), ?name, ?arity).
answer(arg, ?x) :- arg(2, edge(a, b), ?x).
answer(decompose, pair(?name, ?args)) :- compound_name_arguments(edge(a, b), ?name, ?args).
answer(compose, ?x) :- compound_name_arguments(?x, edge, [a, b]).
answer(term_string, ?x) :- term_string(edge(a, [b, c]), ?x).
answer(forall, ok) :- forall(item(?x), lt(?x, 4)).
