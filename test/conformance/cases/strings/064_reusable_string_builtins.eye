% Reference 9.1: reusable string normalization, splitting, joining, replacement, and conversions.
materialize(answer, 2).
answer(trim, ?x) :- trim("  Hello Eyelang  ", ?x).
answer(lower, ?x) :- lowercase("Hello Eyelang", ?x).
answer(upper, ?x) :- uppercase("Hello Eyelang", ?x).
answer(split, ?x) :- split("red,green,blue", ",", ?x).
answer(join, ?x) :- join([red, green, blue], ":", ?x).
answer(substring, ?x) :- substring("abcdef", 2, 3, ?x).
answer(replace, ?x) :- replace("red-green-red", "red", "blue", ?x).
answer(number_to_string, ?x) :- number_string(42, ?x).
answer(string_to_number, ?x) :- number_string(?x, "3.5").
answer(atom_string, ?x) :- atom_string(eyelang, ?x).
