materialize(answer, 2).
num(1).
num(2).
num(3).
answer(countall_with_filter, ?n) :- countall((num(?x), gt(?x, 1)), ?n).
