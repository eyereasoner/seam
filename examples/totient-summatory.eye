% Euler totients and coprimality by tabled Euclidean gcd.
%
% phi(N) is modeled directly as the count of integers K in 1..N with gcd(N,K)=1.
% The summatory query reuses many gcd/totient subgoals, so memoization keeps the
% example responsive while preserving the relational presentation.
materialize(totient_answer, 2).

table(gcd, 3).
table(totient, 2).

% Euclid's algorithm is expressed recursively over remainders.
gcd(?a, 0, ?a) :- ge(?a, 0).
gcd(?a, ?b, ?g) :-
  gt(?b, 0),
  mod(?a, ?b, ?r),
  gcd(?b, ?r, ?g).

coprime_upto(?n, ?k) :-
  between(1, ?n, ?k),
  gcd(?n, ?k, 1).

% Count the finite coprime generator instead of constructing an explicit list.
totient(?n, ?count) :-
  gt(?n, 0),
  countall(coprime_upto(?n, ?_k), ?count).

summatory_totient(?limit, ?sum) :-
  sumall(?phi, (between(1, ?limit, ?n), totient(?n, ?phi)), ?sum).

totient_answer(phi_36, ?phi) :- totient(36, ?phi).
totient_answer(phi_97, ?phi) :- totient(97, ?phi).
totient_answer(coprime_count_84, ?count) :- totient(84, ?count).
totient_answer(summatory_phi_30, ?sum) :- summatory_totient(30, ?sum).
