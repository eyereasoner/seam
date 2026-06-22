% Newton-Raphson root finding, adapted from Eyelet input/newton-raphson.eye.
% Each want_root/1 case names a function, starting point, and tolerance.  The
% recursive finder stops when |f(x)| is below tolerance; otherwise it applies
% x := x - f(x)/f'(x) using the corresponding derivative rule.

materialize(findRoot, 2).

want_root([1, 1.0, 1.0e-15]).
want_root([2, 2.0, 1.0e-15]).
want_root([3, 3.0, 1.0e-15]).

findRoot(?input, ?root) :-
  want_root(?input),
  find_root(?input, ?root).

% f(1, X) = X^2 - 2
f(1, ?x, ?y) :-
  mul(?x, ?x, ?xx),
  sub(?xx, 2, ?y).

% f(2, X) = log(X) - 1
f(2, ?x, ?y) :-
  log(?x, ?lx),
  sub(?lx, 1, ?y).

% f(3, X) = sin(X)
f(3, ?x, ?y) :-
  sin(?x, ?y).

fd(1, ?x, ?y) :-
  mul(2, ?x, ?y).
fd(2, ?x, ?y) :-
  div(1, ?x, ?y).
fd(3, ?x, ?y) :-
  cos(?x, ?y).

find_root([?n, ?x, ?tolerance], ?x) :-
  f(?n, ?x, ?fx),
  abs(?fx, ?afx),
  lt(?afx, ?tolerance).
find_root([?n, ?x, ?tolerance], ?root) :-
  f(?n, ?x, ?fx),
  abs(?fx, ?afx),
  ge(?afx, ?tolerance),
  fd(?n, ?x, ?fdx),
  div(?fx, ?fdx, ?step),
  sub(?x, ?step, ?newx),
  find_root([?n, ?newx, ?tolerance], ?root).
