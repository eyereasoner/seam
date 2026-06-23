% Reference 9.1: term-inspection built-ins expose scalars, nested arguments, and atom construction from an empty argument list.
materialize(answer, 2).
answer(functor_atom, pair(?name, ?arity)) :- functor(alpha, ?name, ?arity).
answer(functor_number, pair(?name, ?arity)) :- functor(42, ?name, ?arity).
answer(functor_string, pair(?name, ?arity)) :- functor("hi", ?name, ?arity).
answer(arg_nested, ?x) :- arg(1, path(edge(a, b), c), ?x).
answer(compose_nested, ?x) :- compound_name_arguments(?x, outer, [inner(a), [b, c]]).
answer(compose_atom_empty_args, ?x) :- compound_name_arguments(?x, z, []).
answer(decompose_atom_empty_args, pair(?name, ?args)) :- compound_name_arguments(z, ?name, ?args).
answer(arg_zero_rejected, ok) :- not(arg(0, edge(a, b), ?x)).
answer(arg_too_large_rejected, ok) :- not(arg(3, edge(a, b), ?x)).
