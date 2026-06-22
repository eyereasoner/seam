% Modular exponentiation by repeated squaring.
%
% pow_mod(Base, Exp, Modulus, Result) uses the even/odd exponent split, giving
% logarithmic-depth arithmetic.  Memoization matters when the same modular powers
% are reused by Fermat-style congruence checks.
materialize(modular_answer, 2).

table(pow_mod, 4).

% Base case: any nonzero base to exponent zero is 1 modulo Mod.
pow_mod(?_base, 0, ?mod, ?result) :- mod(1, ?mod, ?result).
pow_mod(?base, ?exp, ?modulus, ?result) :-
  gt(?exp, 0),
  mod(?exp, 2, 0),
  div(?exp, 2, ?half),
  pow_mod(?base, ?half, ?modulus, ?halfpower),
  mul(?halfpower, ?halfpower, ?square),
  mod(?square, ?modulus, ?result).
pow_mod(?base, ?exp, ?modulus, ?result) :-
  gt(?exp, 0),
  mod(?exp, 2, 1),
  sub(?exp, 1, ?evenexp),
  pow_mod(?base, ?evenexp, ?modulus, ?evenpower),
  mul(?base, ?evenpower, ?product),
  mod(?product, ?modulus, ?result).

% This is a Fermat congruence check, not a full primality proof.
fermat_witness(?base, ?primecandidate) :-
  sub(?primecandidate, 1, ?exponent),
  pow_mod(?base, ?exponent, ?primecandidate, 1).

modular_answer(pow_7_560_mod_561, ?r) :- pow_mod(7, 560, 561, ?r).
modular_answer(pow_2_1000_mod_1009, ?r) :- pow_mod(2, 1000, 1009, ?r).
modular_answer(fermat_2_101, true) :- fermat_witness(2, 101).
modular_answer(fermat_3_101, true) :- fermat_witness(3, 101).
