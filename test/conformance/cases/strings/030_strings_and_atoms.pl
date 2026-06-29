% Reference 9.6: atom and string built-ins.
answer(str_concat, X) :- str_concat("se", "am", X).
answer(contains, true) :- contains("seam", "ea").
materialize(answer, 2).
