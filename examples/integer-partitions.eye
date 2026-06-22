% Integer partition counts by tabled dynamic programming.
%
% partitions(N, K, Count) counts unordered sums of N using parts no larger than K.
% The two recursive branches are the standard include-K / exclude-K split.  Without
% memoization the same (N,K) subproblems are reached many times.
materialize(partition_answer, 2).

table(partitions, 3).

% One empty sum partitions zero; positive N with K=0 is impossible.
partitions(0, ?_k, 1).
partitions(?n, 0, 0) :- gt(?n, 0).
partitions(?n, ?k, ?count) :-
  gt(?n, 0),
  gt(?k, 0),
  gt(?k, ?n),
  sub(?k, 1, ?k1),
  partitions(?n, ?k1, ?count).
partitions(?n, ?k, ?count) :-
  gt(?n, 0),
  gt(?k, 0),
  le(?k, ?n),
  sub(?n, ?k, ?remainder),
  partitions(?remainder, ?k, ?withk),
  sub(?k, 1, ?k1),
  partitions(?n, ?k1, ?withoutk),
  add(?withk, ?withoutk, ?count).

% The ordinary partition number p(N) allows all parts up to N.
partition_count(?n, ?count) :- partitions(?n, ?n, ?count).

partition_answer(p_12, ?count) :- partition_count(12, ?count).
partition_answer(p_15, ?count) :- partition_count(15, ?count).
partition_answer(p_16_using_parts_at_most_5, ?count) :- partitions(16, 5, ?count).
partition_answer(cumulative_p_1_to_8, ?sum) :- sumall(?c, (between(1, 8, ?n), partition_count(?n, ?c)), ?sum).
