% Modular exponentiation by repeated squaring.
% pow_mod/4 is logarithmic in the exponent and memoized so repeated primality
% and congruence checks share subproblems.
materialize(modular_answer, 2).

memoize(pow_mod, 4).

pow_mod(_Base, 0, Mod, Result) :- mod(1, Mod, Result).
pow_mod(Base, Exp, Modulus, Result) :-
  gt(Exp, 0),
  mod(Exp, 2, 0),
  div(Exp, 2, Half),
  pow_mod(Base, Half, Modulus, HalfPower),
  mul(HalfPower, HalfPower, Square),
  mod(Square, Modulus, Result).
pow_mod(Base, Exp, Modulus, Result) :-
  gt(Exp, 0),
  mod(Exp, 2, 1),
  sub(Exp, 1, EvenExp),
  pow_mod(Base, EvenExp, Modulus, EvenPower),
  mul(Base, EvenPower, Product),
  mod(Product, Modulus, Result).

fermat_witness(Base, PrimeCandidate) :-
  sub(PrimeCandidate, 1, Exponent),
  pow_mod(Base, Exponent, PrimeCandidate, 1).

modular_answer(pow_7_560_mod_561, R) :- pow_mod(7, 560, 561, R).
modular_answer(pow_2_1000_mod_1009, R) :- pow_mod(2, 1000, 1009, R).
modular_answer(fermat_2_101, true) :- fermat_witness(2, 101).
modular_answer(fermat_3_101, true) :- fermat_witness(3, 101).
