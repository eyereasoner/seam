% Representative example: manufacturing quality-control capability.
%
% The rules compute process capability indices from measurement summaries and
% classify production lines using a practical Cpk threshold.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(cpk, 2).
materialize(status, 2).
materialize(reason, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
run(line7_shift_a).
run(line8_shift_b).

spec(line7_shift_a, lower_mm, 10.0).
spec(line7_shift_a, upper_mm, 10.2).
summary(line7_shift_a, mean_mm, 10.12).
summary(line7_shift_a, sigma_mm, 0.04).

spec(line8_shift_b, lower_mm, 10.0).
spec(line8_shift_b, upper_mm, 10.2).
summary(line8_shift_b, mean_mm, 10.1).
summary(line8_shift_b, sigma_mm, 0.02).

capability_threshold(cpk, 1.33).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
upper_margin_mm(?run, ?margin) :-
  spec(?run, upper_mm, ?upper),
  summary(?run, mean_mm, ?mean),
  sub(?upper, ?mean, ?margin).

lower_margin_mm(?run, ?margin) :-
  summary(?run, mean_mm, ?mean),
  spec(?run, lower_mm, ?lower),
  sub(?mean, ?lower, ?margin).

nearest_spec_margin_mm(?run, ?margin) :-
  upper_margin_mm(?run, ?uppermargin),
  lower_margin_mm(?run, ?lowermargin),
  min(?uppermargin, ?lowermargin, ?margin).

three_sigma_mm(?run, ?threesigma) :-
  summary(?run, sigma_mm, ?sigma),
  mul(3.0, ?sigma, ?threesigma).

cpk(?run, ?cpk) :-
  nearest_spec_margin_mm(?run, ?margin),
  three_sigma_mm(?run, ?threesigma),
  div(?margin, ?threesigma, ?cpk).

capable(?run) :-
  cpk(?run, ?cpk),
  capability_threshold(cpk, ?threshold),
  ge(?cpk, ?threshold).

needs_adjustment(?run) :-
  cpk(?run, ?cpk),
  capability_threshold(cpk, ?threshold),
  lt(?cpk, ?threshold).


status(?run, capable_process) :-
  capable(?run).

status(?run, needs_process_adjustment) :-
  needs_adjustment(?run).

reason(?run, "Cpk meets the production capability threshold") :-
  capable(?run).

reason(?run, "Cpk is below the production capability threshold") :-
  needs_adjustment(?run).
