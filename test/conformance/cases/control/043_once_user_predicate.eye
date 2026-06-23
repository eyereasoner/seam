% Reference 9.10: once/1 keeps at most the first solution from a user predicate.
choice(a).
choice(b).
answer(first, ?x) :- once(choice(?x)).
materialize(answer, 2).
