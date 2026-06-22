materialize(answer, 2).
answer(floor, ?x) :- floor(-1.2, ?x).
answer(ceiling, ?x) :- ceiling(-1.2, ?x).
answer(trunc, ?x) :- trunc(-1.8, ?x).
answer(rounded, ?x) :- rounded(-1.5, ?x).
