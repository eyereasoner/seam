materialize(answer, 1).
answer(forall_bound_check) :- forall(member(?x, [1, 2, 3]), lt(?x, 4)).
