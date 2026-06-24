% Prime ranges and Euler totient over finite integer domains.
%
% The source example combines prime search with Euler's totient function.  This
% Eyelang version keeps the computation finite and declarative: composite
% numbers are described by proper divisors, primes are candidates that are not
% composite, and `totient/2` counts numbers coprime with the input.

materialize(prime_result, 2).
table(gcd, 3).

candidate(?n) :-
  between(2, 30, ?n).

composite(?n) :-
  candidate(?n),
  between(2, ?n, ?d),
  lt(?d, ?n),
  mod(?n, ?d, 0).

prime(?n) :-
  candidate(?n),
  not(composite(?n)).

% Euclid's algorithm, used for the totient calculation.
gcd(?n, 0, ?n).
gcd(?n, ?m, ?g) :-
  gt(?m, 0),
  mod(?n, ?m, ?r),
  gcd(?m, ?r, ?g).

coprime(?n, ?k) :-
  between(1, ?n, ?k),
  gcd(?n, ?k, 1).

totient(?n, ?phi) :-
  countall(coprime(?n, ?_k), ?phi).

prime_result(range_2_30, ?primes) :-
  findall(?p, prime(?p), ?primes).

prime_result(count_2_30, ?count) :-
  countall(prime(?p), ?count).

prime_result(totient_271, ?phi) :-
  totient(271, ?phi).
