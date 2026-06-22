% Reference 9.10: not/1 succeeds when the subgoal has no proof.
candidate(a).
candidate(b).
candidate(c).
blocked(b).
answer(open, ?x) :- candidate(?x), not(blocked(?x)).
materialize(answer, 2).
