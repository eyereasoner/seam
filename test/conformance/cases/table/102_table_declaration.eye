% Reference 11.1: table/2 is the preferred spelling for tabled predicates.
materialize(reach, 2).
table(reach_any, 2).

edge(a, b).
edge(b, c).
edge(c, d).

reach(?x, ?y) :- reach_any(?x, ?y).
reach_any(?x, ?y) :- edge(?x, ?y).
reach_any(?x, ?z) :- edge(?x, ?y), reach_any(?y, ?z).
