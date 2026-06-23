% Reference 6, 7: definite clauses, conjunction, and recursive proof search.
materialize(ancestor, 2).
parent(pat, jan).
parent(jan, emma).
ancestor_any(?x, ?y) :- parent(?x, ?y).
ancestor_any(?x, ?z) :- parent(?x, ?y), ancestor_any(?y, ?z).
ancestor(pat, ?y) :- ancestor_any(pat, ?y).
