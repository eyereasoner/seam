% Convergents of sqrt(2) by tabled recurrence.
%
% conv(N, P, Q) gives the Nth numerator/denominator pair for [1; 2, 2, ...].
% Because each convergent depends on the previous two, memoization avoids the
% exponential recomputation that the direct Horn-clause recurrence would have.
% pell_error/2 connects the approximation sequence with P^2 - 2Q^2 = +/-1.
materialize(convergent_answer, 2).

table(conv, 3).

% Base convergents are 1/1 and 3/2.
conv(0, 1, 1).
conv(1, 3, 2).
conv(?n, ?p, ?q) :-
  gt(?n, 1),
  sub(?n, 1, ?n1),
  sub(?n, 2, ?n2),
  conv(?n1, ?p1, ?q1),
  conv(?n2, ?p2, ?q2),
  mul(2, ?p1, ?twicep1),
  add(?twicep1, ?p2, ?p),
  mul(2, ?q1, ?twiceq1),
  add(?twiceq1, ?q2, ?q).

% The signed error alternates between +1 and -1 for these convergents.
pell_error(?n, ?error) :-
  conv(?n, ?p, ?q),
  mul(?p, ?p, ?p2),
  mul(?q, ?q, ?q2),
  mul(2, ?q2, ?twiceq2),
  sub(?p2, ?twiceq2, ?error).

convergent_answer(convergent_10, fraction(?p, ?q)) :- conv(10, ?p, ?q).
convergent_answer(convergent_15, fraction(?p, ?q)) :- conv(15, ?p, ?q).
convergent_answer(pell_error_15, ?error) :- pell_error(15, ?error).
convergent_answer(numerator_sum_0_to_10, ?sum) :- sumall(?p, (between(0, 10, ?n), conv(?n, ?p, ?_q)), ?sum).
