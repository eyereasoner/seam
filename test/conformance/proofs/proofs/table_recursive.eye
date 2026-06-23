% Reference 12: tabled recursive proofs still explain the successful derivation path.
materialize(path, 2).
table(path, 2).
edge(a, b).
edge(b, c).
path(?x, ?y) :- edge(?x, ?y).
path(?x, ?z) :- edge(?x, ?y), path(?y, ?z).
