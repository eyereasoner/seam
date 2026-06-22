materialize(answer, 3).
answer(number, ?name, ?arity) :- functor(42, ?name, ?arity).
answer(string, ?name, ?arity) :- functor("hi", ?name, ?arity).
