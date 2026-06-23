% Reference 6, 7: multiple clauses for one predicate are explored as alternatives.
color(red).
color(blue).
paint(?x) :- color(?x).
answer(color, ?x) :- paint(?x).
materialize(answer, 2).
