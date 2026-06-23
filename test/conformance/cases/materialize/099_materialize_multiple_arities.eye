% Reference 11.2 and 13: materialize/2 can select several predicate arities explicitly.
materialize(answer, 1).
materialize(answer, 2).
seed(a).
seed(b).
answer(?x) :- seed(?x).
answer(?x, doubled) :- seed(?x).
answer(hidden, ?x, ?y) :- seed(?x), seed(?y).
