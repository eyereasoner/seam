materialize(answer, 3).
left(a).
right(a, one).
right(a, two).
answer(left_to_right_multiple_bindings, ?x, ?y) :- left(?x), right(?x, ?y).
