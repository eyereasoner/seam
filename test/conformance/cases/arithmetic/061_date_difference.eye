% Reference 9.1: difference/3 computes ISO date durations.
answer(duration, ?d) :- difference("2024-03-01", "2020-02-29", ?d).
answer(month_borrow, ?d) :- difference("2024-03-01", "2024-01-31", ?d).
materialize(answer, 2).
