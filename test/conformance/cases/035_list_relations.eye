% Reference 9.7: rest/2, select/3, and not_member/2.
answer(rest, ?x) :- rest([a, b, c], ?x).
answer(select, selected(?x, ?r)) :- select(?x, [a, b], ?r).
answer(not_member, true) :- not_member(c, [a, b]).
materialize(answer, 2).
