materialize(answer, 2).
answer(take, ?x) :- take(0, [a, b], ?x).
answer(drop, ?x) :- drop(2, [a, b], ?x).
