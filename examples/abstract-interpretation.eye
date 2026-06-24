% Abstract interpretation over a tiny imperative program.
%
% The concrete program is:
%
%   x := input();
%   if x < 0 then y := -x else y := x;
%   z := 10 / y;
%
% Instead of executing the program for every integer input, this example tracks
% only the abstract sign of each variable: neg, zero, or pos.  The analysis is
% deliberately conservative: if the join point can see y = zero on any path, the
% division is reported as a possible division-by-zero warning.

materialize(absState, 3).
materialize(absWarning, 2).
materialize(absConclusion, 2).

table(abs_state, 3).

% The abstract domain.
input_sign(neg).
input_sign(zero).
input_sign(pos).

% The input statement gives x any of the three abstract signs.
abs_state(input, x, ?sign) :- input_sign(?sign).

% The branch refines the sign of x.  The negative branch only receives neg; the
% non-negative branch receives zero or pos.
abs_state(negative_branch, x, neg) :- abs_state(input, x, neg).
abs_state(nonnegative_branch, x, zero) :- abs_state(input, x, zero).
abs_state(nonnegative_branch, x, pos) :- abs_state(input, x, pos).

% Transfer functions for assignments.  In the negative branch, y := -x turns a
% negative x into a positive y.  In the non-negative branch, y := x preserves the
% zero/positive information.
abs_state(negative_branch, y, pos) :- abs_state(negative_branch, x, neg).
abs_state(nonnegative_branch, y, ?sign) :- abs_state(nonnegative_branch, x, ?sign).

% The join point merges abstract states from both branches.
abs_state(join, ?var, ?sign) :- abs_state(negative_branch, ?var, ?sign).
abs_state(join, ?var, ?sign) :- abs_state(nonnegative_branch, ?var, ?sign).

% A possible zero denominator is enough to raise a conservative warning.
possible_division_by_zero(join) :- abs_state(join, y, zero).

absState(?point, ?var, sign(?sign)) :- abs_state(?point, ?var, ?sign).
absWarning(division_by_zero, ?point) :- possible_division_by_zero(?point).
absConclusion(case, "abstract interpretation keeps all feasible signs and warns because y may be zero") :-
  possible_division_by_zero(join).
