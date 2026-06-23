% Reference 11: default materialization excludes source facts even if also derivable.
materialize(answer, 2).
seed(a).
answer(a, ok).
answer(?x, ok) :- seed(?x).
answer(b, ok) :- seed(a).
