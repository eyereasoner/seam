materialize(answer, 1).
helper(a).
helper(b).
answer(?x) :- helper(?x).
answer(?x) :- helper(?x), eq(?x, c).
