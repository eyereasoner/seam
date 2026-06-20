% Pell equation x^2 - 2y^2 = 1 by memoized recurrence.
%
% The fundamental solution (3,2) induces a linear recurrence for all positive
% solutions of x^2 - 2y^2 = 1.  The example materializes later solutions and also
% rechecks the Diophantine identity so the generated sequence is auditable.
materialize(pell_answer, 2).

memoize(pell, 3).

% N=0 is the neutral solution; each recursive step multiplies by 3 + 2*sqrt(2).
pell(0, 1, 0).
pell(N, X, Y) :-
  gt(N, 0),
  sub(N, 1, N1),
  pell(N1, X0, Y0),
  mul(3, X0, AX),
  mul(4, Y0, BY),
  add(AX, BY, X),
  mul(2, X0, CX),
  mul(3, Y0, DY),
  add(CX, DY, Y).

% Verification is intentionally independent of the recurrence equations above.
pell_holds(N, true) :-
  pell(N, X, Y),
  mul(X, X, X2),
  mul(Y, Y, Y2),
  mul(2, Y2, TwiceY2),
  sub(X2, TwiceY2, 1).

pell_answer(solution_5, solution(X, Y)) :- pell(5, X, Y).
pell_answer(solution_8, solution(X, Y)) :- pell(8, X, Y).
pell_answer(check_8, true) :- pell_holds(8, true).
pell_answer(y_sum_1_to_8, Sum) :- sumall(Y, (between(1, 8, N), pell(N, _X, Y)), Sum).
