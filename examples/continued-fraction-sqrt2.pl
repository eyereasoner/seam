% Convergents of sqrt(2) by memoized recurrence.
% conv(N, P, Q) gives the Nth numerator/denominator pair for the continued fraction [1; 2, 2, ...].
% The Pell-error check shows how these convergents alternately approximate solutions to P^2 - 2Q^2 = +/-1.
materialize(convergent_answer, 2).

memoize(conv, 3).

conv(0, 1, 1).
conv(1, 3, 2).
conv(N, P, Q) :-
  gt(N, 1),
  sub(N, 1, N1),
  sub(N, 2, N2),
  conv(N1, P1, Q1),
  conv(N2, P2, Q2),
  mul(2, P1, TwiceP1),
  add(TwiceP1, P2, P),
  mul(2, Q1, TwiceQ1),
  add(TwiceQ1, Q2, Q).

pell_error(N, Error) :-
  conv(N, P, Q),
  mul(P, P, P2),
  mul(Q, Q, Q2),
  mul(2, Q2, TwiceQ2),
  sub(P2, TwiceQ2, Error).

convergent_answer(convergent_10, fraction(P, Q)) :- conv(10, P, Q).
convergent_answer(convergent_15, fraction(P, Q)) :- conv(15, P, Q).
convergent_answer(pell_error_15, Error) :- pell_error(15, Error).
convergent_answer(numerator_sum_0_to_10, Sum) :- sumall(P, (between(0, 10, N), conv(N, P, _Q)), Sum).
