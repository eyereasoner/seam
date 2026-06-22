% Polynomial roots over complex integer candidates, adapted from Eyelet's
% input/polynomial.eye.
%
% Complex numbers are represented as [Real, Imaginary].  This eyelang version
% keeps the example generic by evaluating a polynomial with Horner's rule and
% searching a finite complex-integer candidate grid.  The two cases below are
% the same quartic polynomials used by the Eyelet source.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(polynomial, 2).
materialize(root, 2).
materialize(reconstructedPolynomial, 2).
materialize(reconstructionMatches, 2).
materialize(allRootsVerified, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
case(real_quartic).
case(complex_quartic).

polynomial(real_quartic, [[1, 0], [-10, 0], [35, 0], [-50, 0], [24, 0]]).
polynomial(complex_quartic, [[1, 0], [-9, -5], [14, 33], [24, -44], [-26, 0]]).

% Finite search domains for the two sample quartics.
real_domain(real_quartic, 0, 5).
imag_domain(real_quartic, 0, 0).
real_domain(complex_quartic, 0, 5).
imag_domain(complex_quartic, 0, 2).

% The known roots are used only to reconstruct the polynomial and check that
% the coefficient list matches the case polynomial.  Root discovery below is
% driven by polynomial evaluation over the candidate grid.
known_roots(real_quartic, [[1, 0], [2, 0], [3, 0], [4, 0]]).
known_roots(complex_quartic, [[0, 1], [1, 1], [3, 2], [5, 1]]).

c_zero([0, 0]).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
c_add([?a, ?b], [?c, ?d], [?e, ?f]) :-
  add(?a, ?c, ?e),
  add(?b, ?d, ?f).

c_sub([?a, ?b], [?c, ?d], [?e, ?f]) :-
  sub(?a, ?c, ?e),
  sub(?b, ?d, ?f).

c_neg([?a, ?b], [?c, ?d]) :-
  neg(?a, ?c),
  neg(?b, ?d).

c_mul([?a, ?b], [?c, ?d], [?e, ?f]) :-
  mul(?a, ?c, ?ac),
  mul(?b, ?d, ?bd),
  sub(?ac, ?bd, ?e),
  mul(?a, ?d, ?ad),
  mul(?b, ?c, ?bc),
  add(?ad, ?bc, ?f).

poly_eval([?coeff|?rest], ?x, ?value) :-
  poly_eval_acc(?rest, ?x, ?coeff, ?value).

poly_eval_acc([], ?_x, ?acc, ?acc).
poly_eval_acc([?coeff|?rest], ?x, ?acc, ?value) :-
  c_mul(?acc, ?x, ?product),
  c_add(?product, ?coeff, ?next),
  poly_eval_acc(?rest, ?x, ?next, ?value).

candidate(?case, [?r, ?i]) :-
  real_domain(?case, ?r0, ?r1),
  imag_domain(?case, ?i0, ?i1),
  between(?r0, ?r1, ?r),
  between(?i0, ?i1, ?i).

root(?case, ?root) :-
  polynomial(?case, ?coeffs),
  candidate(?case, ?root),
  poly_eval(?coeffs, ?root, ?value),
  c_zero(?value).

poly_from_roots(?roots, ?coeffs) :-
  poly_from_roots_acc(?roots, [[1, 0]], ?coeffs).

poly_from_roots_acc([], ?coeffs, ?coeffs).
poly_from_roots_acc([?root|?rest], ?coeffs, ?result) :-
  poly_mul_linear(?coeffs, ?root, ?next),
  poly_from_roots_acc(?rest, ?next, ?result).

poly_mul_linear(?coeffs, ?root, ?product) :-
  append(?coeffs, [[0, 0]], ?shifted),
  c_neg(?root, ?minusroot),
  poly_scale(?minusroot, ?coeffs, ?scaled),
  append([[0, 0]], ?scaled, ?lower),
  poly_add(?shifted, ?lower, ?product).

poly_scale(?_factor, [], []).
poly_scale(?factor, [?coeff|?rest], [?product|?scaled]) :-
  c_mul(?factor, ?coeff, ?product),
  poly_scale(?factor, ?rest, ?scaled).

poly_add([], [], []).
poly_add([?a|?as], [?b|?bs], [?c|?cs]) :-
  c_add(?a, ?b, ?c),
  poly_add(?as, ?bs, ?cs).

reconstructed(?case, ?coeffs) :-
  known_roots(?case, ?roots),
  poly_from_roots(?roots, ?coeffs).



reconstructedPolynomial(?case, ?coeffs) :-
  reconstructed(?case, ?coeffs).

reconstructionMatches(?case, true) :-
  polynomial(?case, ?coeffs),
  reconstructed(?case, ?coeffs).

allRootsVerified(?case, true) :-
  known_roots(?case, ?roots),
  all_roots_verify(?case, ?roots).

all_roots_verify(?_case, []).
all_roots_verify(?case, [?root|?rest]) :-
  root(?case, ?root),
  all_roots_verify(?case, ?rest).
