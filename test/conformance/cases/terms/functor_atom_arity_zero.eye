% Atoms are zero-arity terms for functor/3.
materialize(answer, 2).
answer(?name, ?arity) :- functor(nil, ?name, ?arity).
