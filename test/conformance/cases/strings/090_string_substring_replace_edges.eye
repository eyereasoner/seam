% Reference 9.6: substring and replace have finite boundary behavior.
materialize(answer, 2).
answer(prefix, ?x) :- substring("eyelang", 0, 3, ?x).
answer(middle, ?x) :- substring("eyelang", 3, 2, ?x).
answer(suffix, ?x) :- substring("eyelang", 2, 3, ?x).
answer(empty_at_end, ?x) :- substring("eyelang", 7, 0, ?x).
answer(out_of_range_rejected, ok) :- not(substring("eyelang", 7, 2, ?x)).
answer(replace_all, ?x) :- replace("banana", "na", "NA", ?x).
answer(replace_missing, ?x) :- replace("banana", "x", "y", ?x).
