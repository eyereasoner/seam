% Heron's theorem: area = sqrt(s(s-a)(s-b)(s-c)).
%
% The sample is the classic 13-14-15 triangle, whose area is exactly 84.  The
% program materializes the semiperimeter, Heron product, and final area so proof
% output can be checked against the familiar hand calculation.
%
% This is a compact example of theorem-shaped arithmetic: facts name a geometric
% object, reusable relations compute intermediates, and wrapper predicates choose
% the report vocabulary.
materialize(semiperimeter, 2).
materialize(heronProduct, 2).
materialize(area, 2).
materialize(status, 2).

% A single survey triangle is enough to demonstrate the formula; 13-14-15 has
% integer area 84, which makes the computed result easy to check.
triangle(field_plot, 13, 14, 15).

% semiperimeter/2 is the reusable first step in Heron's formula.
semiperimeter(?triangle, ?s) :-
  triangle(?triangle, ?a, ?b, ?c),
  add(?a, ?b, ?ab),
  add(?ab, ?c, ?sum),
  div(?sum, 2, ?s).

% Area is obtained by taking the square root of this Heron product.
heron_product(?triangle, ?product) :-
  triangle(?triangle, ?a, ?b, ?c),
  semiperimeter(?triangle, ?s),
  sub(?s, ?a, ?sa),
  sub(?s, ?b, ?sb),
  sub(?s, ?c, ?sc),
  mul(?s, ?sa, ?t1),
  mul(?t1, ?sb, ?t2),
  mul(?t2, ?sc, ?product).

area(?triangle, ?area) :-
  heron_product(?triangle, ?product),
  pow(?product, 0.5, ?area).

heronProduct(?triangle, ?p) :- heron_product(?triangle, ?p).
status(?triangle, valid_survey_triangle) :- area(?triangle, ?a), gt(?a, 0).
