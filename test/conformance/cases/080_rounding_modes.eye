% Reference 9.2: rounding built-ins have distinct behavior for positive and negative decimals.
materialize(answer, 2).
answer(floor_pos, ?x) :- floor(3.9, ?x).
answer(floor_neg, ?x) :- floor(-3.1, ?x).
answer(ceiling_pos, ?x) :- ceiling(3.1, ?x).
answer(ceiling_neg, ?x) :- ceiling(-3.9, ?x).
answer(trunc_pos, ?x) :- trunc(3.9, ?x).
answer(trunc_neg, ?x) :- trunc(-3.9, ?x).
answer(round_half_up, ?x) :- rounded(2.5, ?x).
answer(round_half_neg, ?x) :- rounded(-2.5, ?x).
