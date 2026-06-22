% EYE reasoning-inspired example: braking safety in alternative worlds.
%
% Four simplified models classify the same road scenarios. The example is not a
% real safety calculator; it demonstrates rule-level model comparison.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(safeInWorld, 2).
materialize(riskyInWorld, 2).
materialize(status, 2).
materialize(reason, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
scenario(city_dry, 13.9, 0.8, 40.0).
scenario(highway_dry_short_gap, 27.8, 0.8, 60.0).
scenario(city_wet, 13.9, 0.4, 40.0).
scenario(city_ice, 13.9, 0.2, 30.0).

world(w0, "physics-based stopping distance with reaction time").
world(w1, "simplified braking-only rule without reaction time").
world(w2, "naive dry-road friction assumption").
world(w3, "cautious factor over the physics model").

% Derivation rules: each rule below contributes one logical step toward the displayed results.
stop_distance(?scenario, w0, ?distance) :-
  scenario(?scenario, ?v, ?mu, ?avail),
  mul(?v, 1.0, ?reaction),
  pow(?v, 2.0, ?v2),
  mul(?mu, 2.0, ?m2),
  mul(?m2, 9.8, ?denom),
  div(?v2, ?denom, ?braking),
  add(?reaction, ?braking, ?distance).

stop_distance(?scenario, w1, ?distance) :-
  scenario(?scenario, ?v, ?mu, ?avail),
  pow(?v, 2.0, ?v2),
  mul(?mu, 2.0, ?m2),
  mul(?m2, 10.0, ?denom),
  div(?v2, ?denom, ?distance).

stop_distance(?scenario, w2, ?distance) :-
  scenario(?scenario, ?v, ?mu, ?avail),
  pow(?v, 2.0, ?v2),
  div(?v2, 14.0, ?distance).

stop_distance(?scenario, w3, ?distance) :-
  stop_distance(?scenario, w0, ?w0distance),
  mul(?w0distance, 1.5, ?distance).

safe_in_world(?scenario, ?world) :-
  scenario(?scenario, ?v, ?mu, ?avail),
  stop_distance(?scenario, ?world, ?distance),
  le(?distance, ?avail).

risky_in_world(?scenario, ?world) :-
  scenario(?scenario, ?v, ?mu, ?avail),
  stop_distance(?scenario, ?world, ?distance),
  gt(?distance, ?avail).

pattern_matches(report) :-
  safe_in_world(city_dry, w0), safe_in_world(city_dry, w1), safe_in_world(city_dry, w2), safe_in_world(city_dry, w3),
  risky_in_world(highway_dry_short_gap, w0), risky_in_world(highway_dry_short_gap, w3),
  safe_in_world(highway_dry_short_gap, w1), safe_in_world(highway_dry_short_gap, w2),
  safe_in_world(city_wet, w0), safe_in_world(city_wet, w1), safe_in_world(city_wet, w2), risky_in_world(city_wet, w3),
  risky_in_world(city_ice, w0), risky_in_world(city_ice, w1), risky_in_world(city_ice, w3), safe_in_world(city_ice, w2).

safeInWorld(?scenario, ?world) :- safe_in_world(?scenario, ?world).
riskyInWorld(?scenario, ?world) :- risky_in_world(?scenario, ?world).
status(braking_safety_worlds, expected_world_pattern) :- pattern_matches(report).
reason(braking_safety_worlds, "simplified and naive worlds can be optimistic while the cautious world tightens the reference model") :- pattern_matches(report).
