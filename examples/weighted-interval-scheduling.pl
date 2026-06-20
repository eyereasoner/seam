% Weighted interval scheduling via memoized dynamic programming.
% Intervals are already ordered by finish time; best_from/2 chooses take/skip.
materialize(weighted_interval_answer, 2).

memoize(best_from, 2).

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

next_compatible(I, J) :-
  interval(I, _Start, Finish, _Value),
  aggregate_min(K, K,
    (interval(K, StartK, _FinishK, _ValueK), gt(K, I), ge(StartK, Finish)),
    J, J).
next_compatible(I, 9) :-
  interval(I, _Start, Finish, _Value),
  not((interval(K, StartK, _FinishK, _ValueK), gt(K, I), ge(StartK, Finish))).

best_from(9, 0).
best_from(I, Best) :-
  last_interval(Last),
  le(I, Last),
  add(I, 1, Next),
  best_from(Next, Skip),
  next_compatible(I, Compatible),
  best_from(Compatible, Tail),
  interval(I, _Start, _Finish, Value),
  add(Value, Tail, Take),
  max(Take, Skip, Best).

chosen_from(I, I) :-
  best_from(I, Best),
  add(I, 1, Next),
  best_from(Next, Skip),
  next_compatible(I, Compatible),
  best_from(Compatible, Tail),
  interval(I, _Start, _Finish, Value),
  add(Value, Tail, Take),
  eq(Best, Take),
  ge(Take, Skip).
chosen_from(I, Chosen) :-
  best_from(I, Best),
  add(I, 1, Next),
  best_from(Next, Skip),
  next_compatible(I, Compatible),
  best_from(Compatible, Tail),
  interval(I, _Start, _Finish, Value),
  add(Value, Tail, Take),
  eq(Best, Take),
  ge(Take, Skip),
  chosen_from(Compatible, Chosen).
chosen_from(I, Chosen) :-
  best_from(I, Best),
  add(I, 1, Next),
  best_from(Next, Skip),
  next_compatible(I, Compatible),
  best_from(Compatible, Tail),
  interval(I, _Start, _Finish, Value),
  add(Value, Tail, Take),
  gt(Skip, Take),
  chosen_from(Next, Chosen).

weighted_interval_answer(best_value, Best) :- best_from(1, Best).
weighted_interval_answer(chosen_interval, interval(I, Start, Finish, Value)) :-
  chosen_from(1, I),
  interval(I, Start, Finish, Value).
weighted_interval_answer(candidate_count, Count) :- countall(interval(_I, _Start, _Finish, _Value), Count).
