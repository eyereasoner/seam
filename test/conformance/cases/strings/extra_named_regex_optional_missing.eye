materialize(answer, 2).
answer(named_regex_optional_missing, ?x) :- matches("abc", "(?<first>a)(?<missing>z)?", ?x).
