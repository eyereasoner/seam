materialize(answer, 2).
answer(once_preserves_binding, ?x) :- once(member(?x, [a, b])).
