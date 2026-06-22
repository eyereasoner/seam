materialize(answer, 2).
answer(first, ?x) :- arg(1, pair(a, b), ?x).
answer(second, ?x) :- arg(2, pair(a, b), ?x).
