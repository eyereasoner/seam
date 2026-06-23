% Reference 9.1: string/atom/number conversions are deterministic in documented modes.
materialize(answer, 2).
answer(number_to_string, ?x) :- number_string(-7, ?x).
answer(string_to_integer, ?x) :- number_string(?x, "123").
answer(string_to_decimal, ?x) :- number_string(?x, "-3.5").
answer(non_numeric_rejected, ok) :- not(number_string(?x, "abc")).
answer(atom_to_string, ?x) :- atom_string(hello_world, ?x).
answer(string_to_atom, ?x) :- atom_string(?x, "hello_world").
answer(number_to_atom, ?x) :- atom_string(?x, 123).
answer(trim_to_empty, ?x) :- trim("   ", ?x).
