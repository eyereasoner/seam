materialize(answer, 1).
answer(?n) :- countall(missing(?x), ?n).
