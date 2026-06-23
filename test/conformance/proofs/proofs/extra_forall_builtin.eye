materialize(answer, 1).
answer(forall_builtin) :- forall(member(?x, [1, 2]), lt(?x, 3)).
