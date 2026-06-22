% Pell equation x^2 - 2y^2 = 1 by tabled recurrence.
%
% The fundamental solution (3,2) induces a linear recurrence for all positive
% solutions of x^2 - 2y^2 = 1.  The example materializes later solutions and also
% rechecks the Diophantine identity so the generated sequence is auditable.
materialize(pell_answer, 2).

table(pell, 3).

% N=0 is the neutral solution; each recursive step multiplies by 3 + 2*sqrt(2).
pell(0, 1, 0).
pell(?n, ?x, ?y) :-
  gt(?n, 0),
  sub(?n, 1, ?n1),
  pell(?n1, ?x0, ?y0),
  mul(3, ?x0, ?ax),
  mul(4, ?y0, ?by),
  add(?ax, ?by, ?x),
  mul(2, ?x0, ?cx),
  mul(3, ?y0, ?dy),
  add(?cx, ?dy, ?y).

% Verification is intentionally independent of the recurrence equations above.
pell_holds(?n, true) :-
  pell(?n, ?x, ?y),
  mul(?x, ?x, ?x2),
  mul(?y, ?y, ?y2),
  mul(2, ?y2, ?twicey2),
  sub(?x2, ?twicey2, 1).

pell_answer(solution_5, solution(?x, ?y)) :- pell(5, ?x, ?y).
pell_answer(solution_8, solution(?x, ?y)) :- pell(8, ?x, ?y).
pell_answer(check_8, true) :- pell_holds(8, true).
pell_answer(y_sum_1_to_8, ?sum) :- sumall(?y, (between(1, 8, ?n), pell(?n, ?_x, ?y)), ?sum).
