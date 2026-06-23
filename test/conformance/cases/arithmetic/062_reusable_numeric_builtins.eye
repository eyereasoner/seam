% Reference 9.1: reusable numeric functions and max/3.
materialize(answer, 2).
answer(max, ?x) :- max(17, 42, ?x).
answer(sqrt, ?x) :- sqrt(81, ?x).
answer(floor, ?x) :- floor(3.9, ?x).
answer(ceiling, ?x) :- ceiling(3.1, ?x).
answer(trunc, ?x) :- trunc(-3.9, ?x).
answer(exp, ?x) :- exp(0, ?x).
answer(tan, ?x) :- tan(0, ?x).
answer(atan2, ?x) :- atan2(0, -1, ?x).
