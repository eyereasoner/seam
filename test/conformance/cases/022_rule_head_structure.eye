% Reference 5.3, 6, 7.1: structured rule heads destructure matching goals.
unpack(pair(?x, ?y), ?x, ?y).
answer(first, ?a) :- unpack(pair(alpha, beta), ?a, ?_).
answer(second, ?b) :- unpack(pair(alpha, beta), ?_, ?b).
materialize(answer, 2).
