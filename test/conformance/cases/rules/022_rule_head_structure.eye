% Reference 5.3, 6, 7.1: structured rule heads destructure matching goals.
unpack(pair(?x, ?y), ?x, ?y).
answer(first, ?a) :- unpack(pair(alpha, beta), ?a, ?).
answer(second, ?b) :- unpack(pair(alpha, beta), ?, ?b).
materialize(answer, 2).
