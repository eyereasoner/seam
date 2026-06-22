% BMI — ARC-style Body Mass Index example adapted from Eyeling.
%
% The example normalizes metric or US inputs, computes BMI, assigns the WHO
% adult category, derives a healthy-weight band for the same height, and emits
% an inspectable report plus independent checks.
%
% For reproducibility and documentation only; not medical advice.

% Editable metric input.
% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(unitSystem, 2).
materialize(weight, 2).
materialize(height, 2).
materialize(weightKg, 2).
materialize(heightM, 2).
materialize(units, 2).
materialize(heightSquared, 2).
materialize(bmi, 2).
materialize(bmiRoundedInt, 2).
materialize(healthyMinKg, 2).
materialize(healthyMaxKg, 2).
materialize(healthyMinKgRoundedInt, 2).
materialize(healthyMaxKgRoundedInt, 2).
materialize(category, 2).
materialize(heightCm, 2).
materialize(formula, 2).
materialize(calculation, 2).
materialize(categoryRule, 2).
materialize(unitsExplanation, 2).
materialize(c1, 2).
materialize(c2, 2).
materialize(c3, 2).
materialize(c4, 2).
materialize(c5, 2).
materialize(c6, 2).
materialize(c7, 2).
materialize(c8, 2).
materialize(c9, 2).
materialize(result, 2).
materialize(healthyWeightRangeKg, 2).
materialize(checkPassed, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
unitSystem(input, metric).
weight(input, 72.0).
height(input, 178.0).

% US alternative:
% unitSystem(input, us).
% weight(input, 158.73).
% height(input, 70.08).

% Normalization and BMI calculation.
% Derivation rules: each rule below contributes one logical step toward the displayed results.
weightKg(case, ?w) :-
  unitSystem(input, metric),
  weight(input, ?w).

heightM(case, ?m) :-
  unitSystem(input, metric),
  height(input, ?h),
  div(?h, 100.0, ?m).

units(reason, "Inputs were already metric, so kilograms stay kilograms and centimeters are divided by 100 to obtain meters.") :-
  unitSystem(input, metric).

weightKg(case, ?kg) :-
  unitSystem(input, us),
  weight(input, ?w),
  mul(?w, 0.45359237, ?kg).

heightM(case, ?m) :-
  unitSystem(input, us),
  height(input, ?h),
  mul(?h, 0.0254, ?m).

units(reason, "US inputs were converted to SI units: pounds to kilograms and inches to meters.") :-
  unitSystem(input, us).

heightSquared(case, ?m2) :-
  heightM(case, ?m),
  mul(?m, ?m, ?m2).

bmi(case, ?bmi) :-
  weightKg(case, ?kg),
  heightSquared(case, ?m2),
  div(?kg, ?m2, ?bmi).

bmiRoundedInt(case, ?bmiroundedint) :-
  bmi(case, ?bmi),
  mul(?bmi, 100.0, ?bmix100),
  rounded(?bmix100, ?bmiroundedint).

healthyMinKg(case, ?healthymin) :-
  heightSquared(case, ?m2),
  mul(18.5, ?m2, ?healthymin).

healthyMaxKg(case, ?healthymax) :-
  heightSquared(case, ?m2),
  mul(24.9, ?m2, ?healthymax).

healthyMinKgRoundedInt(case, ?minroundedint) :-
  healthyMinKg(case, ?healthymin),
  mul(?healthymin, 10.0, ?minx10),
  rounded(?minx10, ?minroundedint).

healthyMaxKgRoundedInt(case, ?maxroundedint) :-
  healthyMaxKg(case, ?healthymax),
  mul(?healthymax, 10.0, ?maxx10),
  rounded(?maxx10, ?maxroundedint).

% WHO adult categories, using half-open intervals.
category(decision, "Underweight") :-
  bmi(case, ?bmi),
  lt(?bmi, 18.5).

category(decision, "Normal") :-
  bmi(case, ?bmi),
  ge(?bmi, 18.5),
  lt(?bmi, 25.0).

category(decision, "Overweight") :-
  bmi(case, ?bmi),
  ge(?bmi, 25.0),
  lt(?bmi, 30.0).

category(decision, "Obesity I") :-
  bmi(case, ?bmi),
  ge(?bmi, 30.0),
  lt(?bmi, 35.0).

category(decision, "Obesity II") :-
  bmi(case, ?bmi),
  ge(?bmi, 35.0),
  lt(?bmi, 40.0).

category(decision, "Obesity III") :-
  bmi(case, ?bmi),
  ge(?bmi, 40.0).

% Answer and reason why.
bmi(answer, 22.72) :-
  bmiRoundedInt(case, 2272).

category(answer, ?category) :-
  category(decision, ?category).

healthyMinKg(answer, 58.6) :-
  healthyMinKgRoundedInt(case, 586).

healthyMaxKg(answer, 78.9) :-
  healthyMaxKgRoundedInt(case, 789).

heightCm(answer, ?cmrounded) :-
  heightM(case, ?m),
  mul(?m, 100.0, ?cm),
  rounded(?cm, ?cmrounded).

formula(reason, "BMI is defined as weight in kilograms divided by height in meters squared.") :-
  bmi(case, ?_bmi).

calculation(reason, "The normalized weight and height were used to compute BMI, then the result was mapped to the WHO adult category table.") :-
  category(decision, ?_category).

categoryRule(reason, ?category) :-
  category(decision, ?category).

unitsExplanation(reason, ?units) :-
  units(reason, ?units).

% Independent checks.
c1(check, "OK - the input was normalized into positive SI values.") :-
  weightKg(case, ?kg),
  heightM(case, ?m),
  gt(?kg, 0),
  gt(?m, 0).

c2(check, "OK - height squared was reconstructed from the normalized height.") :-
  heightM(case, ?m),
  heightSquared(case, ?m2),
  mul(?m, ?m, ?m2).

c3(check, "OK - the BMI value matches the BMI = kg / m² formula.") :-
  weightKg(case, ?kg),
  heightSquared(case, ?m2),
  bmi(case, ?bmi),
  div(?kg, ?m2, ?bmi).

c4(check, "OK - a BMI of 18.49 stays below the normal-weight threshold.") :-
  lt(18.49, 18.5).

c5(check, "OK - the lower boundary is half-open: BMI 18.5 is classified as Normal.") :-
  ge(18.5, 18.5),
  lt(18.5, 25.0).

c6(check, "OK - BMI 25.0 starts the Overweight category.") :-
  ge(25.0, 25.0),
  lt(25.0, 30.0).

c7(check, "OK - BMI 30.0 starts the Obesity I category.") :-
  ge(30.0, 30.0),
  lt(30.0, 35.0).

c8(check, "OK - classification behavior is monotonic across representative BMI values.") :-
  ge(22.0, 18.5),
  lt(22.0, 25.0),
  ge(27.0, 25.0),
  lt(27.0, 30.0),
  ge(41.0, 40.0).

c9(check, "OK - the healthy-weight band was reconstructed from BMI 18.5 to 24.9 at the same height.") :-
  heightSquared(case, ?m2),
  healthyMinKg(case, ?min),
  healthyMaxKg(case, ?max),
  mul(18.5, ?m2, ?min),
  mul(24.9, ?m2, ?max).

% Derived report summary.  These relations are consequences of the calculation
% and checks, not pre-written report lines.
result(report, bmi(?bmi, ?category)) :-
  bmi(answer, ?bmi),
  category(answer, ?category).

healthyWeightRangeKg(report, range(?min, ?max)) :-
  healthyMinKg(answer, ?min),
  healthyMaxKg(answer, ?max).

heightCm(report, ?height) :-
  heightCm(answer, ?height).

checkPassed(report, ?check) :-
  statement(check, ?check, ?_message).
