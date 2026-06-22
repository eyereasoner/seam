% Reference 7.3, 9.2, 9.5: finite arithmetic recursion works with generated ranges.
materialize(answer, 2).
even(0).
even(?n) :- gt(?n, 0), sub(?n, 1, ?m), odd(?m).
odd(?n) :- gt(?n, 0), sub(?n, 1, ?m), even(?m).
answer(even, ?n) :- between(0, 6, ?n), even(?n).
answer(odd, ?n) :- between(0, 6, ?n), odd(?n).
