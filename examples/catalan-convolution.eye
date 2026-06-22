% Catalan numbers by tabled convolution.
%
% catalan(N,C) sums all splits of N-1 into left and right substructures.  The same
% Catalan values appear in binary tree shapes, parenthesizations, and polygon
% triangulations, shown here with small wrapper predicates.
materialize(catalan_answer, 2).

table(catalan, 2).

% C_0 = 1; higher values are computed by the convolution sum.
catalan(0, 1).
catalan(?n, ?c) :-
  gt(?n, 0),
  sub(?n, 1, ?n1),
  sumall(?product,
    (between(0, ?n1, ?i),
     sub(?n1, ?i, ?j),
     catalan(?i, ?a),
     catalan(?j, ?b),
     mul(?a, ?b, ?product)),
    ?c).

% An n-gon has C_(n-2) triangulations.
polygon_triangulations(?sides, ?count) :-
  ge(?sides, 3),
  sub(?sides, 2, ?n),
  catalan(?n, ?count).

parenthesizations(?factors, ?count) :-
  ge(?factors, 1),
  sub(?factors, 1, ?n),
  catalan(?n, ?count).

catalan_answer(catalan_12, ?c) :- catalan(12, ?c).
catalan_answer(triangulations_14_gon, ?count) :- polygon_triangulations(14, ?count).
catalan_answer(parenthesizations_13_factors, ?count) :- parenthesizations(13, ?count).
catalan_answer(first_ten_sum, ?sum) :- sumall(?c, (between(0, 9, ?n), catalan(?n, ?c)), ?sum).
