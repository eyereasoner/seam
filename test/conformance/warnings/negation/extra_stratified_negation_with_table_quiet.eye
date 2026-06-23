materialize(open, 1).
table(path, 2).
edge(a, b).
path(?x, ?y) :- edge(?x, ?y).
closed(c).
open(?x) :- path(a, ?x), not(closed(?x)).
