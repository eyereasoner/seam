% Reference 9.6: string case and trim built-ins preserve non-letter characters.
materialize(answer, 2).
answer(lower_mixed, ?x) :- lowercase("Hello WORLD 123!", ?x).
answer(upper_mixed, ?x) :- uppercase("Hello world 123!", ?x).
answer(trim_spaces, ?x) :- trim("  padded  ", ?x).
answer(trim_tabs_newline, ?x) :- trim("\tvalue\n", ?x).
answer(trim_empty, ?x) :- trim("", ?x).
