materialize(answer, 1).
answer(?text) :- substring("abcdef", 2, 0, ?text).
