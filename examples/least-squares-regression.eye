% Math example: least-squares linear regression.
%
% The rules reduce a list of points to sufficient statistics, then derive the
% fitted slope, intercept, and coefficient of determination R^2.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
%
% Accumulating sufficient statistics keeps the regression formulas compact and
% makes the proof show the same intermediate values a hand calculation would use.
materialize(slope, 2).
materialize(intercept, 2).
materialize(rSquared, 2).
materialize(status, 2).
materialize(reason, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
dataset(regression1, [point(1.0, 2.0), point(2.0, 3.0), point(3.0, 5.0), point(4.0, 4.0)]).
threshold(regression1, minimum_r_squared, 0.60).

% stats/7 folds points into N, Σx, Σy, Σx², Σxy, and Σy².
stats([], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0).
% Derivation rules: each rule below contributes one logical step toward the displayed results.
stats([point(?x, ?y)|?rest], ?n, ?sumx, ?sumy, ?sumxx, ?sumxy, ?sumyy) :-
  stats(?rest, ?n0, ?sumx0, ?sumy0, ?sumxx0, ?sumxy0, ?sumyy0),
  add(?n0, 1.0, ?n),
  add(?sumx0, ?x, ?sumx),
  add(?sumy0, ?y, ?sumy),
  mul(?x, ?x, ?xx),
  add(?sumxx0, ?xx, ?sumxx),
  mul(?x, ?y, ?xy),
  add(?sumxy0, ?xy, ?sumxy),
  mul(?y, ?y, ?yy),
  add(?sumyy0, ?yy, ?sumyy).

sufficient_statistics(?data, ?n, ?sumx, ?sumy, ?sumxx, ?sumxy, ?sumyy) :-
  dataset(?data, ?points),
  stats(?points, ?n, ?sumx, ?sumy, ?sumxx, ?sumxy, ?sumyy).

slope(?data, ?slope) :-
  sufficient_statistics(?data, ?n, ?sumx, ?sumy, ?sumxx, ?sumxy, ?_sumyy),
  mul(?n, ?sumxy, ?nsumxy),
  mul(?sumx, ?sumy, ?sumxsumy),
  sub(?nsumxy, ?sumxsumy, ?numerator),
  mul(?n, ?sumxx, ?nsumxx),
  mul(?sumx, ?sumx, ?sumxsquared),
  sub(?nsumxx, ?sumxsquared, ?denominator),
  div(?numerator, ?denominator, ?slope).

intercept(?data, ?intercept) :-
  sufficient_statistics(?data, ?n, ?sumx, ?sumy, ?_sumxx, ?_sumxy, ?_sumyy),
  slope(?data, ?slope),
  mul(?slope, ?sumx, ?slopesumx),
  sub(?sumy, ?slopesumx, ?numerator),
  div(?numerator, ?n, ?intercept).

r_squared(?data, ?r2) :-
  sufficient_statistics(?data, ?n, ?sumx, ?sumy, ?sumxx, ?sumxy, ?sumyy),
  mul(?n, ?sumxy, ?nsumxy),
  mul(?sumx, ?sumy, ?sumxsumy),
  sub(?nsumxy, ?sumxsumy, ?numeratorbase),
  pow(?numeratorbase, 2.0, ?numerator),
  mul(?n, ?sumxx, ?nsumxx),
  mul(?sumx, ?sumx, ?sumxsquared),
  sub(?nsumxx, ?sumxsquared, ?xspread),
  mul(?n, ?sumyy, ?nsumyy),
  mul(?sumy, ?sumy, ?sumysquared),
  sub(?nsumyy, ?sumysquared, ?yspread),
  mul(?xspread, ?yspread, ?denominator),
  div(?numerator, ?denominator, ?r2).

accepted_fit(?data) :-
  r_squared(?data, ?r2),
  threshold(?data, minimum_r_squared, ?minimum),
  ge(?r2, ?minimum).



rSquared(?data, ?r2) :-
  r_squared(?data, ?r2).

status(?data, accepted_linear_fit) :-
  accepted_fit(?data).

reason(?data, "R squared meets the minimum explanatory-power threshold") :-
  accepted_fit(?data).
