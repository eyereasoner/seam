% Reference 9.1: eq/2 unifies terms and neq/2 succeeds on non-unifiable terms.
answer(eq_variable, ?x) :- eq(?x, pair(a, [b, c])).
answer(eq_nested, true) :- eq(pair(?x, ?x), pair(same, same)).
answer(neq_atoms, true) :- neq(alice, bob).
answer(neq_structures, true) :- neq(pair(a), pair(a, b)).
materialize(answer, 2).
