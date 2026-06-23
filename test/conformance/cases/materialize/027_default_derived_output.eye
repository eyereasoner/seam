% Reference 11: default output prints new ground binary derivations, not source facts.
parent(pat, jan).
parent(jan, emma).
ancestor(?x, ?y) :- parent(?x, ?y).
ancestor(?x, ?z) :- parent(?x, ?y), ancestor(?y, ?z).
