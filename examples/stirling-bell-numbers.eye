% Stirling numbers of the second kind and Bell numbers.
%
% stirling2(N, K, Count) counts partitions of N labelled elements into K nonempty blocks.
% The recurrence either places the newest labelled element into a new singleton block or into
% one of the K existing blocks.  bell/2 then sums a whole row of Stirling numbers.
% Memoization turns the overlapping recurrence into a small dynamic-programming table.
materialize(stirling_bell_answer, 2).

table(stirling2, 3).

% Boundary cases define the empty partition and the impossible zero-block columns.
stirling2(0, 0, 1).
stirling2(?n, 0, 0) :- gt(?n, 0).
stirling2(0, ?k, 0) :- gt(?k, 0).
stirling2(?n, ?k, ?count) :-
  gt(?n, 0),
  gt(?k, 0),
  sub(?n, 1, ?n1),
  sub(?k, 1, ?k1),
  stirling2(?n1, ?k1, ?newblock),
  stirling2(?n1, ?k, ?existingblocks),
  mul(?k, ?existingblocks, ?extended),
  add(?newblock, ?extended, ?count).

% Bell(N) is the row sum S(N,0)+...+S(N,N).
bell(?n, ?count) :-
  sumall(?s, (between(0, ?n, ?k), stirling2(?n, ?k, ?s)), ?count).

stirling_bell_answer(stirling_10_4, ?count) :- stirling2(10, 4, ?count).
stirling_bell_answer(stirling_12_5, ?count) :- stirling2(12, 5, ?count).
stirling_bell_answer(bell_10, ?count) :- bell(10, ?count).
stirling_bell_answer(bell_12, ?count) :- bell(12, ?count).
