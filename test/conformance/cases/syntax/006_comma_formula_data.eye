% Reference 5.5: comma terms remain data outside goal position.
record((name(alice, "Alice"), knows(alice, bob))).
answer(formula, ?f) :- record(?f).
materialize(answer, 2).
