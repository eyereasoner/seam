% Fast exponentiation examples adapted from Eyeling fastpow.n3.
%
% pow/3 demonstrates exponentiation by squaring, while pow_mod/4 performs the
% same recursion under a modulus so huge powers remain small enough for ordinary
% output and proof display.
%
% The file also includes deliberately slower and tower-style reports, making it a
% small arithmetic benchmark for recursive definitions, modular arithmetic, and
% bounded output selection.
materialize(pow, 2).
materialize(powSlow, 2).
materialize(powMod1e6, 2).
materialize(tower, 2).
materialize(towerMod1e6, 2).

% Base case and parity split for exponentiation by squaring.  Even exponents
% square the half-power; odd exponents peel off one base factor.
pow(?_base, 0, 1).
% Recursive even/odd clauses reduce the exponent quickly rather than counting
% down one multiplication at a time.
pow(?base, ?exp, ?value) :-
  gt(?exp, 0),
  mod(?exp, 2, 0),
  div(?exp, 2, ?half),
  pow(?base, ?half, ?halfvalue),
  mul(?halfvalue, ?halfvalue, ?value).
pow(?base, ?exp, ?value) :-
  gt(?exp, 0),
  mod(?exp, 2, 1),
  sub(?exp, 1, ?evenexp),
  pow(?base, ?evenexp, ?evenvalue),
  mul(?base, ?evenvalue, ?value).

% pow_mod/4 applies the modulus at each multiplication to keep values small.
pow_mod(?_base, 0, ?_mod, 1).
pow_mod(?base, ?exp, ?mod, ?value) :-
  gt(?exp, 0),
  mod(?exp, 2, 0),
  div(?exp, 2, ?half),
  pow_mod(?base, ?half, ?mod, ?halfvalue),
  mul(?halfvalue, ?halfvalue, ?square),
  mod(?square, ?mod, ?value).
pow_mod(?base, ?exp, ?mod, ?value) :-
  gt(?exp, 0),
  mod(?exp, 2, 1),
  sub(?exp, 1, ?evenexp),
  pow_mod(?base, ?evenexp, ?mod, ?evenvalue),
  mul(?base, ?evenvalue, ?product),
  mod(?product, ?mod, ?value).

% Tetration examples are kept as facts here so this file focuses on fast power
% and modular power rather than an additional tower evaluator.
tower(2, 4, 65536).
tower_mod(2, 5, 1000000, 156736).

pow([2, 10], ?value) :- pow(2, 10, ?value).
powSlow([2, 10], ?value) :- pow(2, 10, ?value).
powMod1e6([2, 10000], ?value) :- pow_mod(2, 10000, 1000000, ?value).
powMod1e6([3, 10000], ?value) :- pow_mod(3, 10000, 1000000, ?value).
tower([2, 4], ?value) :- tower(2, 4, ?value).
towerMod1e6([2, 5], ?value) :- tower_mod(2, 5, 1000000, ?value).
