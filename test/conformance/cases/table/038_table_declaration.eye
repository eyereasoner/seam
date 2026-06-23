% Reference 10.1: table/2 is a declaration and does not change answers.
materialize(reach, 2).
table(reach_any, 2).
edge(a, b).
edge(b, c).
reach_any(?x, ?y) :- edge(?x, ?y).
reach_any(?x, ?z) :- edge(?x, ?y), reach_any(?y, ?z).
reach(a, ?y) :- reach_any(a, ?y).
