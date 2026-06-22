% Binomial coefficients and Vandermonde's identity.
%
% choose(N,K,C) is computed by a multiplicative recurrence, then vandermonde/5 checks
% the finite convolution sum: sum_i C(R,i) C(S,N-i) = C(R+S,N).  Memoization keeps
% the binomial-row prefixes shared across both sides of the identity.
% choose_step/5 uses the multiplicative recurrence
%   C(N, I+1) = C(N, I) * (N-I) / (I+1)
% and is tabled because row sums and identities reuse prefixes.
materialize(binomial_answer, 2).

table(choose_step, 5).

choose(?n, ?k, ?c) :-
  ge(?k, 0),
  le(?k, ?n),
  choose_step(?n, ?k, 0, 1, ?c).

choose_step(?_n, ?k, ?k, ?acc, ?acc).
choose_step(?n, ?k, ?i, ?acc, ?c) :-
  lt(?i, ?k),
  add(?i, 1, ?i1),
  sub(?n, ?i, ?factor),
  mul(?acc, ?factor, ?numerator),
  div(?numerator, ?i1, ?nextacc),
  choose_step(?n, ?k, ?i1, ?nextacc, ?c).

symmetric(?n, ?k) :-
  choose(?n, ?k, ?c),
  sub(?n, ?k, ?otherk),
  choose(?n, ?otherk, ?c).

vandermonde_sum(?n, ?m, ?r, ?sum) :-
  sumall(?product,
    (between(0, ?r, ?k),
     sub(?r, ?k, ?rk),
     choose(?n, ?k, ?a),
     choose(?m, ?rk, ?b),
     mul(?a, ?b, ?product)),
    ?sum).

vandermonde(?n, ?m, ?r, ?sum) :-
  add(?n, ?m, ?totaln),
  choose(?totaln, ?r, ?sum),
  vandermonde_sum(?n, ?m, ?r, ?sum).

binomial_answer(choose_24_12, ?c) :- choose(24, 12, ?c).
binomial_answer(symmetry_24_7, true) :- symmetric(24, 7).
binomial_answer(vandermonde_12_10_8, ?sum) :- vandermonde(12, 10, 8, ?sum).
binomial_answer(row_12_sum, ?sum) :- sumall(?c, (between(0, 12, ?k), choose(12, ?k, ?c)), ?sum).
