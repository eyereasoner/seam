% Reference 9.7: nth0/3 can bind the index for a known list element.
answer(index, ?i) :- nth0(?i, [a, b, c], b).
materialize(answer, 2).
