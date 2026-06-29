% `table/2` is a search-control declaration and does not change answers.
materialize(path, 2).
table(path, 2).
edge(a, b).
edge(b, c).
path(X, Y) :- edge(X, Y).
path(X, Z) :- edge(X, Y), path(Y, Z).
