% Integer partition counts by memoized dynamic programming.
% partitions(N, K, Count) counts partitions of N using parts no larger than K.
materialize(partition_answer, 2).

memoize(partitions, 3).

partitions(0, _K, 1).
partitions(N, 0, 0) :- gt(N, 0).
partitions(N, K, Count) :-
  gt(N, 0),
  gt(K, 0),
  gt(K, N),
  sub(K, 1, K1),
  partitions(N, K1, Count).
partitions(N, K, Count) :-
  gt(N, 0),
  gt(K, 0),
  le(K, N),
  sub(N, K, Remainder),
  partitions(Remainder, K, WithK),
  sub(K, 1, K1),
  partitions(N, K1, WithoutK),
  add(WithK, WithoutK, Count).

partition_count(N, Count) :- partitions(N, N, Count).

partition_answer(p_12, Count) :- partition_count(12, Count).
partition_answer(p_15, Count) :- partition_count(15, Count).
partition_answer(p_16_using_parts_at_most_5, Count) :- partitions(16, 5, Count).
partition_answer(cumulative_p_1_to_8, Sum) :- sumall(C, (between(1, 8, N), partition_count(N, C)), Sum).
