materialize(answer, 1).
table(reachable, 2).
edge(a, b).
edge(b, c).
reachable(?x, ?z) :- reachable(?x, ?y), edge(?y, ?z).
reachable(?x, ?y) :- edge(?x, ?y).
answer(?x) :- reachable(a, ?x).
