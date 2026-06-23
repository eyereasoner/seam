% Reference 9.2: transcendental functions have stable exact outputs at simple inputs.
materialize(answer, 2).
answer(sin_zero, ?x) :- sin(0, ?x).
answer(cos_zero, ?x) :- cos(0, ?x).
answer(tan_zero, ?x) :- tan(0, ?x).
answer(exp_zero, ?x) :- exp(0, ?x).
answer(log_one, ?x) :- log(1, ?x).
answer(atan2_zero, ?x) :- atan2(0, 1, ?x).
answer(sqrt_one, ?x) :- sqrt(1, ?x).
