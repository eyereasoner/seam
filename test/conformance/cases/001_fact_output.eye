% Reference 6, 7, 11: facts can be exposed through a materialized derived predicate.
materialize(parent, 2).
base_parent(pat, jan).
parent(?x, ?y) :- base_parent(?x, ?y).
