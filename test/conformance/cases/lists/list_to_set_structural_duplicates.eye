materialize(answer, 1).
answer(?x) :- list_to_set([pair(a, 1), pair(a, 1), pair(a, 2)], ?x).
