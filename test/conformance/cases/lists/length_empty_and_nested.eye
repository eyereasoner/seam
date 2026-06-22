materialize(answer, 2).
answer(empty, ?x) :- length([], ?x).
answer(nested, ?x) :- length([[a], [b, c]], ?x).
