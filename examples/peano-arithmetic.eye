% Peano arithmetic port from EYE reasoning/peano.
%
% The EYE example defines add, multiply and factorial over Peano numerals.
% Its selected output computes (1 * 2 + 3)! and emits the factorial of 5.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(factorial, 2).

% Numbers are represented only with 0 and successor terms s(...).  The final
% query constructs the Peano value for five through add and multiply.
peano_add(?a, 0, ?a).
% peano_add/3, peano_multiply/3, and fac/3 are structurally recursive, so
% the proof mirrors the Peano definitions of arithmetic.
peano_add(?a, s(?b), s(?c)) :-
  peano_add(?a, ?b, ?c).

peano_multiply(?_a, 0, 0).
peano_multiply(?a, s(?b), ?c) :-
  peano_multiply(?a, ?b, ?d),
  peano_add(?a, ?d, ?c).

factorial(?a, ?b) :-
  fac(?a, s(0), ?b).

fac(0, ?a, ?a).
fac(s(?a), ?b, ?c) :-
  peano_multiply(?b, s(?a), ?d),
  fac(?a, ?d, ?c).

factorial(?b, ?c) :-
  peano_multiply(s(0), s(s(0)), ?a),
  peano_add(?a, s(s(s(0))), ?b),
  factorial(?b, ?c).
