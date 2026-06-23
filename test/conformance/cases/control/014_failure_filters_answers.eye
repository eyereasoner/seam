% Reference 7.2: a failing subgoal removes that candidate answer.
candidate(a).
candidate(b).
allowed(a).
answer(?x, ok) :- candidate(?x), allowed(?x).

materialize(answer, 2).
