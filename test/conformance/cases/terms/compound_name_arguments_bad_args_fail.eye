materialize(answer, 1).
answer(ok) :- not(compound_name_arguments(?x, pair, [a | b])).
