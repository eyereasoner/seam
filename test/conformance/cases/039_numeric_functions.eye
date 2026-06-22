% Reference 9.2: scalar arithmetic functions return numeric values.
answer(neg, ?x) :- neg(5, ?x).
answer(abs, ?x) :- abs(-5, ?x).
answer(rounded, ?x) :- rounded(2.6, ?x).
answer(sin_zero, ?x) :- sin(0, ?x).
answer(cos_zero, ?x) :- cos(0, ?x).
answer(log_one, ?x) :- log(1, ?x).
answer(float_division, ?x) :- div(7.0, 2.0, ?x).
materialize(answer, 2).
