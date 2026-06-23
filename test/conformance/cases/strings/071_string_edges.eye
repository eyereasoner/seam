% Reference 9.1: reusable string built-ins cover empty results and scalar list items.
materialize(answer, 2).
answer(split_missing_separator, ?x) :- split("abc", ",", ?x).
answer(split_empty_separator, ?x) :- split("abc", "", ?x).
answer(join_empty, ?x) :- join([], ",", ?x).
answer(join_numbers, ?x) :- join([1, 2, 3], "-", ?x).
answer(substring_empty, ?x) :- substring("abcdef", 2, 0, ?x).
answer(replace_empty_search, ?x) :- replace("abc", "", "x", ?x).
answer(lower_string, ?x) :- lowercase("Hello", ?x).
answer(upper_string, ?x) :- uppercase("Eyelang 123", ?x).
