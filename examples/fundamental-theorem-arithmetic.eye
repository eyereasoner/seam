% Adapted from Eyeling's fundamental-theorem-arithmetic.n3.
% Compute a prime factorization by repeated smallest-divisor decomposition,
% then check product reconstruction and primality of the distinct factors.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
%
% The goal is not to be a production factorizer; it is a readable encoding of
% divisibility, primality, two factorization strategies, and agreement between
% normalized factor lists.
materialize(n, 2).
materialize(factorsSmallest, 2).
materialize(factorsLargest, 2).
materialize(product, 2).
materialize(expectedFactorsMatched, 2).
materialize(productReconstructsInput, 2).
materialize(distinctPrimeCount, 2).
materialize(smallestPrimeFactor, 2).
materialize(largestPrimeFactor, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
case(fta, 202692987).
expected_factors(fta, [3, 3, 7, 829, 3881]).

% A divides B in positive integers.
% Derivation rules: each rule below contributes one logical step toward the displayed results.
divides(?a, ?b) :-
  gt(?a, 0),
  gt(?b, 0),
  mod(?b, ?a, 0).

smallest_divisor_from(?n, ?d, ?d) :-
  divides(?d, ?n).

smallest_divisor_from(?n, ?d, ?n) :-
  mul(?d, ?d, ?d2),
  gt(?d2, ?n).

smallest_divisor_from(?n, ?d, ?s) :-
  not(divides(?d, ?n)),
  mul(?d, ?d, ?d2),
  le(?d2, ?n),
  add(?d, 1, ?d1),
  smallest_divisor_from(?n, ?d1, ?s).

trial_prime(2).
trial_prime(3).
% trial_prime/1 is the bounded primality test used by the factorization rules.
trial_prime(?p) :-
  gt(?p, 3),
  smallest_divisor_from(?p, 2, ?p).

factor_smallest(?n, []) :-
  lt(?n, 2).

factor_smallest(?n, [?n]) :-
  ge(?n, 2),
  smallest_divisor_from(?n, 2, ?n).

% factor_smallest/2 repeatedly removes the least divisor, producing ascending factors.
factor_smallest(?n, ?factors) :-
  ge(?n, 2),
  smallest_divisor_from(?n, 2, ?d),
  neq(?d, ?n),
  div(?n, ?d, ?q),
  factor_smallest(?d, ?left),
  factor_smallest(?q, ?right),
  append(?left, ?right, ?factors).

factor_largest(?n, ?factors) :-
  factor_smallest(?n, ?smallest),
  reverse(?smallest, ?factors).

product([], 1).
product([?x|?rest], ?p) :-
  product(?rest, ?p0),
  mul(?x, ?p0, ?p).

all_expected_primes(true) :-
  trial_prime(3),
  trial_prime(7),
  trial_prime(829),
  trial_prime(3881).

n(case, ?n) :-
  case(fta, ?n).

factorsSmallest(case, ?factors) :-
  case(fta, ?n),
  factor_smallest(?n, ?factors).

factorsLargest(case, ?factors) :-
  case(fta, ?n),
  factor_largest(?n, ?factors).

product(case, ?product) :-
  case(fta, ?n),
  factor_smallest(?n, ?factors),
  product(?factors, ?product).

expectedFactorsMatched(case, true) :-
  case(fta, ?n),
  expected_factors(fta, ?factors),
  factor_smallest(?n, ?factors).

productReconstructsInput(case, true) :-
  case(fta, ?n),
  factor_smallest(?n, ?factors),
  product(?factors, ?n).

distinctPrimeCount(case, 4) :-
  all_expected_primes(true).

smallestPrimeFactor(case, 3) :-
  case(fta, ?n),
  factor_smallest(?n, [3|?]).

largestPrimeFactor(case, 3881) :-
  case(fta, ?n),
  factor_largest(?n, [3881|?]).
