% Reference 9.10: functor/3 reports scalar terms with arity zero.
materialize(answer, 2).
answer(atom, pair(?name, ?arity)) :- functor(alpha, ?name, ?arity).
answer(quoted_atom, pair(?name, ?arity)) :- functor('hello-world', ?name, ?arity).
answer(string, pair(?name, ?arity)) :- functor("text", ?name, ?arity).
answer(number, pair(?name, ?arity)) :- functor(123, ?name, ?arity).
answer(list_functor, pair(?name, ?arity)) :- functor([a, b], ?name, ?arity).
answer(unbound_rejected, ok) :- not(functor(?x, ?name, ?arity)).
