% Reference 11.1: table/2 is the preferred spelling for tabled predicates.
materialize(reach, 2).
table(reach_any, 2).

edge(a, b).
edge(b, c).
edge(c, d).

reach(X, Y) :- reach_any(X, Y).
reach_any(X, Y) :- edge(X, Y).
reach_any(X, Z) :- edge(X, Y), reach_any(Y, Z).
