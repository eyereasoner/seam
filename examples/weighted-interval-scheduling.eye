% Weighted interval scheduling via tabled dynamic programming.
%
% Intervals are ordered by finish time.  best_from(I,Best) compares the two
% choices at position I: skip it, or take it and jump to the next compatible
% interval.  chosen_from/2 then walks the tabled decisions to report a schedule.
materialize(weighted_interval_answer, 2).

table(best_from, 2).

last_interval(8).
sentinel(9).

interval(1, 1, 4, 5).
interval(2, 3, 5, 1).
interval(3, 0, 6, 8).
interval(4, 4, 7, 4).
interval(5, 3, 9, 6).
interval(6, 5, 9, 3).
interval(7, 6, 10, 2).
interval(8, 8, 11, 4).

% Find the earliest later interval whose start is not before I's finish.
next_compatible(?i, ?j) :-
  interval(?i, ?_start, ?finish, ?_value),
  aggregate_min(?k, ?k,
    (interval(?k, ?startk, ?_finishk, ?_valuek), gt(?k, ?i), ge(?startk, ?finish)),
    ?j, ?j).
next_compatible(?i, 9) :-
  interval(?i, ?_start, ?finish, ?_value),
  not((interval(?k, ?startk, ?_finishk, ?_valuek), gt(?k, ?i), ge(?startk, ?finish))).

best_from(9, 0).
best_from(?i, ?best) :-
  last_interval(?last),
  le(?i, ?last),
  add(?i, 1, ?next),
  best_from(?next, ?skip),
  next_compatible(?i, ?compatible),
  best_from(?compatible, ?tail),
  interval(?i, ?_start, ?_finish, ?value),
  add(?value, ?tail, ?take),
  max(?take, ?skip, ?best).

% Reconstruction emits an interval when the take branch matches the optimal value.
chosen_from(?i, ?i) :-
  best_from(?i, ?best),
  add(?i, 1, ?next),
  best_from(?next, ?skip),
  next_compatible(?i, ?compatible),
  best_from(?compatible, ?tail),
  interval(?i, ?_start, ?_finish, ?value),
  add(?value, ?tail, ?take),
  eq(?best, ?take),
  ge(?take, ?skip).
chosen_from(?i, ?chosen) :-
  best_from(?i, ?best),
  add(?i, 1, ?next),
  best_from(?next, ?skip),
  next_compatible(?i, ?compatible),
  best_from(?compatible, ?tail),
  interval(?i, ?_start, ?_finish, ?value),
  add(?value, ?tail, ?take),
  eq(?best, ?take),
  ge(?take, ?skip),
  chosen_from(?compatible, ?chosen).
chosen_from(?i, ?chosen) :-
  best_from(?i, ?best),
  add(?i, 1, ?next),
  best_from(?next, ?skip),
  next_compatible(?i, ?compatible),
  best_from(?compatible, ?tail),
  interval(?i, ?_start, ?_finish, ?value),
  add(?value, ?tail, ?take),
  gt(?skip, ?take),
  chosen_from(?next, ?chosen).

weighted_interval_answer(best_value, ?best) :- best_from(1, ?best).
weighted_interval_answer(chosen_interval, interval(?i, ?start, ?finish, ?value)) :-
  chosen_from(1, ?i),
  interval(?i, ?start, ?finish, ?value).
weighted_interval_answer(candidate_count, ?count) :- countall(interval(?_i, ?_start, ?_finish, ?_value), ?count).
