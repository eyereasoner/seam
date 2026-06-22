% Reference 9.7, 9.8: list, aggregation, and ordering built-ins.
answer(member, ?x) :- member(?x, [a, b]).
answer(append, ?x) :- append([a], [b, c], ?x).
answer(nth0, ?x) :- nth0(1, [a, b, c], ?x).
answer(set_nth0, ?x) :- set_nth0(1, [a, b, c], x, ?x).
answer(reverse, ?x) :- reverse([a, b, c], ?x).
answer(length, ?n) :- length([a, b, c], ?n).
answer(findall, ?x) :- findall(?n, between(1, 3, ?n), ?x).
answer(sort, ?x) :- sort([b, a, b], ?x).
materialize(answer, 2).
