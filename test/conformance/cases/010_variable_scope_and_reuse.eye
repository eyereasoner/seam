% Reference 5.1, 7.1: variable occurrences are scoped per clause and reused within a clause.
edge(a, b).
edge(b, c).
edge(c, d).
two_step(?x, ?z) :- edge(?x, ?y), edge(?y, ?z).
answer(from_a, ?z) :- two_step(a, ?z).
answer(from_b, ?z) :- two_step(b, ?z).
materialize(answer, 2).
