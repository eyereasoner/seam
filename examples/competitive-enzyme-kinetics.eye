% Science example: competitive enzyme inhibition.
%
% Michaelis-Menten kinetics with a competitive inhibitor:
%   Km_effective = Km * (1 + Inhibitor / Ki)
%   rate = Vmax * Substrate / (Km_effective + Substrate)

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(effectiveKm_uM, 2).
materialize(uninhibitedRate_uM_s, 2).
materialize(inhibitedRate_uM_s, 2).
materialize(inhibitionFraction, 2).
materialize(status, 2).
materialize(reason, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
assay(assay1, vmax_uM_s, 120.0).
assay(assay1, substrate_uM, 50.0).
assay(assay1, km_uM, 30.0).
assay(assay1, inhibitor_uM, 10.0).
assay(assay1, ki_uM, 5.0).
threshold(assay1, significant_inhibition_fraction, 0.25).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
competitive_multiplier(?assay, ?multiplier) :-
  assay(?assay, inhibitor_uM, ?inhibitor),
  assay(?assay, ki_uM, ?ki),
  div(?inhibitor, ?ki, ?ratio),
  add(1.0, ?ratio, ?multiplier).

effective_km(?assay, ?effectivekm) :-
  assay(?assay, km_uM, ?km),
  competitive_multiplier(?assay, ?multiplier),
  mul(?km, ?multiplier, ?effectivekm).

uninhibited_rate(?assay, ?rate) :-
  assay(?assay, vmax_uM_s, ?vmax),
  assay(?assay, substrate_uM, ?substrate),
  assay(?assay, km_uM, ?km),
  mul(?vmax, ?substrate, ?numerator),
  add(?km, ?substrate, ?denominator),
  div(?numerator, ?denominator, ?rate).

inhibited_rate(?assay, ?rate) :-
  assay(?assay, vmax_uM_s, ?vmax),
  assay(?assay, substrate_uM, ?substrate),
  effective_km(?assay, ?effectivekm),
  mul(?vmax, ?substrate, ?numerator),
  add(?effectivekm, ?substrate, ?denominator),
  div(?numerator, ?denominator, ?rate).

inhibition_fraction(?assay, ?fraction) :-
  uninhibited_rate(?assay, ?uninhibited),
  inhibited_rate(?assay, ?inhibited),
  sub(?uninhibited, ?inhibited, ?delta),
  div(?delta, ?uninhibited, ?fraction).

significant_inhibition(?assay) :-
  inhibition_fraction(?assay, ?fraction),
  threshold(?assay, significant_inhibition_fraction, ?limit),
  gt(?fraction, ?limit).

effectiveKm_uM(?assay, ?effectivekm) :-
  effective_km(?assay, ?effectivekm).

uninhibitedRate_uM_s(?assay, ?rate) :-
  uninhibited_rate(?assay, ?rate).

inhibitedRate_uM_s(?assay, ?rate) :-
  inhibited_rate(?assay, ?rate).

inhibitionFraction(?assay, ?fraction) :-
  inhibition_fraction(?assay, ?fraction).

status(?assay, significant_inhibition) :-
  significant_inhibition(?assay).

reason(?assay, "competitive inhibitor raises effective Km and lowers reaction rate") :-
  significant_inhibition(?assay).
