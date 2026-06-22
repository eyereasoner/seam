% Science example: radioactive decay.
%
% Activity remaining after elapsed time is initial_activity * 0.5^(t/half_life).
% The file materializes half-lives elapsed, remaining activity, decayed activity,
% and a threshold-based low-activity status.
materialize(halfLivesElapsed, 2).
materialize(remainingActivity_Bq, 2).
materialize(decayedActivity_Bq, 2).
materialize(status, 2).
materialize(reason, 2).

% The iodine sample has elapsed for two half-lives, making the expected remaining
% activity one quarter of the initial activity.
sample(iodine_sample, initial_activity_bq, 80.0).
sample(iodine_sample, half_life_h, 8.0).
sample(iodine_sample, elapsed_h, 16.0).
threshold(iodine_sample, low_activity_bq, 25.0).

% The derivation first computes elapsed half-lives, then a remaining fraction,
% and finally converts that fraction into Bq.
half_lives(?sample, ?count) :-
  sample(?sample, elapsed_h, ?elapsed),
  sample(?sample, half_life_h, ?halflife),
  div(?elapsed, ?halflife, ?count).

remaining_fraction(?sample, ?fraction) :-
  half_lives(?sample, ?count),
  pow(0.5, ?count, ?fraction).

remaining_activity(?sample, ?remaining) :-
  sample(?sample, initial_activity_bq, ?initial),
  remaining_fraction(?sample, ?fraction),
  mul(?initial, ?fraction, ?remaining).

decayed_activity(?sample, ?decayed) :-
  sample(?sample, initial_activity_bq, ?initial),
  remaining_activity(?sample, ?remaining),
  sub(?initial, ?remaining, ?decayed).

low_activity(?sample) :-
  remaining_activity(?sample, ?remaining),
  threshold(?sample, low_activity_bq, ?limit),
  lt(?remaining, ?limit).

halfLivesElapsed(?sample, ?count) :-
  half_lives(?sample, ?count).

remainingActivity_Bq(?sample, ?remaining) :-
  remaining_activity(?sample, ?remaining).

decayedActivity_Bq(?sample, ?decayed) :-
  decayed_activity(?sample, ?decayed).

status(?sample, low_activity) :-
  low_activity(?sample).

reason(?sample, "two half-lives leave one quarter of the initial activity") :-
  low_activity(?sample).
