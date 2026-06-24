% Stirling numbers of the second kind and Bell numbers.
%
% The Stirling count S(N,K) is computed with the inclusion-exclusion formula
%   S(N,K) = (1/K!) * sum(I=0..K, (-1)^(K-I) * C(K,I) * I^N)
% instead of the overlapping two-branch recurrence.  Bell numbers use
%   B(0) = 1, B(N) = sum(K=0..N-1, C(N-1,K) * B(K)).
% The table declarations memoize the smaller helper relations used by both formulas.
materialize(stirling_bell_answer, 2).

table(factorial, 2).
table(binomial, 3).
table(stirling2, 3).
table(bell, 2).

factorial(0, 1).
factorial(?n, ?value) :-
  gt(?n, 0),
  sub(?n, 1, ?n1),
  factorial(?n1, ?previous),
  mul(?n, ?previous, ?value).

binomial(0, 0, 1).
binomial(?n, 0, 1) :- gt(?n, 0).
binomial(?n, ?n, 1) :- gt(?n, 0).
binomial(?n, ?k, ?value) :-
  gt(?n, 0),
  gt(?k, 0),
  lt(?k, ?n),
  sub(?n, 1, ?n1),
  sub(?k, 1, ?k1),
  binomial(?n1, ?k1, ?left),
  binomial(?n1, ?k, ?right),
  add(?left, ?right, ?value).

signed_term(?n, ?k, ?i, ?term) :-
  binomial(?k, ?i, ?c),
  pow(?i, ?n, ?p),
  mul(?c, ?p, ?unsigned),
  sub(?k, ?i, ?d),
  mod(?d, 2, 0),
  eq(?term, ?unsigned).
signed_term(?n, ?k, ?i, ?term) :-
  binomial(?k, ?i, ?c),
  pow(?i, ?n, ?p),
  mul(?c, ?p, ?unsigned),
  sub(?k, ?i, ?d),
  mod(?d, 2, 1),
  neg(?unsigned, ?term).

stirling2(0, 0, 1).
stirling2(?n, 0, 0) :- gt(?n, 0).
stirling2(0, ?k, 0) :- gt(?k, 0).
stirling2(?n, ?k, ?count) :-
  gt(?n, 0),
  gt(?k, 0),
  sumall(?term, (between(0, ?k, ?i), signed_term(?n, ?k, ?i, ?term)), ?sum),
  factorial(?k, ?factorial),
  div(?sum, ?factorial, ?count).

bell(0, 1).
bell(?n, ?count) :-
  gt(?n, 0),
  sub(?n, 1, ?n1),
  sumall(?term, (between(0, ?n1, ?k), binomial(?n1, ?k, ?choose), bell(?k, ?bell), mul(?choose, ?bell, ?term)), ?count).

stirling_bell_answer(stirling_10_4, ?count) :- stirling2(10, 4, ?count).
stirling_bell_answer(stirling_12_5, ?count) :- stirling2(12, 5, ?count).
stirling_bell_answer(bell_10, ?count) :- bell(10, ?count).
stirling_bell_answer(bell_12, ?count) :- bell(12, ?count).
