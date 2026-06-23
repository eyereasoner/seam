materialize(answer, 1).
answer(eq_nested_repeated_fails) :- eq(pair(?x, ?x), pair(a, b)).
