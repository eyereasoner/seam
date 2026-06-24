% EYE-inspired electric-vehicle range worlds.
%
% The same trips are evaluated under four modelling worlds: base consumption,
% speed-aware consumption, physics-aware consumption, and physics plus safety
% reserve.  This makes the output a small possible-worlds comparison.
materialize(safeInWorld, 2).
materialize(riskyInWorld, 2).
materialize(reason, 2).
materialize(status, 2).

% trip_data/7 stores distance, speed, temperature, payload, battery, and base
% energy use.  The factors below adjust base consumption rather than duplicating
% one rule per trip/world pair.
trip(city_errand).
trip(winter_highway).
trip(heavy_delivery).
trip(cold_commute).

% trip_data(Trip, DistanceKm, SpeedKmh, TemperatureC, PayloadKg, BatteryKWh, BaseKWhPerKm).
trip_data(city_errand, 40, 45, 20, 100, 30, 0.18).
trip_data(winter_highway, 260, 115, -5, 400, 60, 0.20).
trip_data(heavy_delivery, 180, 80, 15, 700, 55, 0.22).
trip_data(cold_commute, 120, 90, -8, 100, 35, 0.19).

% Each world adds a different combination of speed, temperature, payload, and
% reserve factors before comparing required energy with usable battery.
speed_factor(?t, 1.20) :- trip_data(?t, ?, ?s, ?, ?, ?, ?), gt(?s, 100).
speed_factor(?t, 1.00) :- trip_data(?t, ?, ?s, ?, ?, ?, ?), le(?s, 100).

temperature_factor(?t, 1.15) :- trip_data(?t, ?, ?, ?temp, ?, ?, ?), lt(?temp, 0).
temperature_factor(?t, 1.00) :- trip_data(?t, ?, ?, ?temp, ?, ?, ?), ge(?temp, 0).

payload_factor(?t, 1.15) :- trip_data(?t, ?, ?, ?, ?p, ?, ?), gt(?p, 500).
payload_factor(?t, 1.08) :- trip_data(?t, ?, ?, ?, ?p, ?, ?), gt(?p, 250), le(?p, 500).
payload_factor(?t, 1.00) :- trip_data(?t, ?, ?, ?, ?p, ?, ?), le(?p, 250).

base_energy(?t, ?e) :-
  trip_data(?t, ?d, ?, ?, ?, ?, ?b),
  mul(?d, ?b, ?e).

required_energy(?t, w1, ?e) :-
  base_energy(?t, ?e).

required_energy(?t, w2, ?e) :-
  base_energy(?t, ?base),
  speed_factor(?t, ?sf),
  mul(?base, ?sf, ?e).

required_energy(?t, w0, ?e) :-
  base_energy(?t, ?base),
  speed_factor(?t, ?sf),
  temperature_factor(?t, ?tf),
  payload_factor(?t, ?pf),
  mul(?base, ?sf, ?a),
  mul(?a, ?tf, ?b),
  mul(?b, ?pf, ?e).

required_energy(?t, w3, ?e) :-
  required_energy(?t, w0, ?w0),
  mul(?w0, 1.30, ?e).

% safe_in_world/2 compares required trip energy with usable battery capacity.
safe_in_world(?t, ?w) :-
  trip_data(?t, ?, ?, ?, ?, ?battery, ?),
  required_energy(?t, ?w, ?required),
  le(?required, ?battery).

risky_in_world(?t, ?w) :-
  trip_data(?t, ?, ?, ?, ?, ?battery, ?),
  required_energy(?t, ?w, ?required),
  gt(?required, ?battery).

safeInWorld(?t, ?w) :- safe_in_world(?t, ?w).
riskyInWorld(?t, ?w) :- risky_in_world(?t, ?w).
reason(winter_highway, "cold fast payload trip exceeds battery in physics-aware worlds") :-
  risky_in_world(winter_highway, w0),
  risky_in_world(winter_highway, w2),
  risky_in_world(winter_highway, w3),
  safe_in_world(winter_highway, w1).
reason(heavy_delivery, "safety buffer turns a physics-safe delivery into a cautious risk") :-
  safe_in_world(heavy_delivery, w0),
  risky_in_world(heavy_delivery, w3).
status(ev_range_worlds, expected_world_pattern) :-
  safe_in_world(city_errand, w3),
  risky_in_world(winter_highway, w0),
  risky_in_world(heavy_delivery, w3),
  safe_in_world(cold_commute, w3).
