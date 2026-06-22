materialize(answer, 1).
answer(?x) :- compound_name_arguments(?x, pair, [a, b]).
