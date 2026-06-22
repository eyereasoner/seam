% Graphic atoms that are not absolute IRIs remain graphic atoms.
materialize(answer, 1).
operator(<=>).
answer(?op) :- operator(?op).
