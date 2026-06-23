materialize(answer, 2).
answer(join_empty_list, ?x) :- join([], ",", ?x).
