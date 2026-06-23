materialize(answer, 1).
answer(forall_counterexample_fails) :- forall(member(?x, [1, 2, 3]), lt(?x, 3)).
