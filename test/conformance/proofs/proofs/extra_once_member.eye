materialize(answer, 2).
answer(once_member, ?x) :- once(member(?x, [a, b, c])).
