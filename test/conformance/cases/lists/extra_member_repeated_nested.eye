materialize(answer, 2).
answer(member_repeated_nested, ?x) :- member(pair(?x, ?x), [pair(a, a), pair(a, b), pair(b, b)]).
