% Symbolic differentiation over explicit expression terms.
%
% The source derivative example uses Prolog operators such as `+`, `*`, `^`, and
% cut.  Eyelang keeps expressions as ordinary terms: `add/2`, `mul/2`, `pow/2`,
% `log/1`, and so on.  The result is intentionally unsimplified so the rule that
% produced each part remains visible.

materialize(derivative_result, 2).

expr(square, mul(var(x), var(x))).
expr(linear_plus_const, add(var(x), const(3))).
expr(product, mul(add(var(x), const(1)), mul(add(pow(var(x), 2), const(2)), add(pow(var(x), 3), const(3))))).
expr(nested_log, log(log(var(x)))).

d(const(?_c), ?_x, const(0)).
d(var(?x), ?x, const(1)).
d(var(?y), ?x, const(0)) :-
  neq(?x, ?y).
d(add(?u, ?v), ?x, add(?du, ?dv)) :-
  d(?u, ?x, ?du),
  d(?v, ?x, ?dv).
d(sub(?u, ?v), ?x, sub(?du, ?dv)) :-
  d(?u, ?x, ?du),
  d(?v, ?x, ?dv).
d(mul(?u, ?v), ?x, add(mul(?du, ?v), mul(?u, ?dv))) :-
  d(?u, ?x, ?du),
  d(?v, ?x, ?dv).
d(divide(?u, ?v), ?x, divide(sub(mul(?du, ?v), mul(?u, ?dv)), pow(?v, 2))) :-
  d(?u, ?x, ?du),
  d(?v, ?x, ?dv).
d(pow(?u, ?n), ?x, mul(mul(const(?n), pow(?u, ?n1)), ?du)) :-
  sub(?n, 1, ?n1),
  d(?u, ?x, ?du).
d(log(?u), ?x, divide(?du, ?u)) :-
  d(?u, ?x, ?du).

derivative_result(?name, ?derivative) :-
  expr(?name, ?expr),
  d(?expr, x, ?derivative).
