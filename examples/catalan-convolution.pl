% Catalan numbers by memoized convolution.
% catalan/2 counts binary tree shapes, parenthesizations, and polygon
% triangulations with the usual index shifts.
materialize(catalan_answer, 2).

memoize(catalan, 2).

catalan(0, 1).
catalan(N, C) :-
  gt(N, 0),
  sub(N, 1, N1),
  sumall(Product,
    (between(0, N1, I),
     sub(N1, I, J),
     catalan(I, A),
     catalan(J, B),
     mul(A, B, Product)),
    C).

polygon_triangulations(Sides, Count) :-
  ge(Sides, 3),
  sub(Sides, 2, N),
  catalan(N, Count).

parenthesizations(Factors, Count) :-
  ge(Factors, 1),
  sub(Factors, 1, N),
  catalan(N, Count).

catalan_answer(catalan_12, C) :- catalan(12, C).
catalan_answer(triangulations_14_gon, Count) :- polygon_triangulations(14, Count).
catalan_answer(parenthesizations_13_factors, Count) :- parenthesizations(13, Count).
catalan_answer(first_ten_sum, Sum) :- sumall(C, (between(0, 9, N), catalan(N, C)), Sum).
