materialize(answer, 1).
answer(?text) :- replace("abc", "", "X", ?text).
