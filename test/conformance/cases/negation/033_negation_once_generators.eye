% Reference 9.5, 9.10: generators, negation as failure, and once/1.
candidate(a).
candidate(b).
closed(b).
answer(open, ?x) :- candidate(?x), not(closed(?x)).
answer(first_between, ?x) :- once(between(2, 4, ?x)).
materialize(answer, 2).
