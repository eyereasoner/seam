% Reference 9.1: reusable list relations enumerate in stable left-to-right order.
materialize(answer, 2).
answer(append_split, pair(?prefix, ?suffix)) :- append(?prefix, ?suffix, [a, b]).
answer(nth, pair(?index, ?value)) :- nth0(?index, [x, y], ?value).
answer(select, pair(?value, ?rest)) :- select(?value, [a, b, a], ?rest).
answer(not_member_atom, ok) :- not_member(z, [a, b, c]).
answer(not_member_unifiable_rejected, ok) :- not(not_member(pair(?x), [pair(a)])).
