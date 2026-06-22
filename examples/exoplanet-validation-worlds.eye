% EYE reasoning-inspired example: exoplanet candidate validation worlds.
%
% Four simplified worlds classify candidate transit signals using either Bayes,
% sensitivity-only reasoning, a heuristic threshold, or a stricter Bayesian rule.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
%
% The example is intentionally qualitative: several independent signals must
% align before a candidate is promoted from plausible to confirmed in a world.
materialize(ppvPlanetGivenDetection, 2).
materialize(confirmsInWorld, 2).
materialize(rejectsInWorld, 2).
materialize(status, 2).
materialize(reason, 2).

% candidate/4 stores occurrence rate, sensitivity, and specificity.  world/2
% names the alternative validation policies applied to the same signals.
candidate(rare_wide_orbit, 0.001, 0.99, 0.99).
candidate(mstar_short_period, 0.20, 0.99, 0.99).
candidate(common_hot_neptune_good, 0.25, 0.95, 0.97).
candidate(common_hot_neptune_low_spec, 0.25, 0.95, 0.90).

world(w0, full_bayes_reference).
world(w1, sensitivity_only_naive).
world(w2, occurrence_sensitivity_specificity_heuristic).
world(w3, cautious_bayes_threshold).

% The Bayes world computes positive predictive value, while the other worlds
% intentionally use simpler or stricter thresholds for contrast.
ppv_planet(?candidate, ?ppv) :-
  candidate(?candidate, ?occurrence, ?sensitivity, ?specificity),
  mul(?sensitivity, ?occurrence, ?numerator),
  sub(1.0, ?occurrence, ?noplanetprior),
  sub(1.0, ?specificity, ?falsepositiverate),
  mul(?falsepositiverate, ?noplanetprior, ?falsepositivemass),
  add(?numerator, ?falsepositivemass, ?denominator),
  div(?numerator, ?denominator, ?ppv).

% The world predicates encode different modelling assumptions for the same candidate.
confirms_in_world(?candidate, w0) :-
  ppv_planet(?candidate, ?ppv),
  ge(?ppv, 0.90).

rejects_in_world(?candidate, w0) :-
  ppv_planet(?candidate, ?ppv),
  lt(?ppv, 0.90).

confirms_in_world(?candidate, w1) :-
  candidate(?candidate, ?occurrence, ?sensitivity, ?specificity),
  ge(?sensitivity, 0.95).

rejects_in_world(?candidate, w1) :-
  candidate(?candidate, ?occurrence, ?sensitivity, ?specificity),
  lt(?sensitivity, 0.95).

confirms_in_world(?candidate, w2) :-
  candidate(?candidate, ?occurrence, ?sensitivity, ?specificity),
  ge(?occurrence, 0.05),
  ge(?sensitivity, 0.90),
  ge(?specificity, 0.97).

rejects_in_world(?candidate, w2) :-
  candidate(?candidate, ?occurrence, ?sensitivity, ?specificity),
  lt(?occurrence, 0.05).

rejects_in_world(?candidate, w2) :-
  candidate(?candidate, ?occurrence, ?sensitivity, ?specificity),
  lt(?sensitivity, 0.90).

rejects_in_world(?candidate, w2) :-
  candidate(?candidate, ?occurrence, ?sensitivity, ?specificity),
  lt(?specificity, 0.97).

confirms_in_world(?candidate, w3) :-
  ppv_planet(?candidate, ?ppv),
  ge(?ppv, 0.93).

rejects_in_world(?candidate, w3) :-
  ppv_planet(?candidate, ?ppv),
  lt(?ppv, 0.93).

pattern_matches(report) :-
  confirms_in_world(rare_wide_orbit, w1),
  rejects_in_world(rare_wide_orbit, w0), rejects_in_world(rare_wide_orbit, w2), rejects_in_world(rare_wide_orbit, w3),
  confirms_in_world(mstar_short_period, w0), confirms_in_world(mstar_short_period, w1), confirms_in_world(mstar_short_period, w2), confirms_in_world(mstar_short_period, w3),
  confirms_in_world(common_hot_neptune_good, w0), confirms_in_world(common_hot_neptune_good, w1), confirms_in_world(common_hot_neptune_good, w2), rejects_in_world(common_hot_neptune_good, w3),
  confirms_in_world(common_hot_neptune_low_spec, w1),
  rejects_in_world(common_hot_neptune_low_spec, w0), rejects_in_world(common_hot_neptune_low_spec, w2), rejects_in_world(common_hot_neptune_low_spec, w3).

ppvPlanetGivenDetection(?candidate, ?ppv) :- ppv_planet(?candidate, ?ppv).
confirmsInWorld(?candidate, ?world) :- confirms_in_world(?candidate, ?world).
rejectsInWorld(?candidate, ?world) :- rejects_in_world(?candidate, ?world).
status(exoplanet_validation_worlds, expected_world_pattern) :- pattern_matches(report).
reason(exoplanet_validation_worlds, "Bayesian worlds account for occurrence and false positives while the naive world trusts sensitivity alone") :- pattern_matches(report).
