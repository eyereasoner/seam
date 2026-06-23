materialize(answer, 1).
answer(named_variable_reused) :- eq(pair(?x, ?x), pair(a, a)).
