materialize(answer, 2).
val(1.5).
val(2.25).
answer(sumall_float_template, ?sum) :- sumall(?x, val(?x), ?sum).
