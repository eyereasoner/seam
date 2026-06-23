materialize(answer, 2).
pair_key(pair(a, b)).
answer(structured_head_rule, ?x) :- pair_key(pair(?x, b)).
