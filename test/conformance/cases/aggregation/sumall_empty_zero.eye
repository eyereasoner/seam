materialize(answer, 1).
answer(?n) :- sumall(?x, missing(?x), ?n).
