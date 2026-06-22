materialize(answer, 1).
answer(?parts) :- split("abc", ",", ?parts).
