% Engineering example: buck-converter ripple check.
%
% A simplified continuous-conduction buck converter model computes duty cycle,
% inductor ripple current, capacitor ripple voltage, and checks design limits.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
%
% The constants describe one regulator design. The rules intentionally keep
% each engineering equation separate so proof output can point to the exact
% calculation that made the design pass or fail.
materialize(dutyCycle, 2).
materialize(inductorRipple_A, 2).
materialize(rippleRatio, 2).
materialize(capacitorRipple_V, 2).
materialize(status, 2).
materialize(reason, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
converter(regulator1, inputVoltage_V, 24.0).
converter(regulator1, outputVoltage_V, 5.0).
converter(regulator1, loadCurrent_A, 2.0).
converter(regulator1, switchingFrequency_Hz, 500000.0).
converter(regulator1, inductance_H, 0.000022).
converter(regulator1, capacitance_F, 0.000047).
limit(regulator1, maxRippleRatio, 0.30).
limit(regulator1, maxOutputRipple_V, 0.05).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
duty_cycle(?converter, ?duty) :-
  converter(?converter, outputVoltage_V, ?outputvoltage),
  converter(?converter, inputVoltage_V, ?inputvoltage),
  div(?outputvoltage, ?inputvoltage, ?duty).

inductor_ripple_current(?converter, ?ripplecurrent) :-
  converter(?converter, inputVoltage_V, ?inputvoltage),
  converter(?converter, outputVoltage_V, ?outputvoltage),
  converter(?converter, inductance_H, ?inductance),
  converter(?converter, switchingFrequency_Hz, ?frequency),
  duty_cycle(?converter, ?duty),
  sub(?inputvoltage, ?outputvoltage, ?voltageacrossinductor),
  mul(?voltageacrossinductor, ?duty, ?numerator),
  mul(?inductance, ?frequency, ?denominator),
  div(?numerator, ?denominator, ?ripplecurrent).

ripple_ratio(?converter, ?ratio) :-
  inductor_ripple_current(?converter, ?ripplecurrent),
  converter(?converter, loadCurrent_A, ?loadcurrent),
  div(?ripplecurrent, ?loadcurrent, ?ratio).

capacitor_ripple_voltage(?converter, ?ripplevoltage) :-
  inductor_ripple_current(?converter, ?ripplecurrent),
  converter(?converter, switchingFrequency_Hz, ?frequency),
  converter(?converter, capacitance_F, ?capacitance),
  mul(8.0, ?frequency, ?eightf),
  mul(?eightf, ?capacitance, ?denominator),
  div(?ripplecurrent, ?denominator, ?ripplevoltage).

% within_ripple_limits/1 is the design gate for ripple current and output voltage.
within_ripple_limits(?converter) :-
  ripple_ratio(?converter, ?ratio),
  limit(?converter, maxRippleRatio, ?maxratio),
  lt(?ratio, ?maxratio),
  capacitor_ripple_voltage(?converter, ?ripplevoltage),
  limit(?converter, maxOutputRipple_V, ?maxripplevoltage),
  lt(?ripplevoltage, ?maxripplevoltage).

dutyCycle(?converter, ?duty) :-
  duty_cycle(?converter, ?duty).

inductorRipple_A(?converter, ?ripplecurrent) :-
  inductor_ripple_current(?converter, ?ripplecurrent).

rippleRatio(?converter, ?ratio) :-
  ripple_ratio(?converter, ?ratio).

capacitorRipple_V(?converter, ?ripplevoltage) :-
  capacitor_ripple_voltage(?converter, ?ripplevoltage).

status(?converter, stable_ripple_design) :-
  within_ripple_limits(?converter).

reason(?converter, "inductor-current and output-voltage ripple are below design limits") :-
  within_ripple_limits(?converter).
