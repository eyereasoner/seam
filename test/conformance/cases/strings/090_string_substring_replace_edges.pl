% Reference 9.6: substring and replace have finite boundary behavior.
materialize(answer, 2).
answer(prefix, X) :- substring("seamlet", 0, 3, X).
answer(middle, X) :- substring("seamlet", 3, 2, X).
answer(suffix, X) :- substring("seamlet", 2, 3, X).
answer(empty_at_end, X) :- substring("seamlet", 7, 0, X).
answer(out_of_range_rejected, ok) :- not(substring("seamlet", 7, 2, X)).
answer(replace_all, X) :- replace("banana", "na", "NA", X).
answer(replace_missing, X) :- replace("banana", "x", "y", X).
