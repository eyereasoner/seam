% Peano addition, multiplication, and factorial over explicit Herbrand terms.
%
% The original logic-programming example uses `0` and `s(...)`.  Here zero is
% the atom `z`, so every natural number is an ordinary Eyelang term: z, s(z),
% s(s(z)), and so on.  The rules are relational; the materialized facts choose
% a few finite calculations as readable examples.

materialize(peano_answer, 2).
table(padd, 3).
table(pmul, 3).
table(pfact, 2).

% Addition.
padd(?a, z, ?a).
padd(?a, s(?b), s(?c)) :-
  padd(?a, ?b, ?c).

% Multiplication by repeated addition.
pmul(?_a, z, z).
pmul(?a, s(?b), ?c) :-
  pmul(?a, ?b, ?d),
  padd(?a, ?d, ?c).

% Factorial with an accumulator.
pfact(?n, ?value) :-
  pfac(?n, s(z), ?value).

pfac(z, ?acc, ?acc).
pfac(s(?n), ?acc, ?value) :-
  pmul(?acc, s(?n), ?next),
  pfac(?n, ?next, ?value).

peano_answer(two_plus_three, ?n) :-
  padd(s(s(z)), s(s(s(z))), ?n).

peano_answer(two_times_three, ?n) :-
  pmul(s(s(z)), s(s(s(z))), ?n).

peano_answer(factorial_four, ?n) :-
  pfact(s(s(s(s(z)))), ?n).
