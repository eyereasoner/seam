materialize(answer, 1).
answer(ok) :- forall(missing(?x), fail(?x)).
