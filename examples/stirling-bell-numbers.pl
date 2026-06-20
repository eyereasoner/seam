% Stirling numbers of the second kind and Bell numbers.
%
% stirling2(N, K, Count) counts partitions of N labelled elements into K nonempty blocks.
% The recurrence either places the newest labelled element into a new singleton block or into
% one of the K existing blocks.  bell/2 then sums a whole row of Stirling numbers.
% Memoization turns the overlapping recurrence into a small dynamic-programming table.
materialize(stirling_bell_answer, 2).

memoize(stirling2, 3).

% Boundary cases define the empty partition and the impossible zero-block columns.
stirling2(0, 0, 1).
stirling2(N, 0, 0) :- gt(N, 0).
stirling2(0, K, 0) :- gt(K, 0).
stirling2(N, K, Count) :-
  gt(N, 0),
  gt(K, 0),
  sub(N, 1, N1),
  sub(K, 1, K1),
  stirling2(N1, K1, NewBlock),
  stirling2(N1, K, ExistingBlocks),
  mul(K, ExistingBlocks, Extended),
  add(NewBlock, Extended, Count).

% Bell(N) is the row sum S(N,0)+...+S(N,N).
bell(N, Count) :-
  sumall(S, (between(0, N, K), stirling2(N, K, S)), Count).

stirling_bell_answer(stirling_10_4, Count) :- stirling2(10, 4, Count).
stirling_bell_answer(stirling_12_5, Count) :- stirling2(12, 5, Count).
stirling_bell_answer(bell_10, Count) :- bell(10, Count).
stirling_bell_answer(bell_12, Count) :- bell(12, Count).
