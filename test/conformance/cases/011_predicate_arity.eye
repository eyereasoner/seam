% Reference 6: predicate name and arity both identify a predicate group.
p(a).
p(a, b).
answer(unary, ?x) :- p(?x).
answer(binary, pair(?x, ?y)) :- p(?x, ?y).
materialize(answer, 2).
