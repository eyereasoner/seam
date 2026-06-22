% Reference 7: recursive definite clauses can derive paths beyond one step.
link(a, b).
link(b, c).
link(c, d).
path(?x, ?y) :- link(?x, ?y).
path(?x, ?z) :- link(?x, ?y), path(?y, ?z).
answer(reachable, ?x) :- path(a, ?x).
materialize(answer, 2).
