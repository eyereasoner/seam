% Reference 9.1: reusable numeric functions preserve integer paths and define finite failure modes.
materialize(answer, 2).
answer(max_negative, ?x) :- max(-10, -3, ?x).
answer(min_float, ?x) :- min(2.5, -1.25, ?x).
answer(floor_negative, ?x) :- floor(-3.1, ?x).
answer(ceiling_negative, ?x) :- ceiling(-3.9, ?x).
answer(trunc_positive, ?x) :- trunc(3.9, ?x).
answer(sqrt_fraction, ?x) :- sqrt(2.25, ?x).
answer(pow_fraction, ?x) :- pow(9, 0.5, ?x).
answer(sqrt_negative_rejected, ok) :- not(sqrt(-1, ?x)).
answer(log_zero_rejected, ok) :- not(log(0, ?x)).
answer(div_zero_rejected, ok) :- not(div(1, 0, ?x)).
answer(mod_float_rejected, ok) :- not(mod(5.5, 2, ?x)).
answer(pow_negative_integer_exponent_rejected, ok) :- not(pow(2, -1, ?x)).
