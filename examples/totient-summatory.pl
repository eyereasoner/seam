% Euler totients and coprimality by memoized Euclidean gcd.
% This is still ordinary Horn-clause search: phi(N) is the count of K <= N
% with gcd(N, K) = 1.
materialize(totient_answer, 2).

memoize(gcd, 3).
memoize(totient, 2).

gcd(A, 0, A) :- ge(A, 0).
gcd(A, B, G) :-
  gt(B, 0),
  mod(A, B, R),
  gcd(B, R, G).

coprime_upto(N, K) :-
  between(1, N, K),
  gcd(N, K, 1).

totient(N, Count) :-
  gt(N, 0),
  countall(coprime_upto(N, _K), Count).

summatory_totient(Limit, Sum) :-
  sumall(Phi, (between(1, Limit, N), totient(N, Phi)), Sum).

totient_answer(phi_36, Phi) :- totient(36, Phi).
totient_answer(phi_97, Phi) :- totient(97, Phi).
totient_answer(coprime_count_84, Count) :- totient(84, Count).
totient_answer(summatory_phi_30, Sum) :- summatory_totient(30, Sum).
