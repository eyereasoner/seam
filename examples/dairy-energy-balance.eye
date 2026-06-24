% EYE-inspired dairy energy balance case study.
%
% cow(Cow, BodyWeightKg, MilkKgPerDay, RationEnergyMcalPerKgDM, IntakeKgDM)
% records a small herd.  Rules estimate maintenance demand, milk-production
% demand, ration supply, and the resulting energy-balance class.
materialize(energyBalance_Mcal, 2).
materialize(rationSupportedMilk_kg, 2).
materialize(status, 2).
materialize(reason, 2).
materialize(strongestDeficit, 2).

% Four cows cover negative, near-neutral, and positive balance cases.
cow(early_lactation, 650, 38, 6.4, 22).
cow(mid_lactation, 610, 24, 6.5, 26).
cow(late_lactation, 580, 16, 6.7, 25).
cow(grazing, 540, 18, 5.8, 21).

% Maintenance scales with body weight; milk requirement scales with daily milk.
maintenance(?c, ?m) :-
  cow(?c, ?weight, ?, ?, ?),
  mul(?weight, 0.08, ?m).

milk_requirement(?c, ?r) :-
  cow(?c, ?, ?milk, ?, ?),
  mul(?milk, 5.0, ?r).

ration_supply(?c, ?s) :-
  cow(?c, ?, ?, ?density, ?intake),
  mul(?density, ?intake, ?s).

total_requirement(?c, ?r) :-
  maintenance(?c, ?m),
  milk_requirement(?c, ?milkr),
  add(?m, ?milkr, ?r).

% energy_balance/2 is intake minus maintenance and milk-production demand.
energy_balance(?c, ?b) :-
  ration_supply(?c, ?s),
  total_requirement(?c, ?r),
  sub(?s, ?r, ?b).

ration_supported_milk(?c, ?milk) :-
  ration_supply(?c, ?s),
  maintenance(?c, ?m),
  sub(?s, ?m, ?availableformilk),
  div(?availableformilk, 5.0, ?milk).

status(?c, negative_energy_balance) :-
  energy_balance(?c, ?b),
  lt(?b, -5.0).

status(?c, near_neutral_energy_balance) :-
  energy_balance(?c, ?b),
  ge(?b, -5.0),
  le(?b, 5.0).

status(?c, positive_energy_balance) :-
  energy_balance(?c, ?b),
  gt(?b, 5.0).

energyBalance_Mcal(?c, ?b) :- energy_balance(?c, ?b).
rationSupportedMilk_kg(?c, ?m) :- ration_supported_milk(?c, ?m).
reason(dairy_energy_balance, "ration supply minus maintenance and milk energy requirement determines the class").
strongestDeficit(dairy_energy_balance, early_lactation) :-
  status(early_lactation, negative_energy_balance),
  status(late_lactation, positive_energy_balance).
