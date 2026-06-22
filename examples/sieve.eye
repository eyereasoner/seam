% Prime enumeration inspired by Eyelet input/sieve.eye.
% The 1000-limit answer matches Eyelet output-swipl/sieve.eye.
%
% eyelang uses the built-in smallest_divisor_from/3 relation to keep the
% example fast while preserving the same generated prime list.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(primes, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
want_primes(1000).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
prime_under(?limit, ?p) :-
  between(2, ?limit, ?p),
  smallest_divisor_from(?p, 2, ?p).

primes(?limit, ?ps) :-
  want_primes(?limit),
  findall(?p, prime_under(?limit, ?p), ?ps).
