% Ambitious STEM example: Hohmann transfer design from Earth orbit to Mars orbit.
%
% The rules combine orbital mechanics, numerical math, and engineering-style
% mission constraints. Distances are in kilometres, speeds in kilometres per
% second, and time in days.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
%
% The design is a Hohmann-transfer estimate: compute transfer orbit geometry,
% departure/arrival burns, total delta-v, transfer time, and budget status.
materialize(transferSemiMajorAxis_km, 2).
materialize(departureDeltaV_km_s, 2).
materialize(arrivalDeltaV_km_s, 2).
materialize(totalDeltaV_km_s, 2).
materialize(transferTime_days, 2).
materialize(status, 2).
materialize(reason, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
mission(mars_hohmann, centralBodyMu_km3_s2, 132712440018.0).
mission(mars_hohmann, departureOrbitRadius_km, 149597870.7).
mission(mars_hohmann, arrivalOrbitRadius_km, 227939200.0).
mission(mars_hohmann, deltaVBudget_km_s, 6.0).
mission(mars_hohmann, pi, 3.141592653589793).
mission(mars_hohmann, secondsPerDay, 86400.0).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
semi_major_axis(?mission, ?axis) :-
  mission(?mission, departureOrbitRadius_km, ?r1),
  mission(?mission, arrivalOrbitRadius_km, ?r2),
  add(?r1, ?r2, ?sum),
  div(?sum, 2.0, ?axis).

circular_speed_at_departure(?mission, ?speed) :-
  mission(?mission, centralBodyMu_km3_s2, ?mu),
  mission(?mission, departureOrbitRadius_km, ?radius),
  div(?mu, ?radius, ?speedsquared),
  pow(?speedsquared, 0.5, ?speed).

circular_speed_at_arrival(?mission, ?speed) :-
  mission(?mission, centralBodyMu_km3_s2, ?mu),
  mission(?mission, arrivalOrbitRadius_km, ?radius),
  div(?mu, ?radius, ?speedsquared),
  pow(?speedsquared, 0.5, ?speed).

transfer_speed_at_departure(?mission, ?speed) :-
  mission(?mission, centralBodyMu_km3_s2, ?mu),
  mission(?mission, departureOrbitRadius_km, ?radius),
  semi_major_axis(?mission, ?axis),
  div(2.0, ?radius, ?twiceoverradius),
  div(1.0, ?axis, ?oneoveraxis),
  sub(?twiceoverradius, ?oneoveraxis, ?bracket),
  mul(?mu, ?bracket, ?speedsquared),
  pow(?speedsquared, 0.5, ?speed).

transfer_speed_at_arrival(?mission, ?speed) :-
  mission(?mission, centralBodyMu_km3_s2, ?mu),
  mission(?mission, arrivalOrbitRadius_km, ?radius),
  semi_major_axis(?mission, ?axis),
  div(2.0, ?radius, ?twiceoverradius),
  div(1.0, ?axis, ?oneoveraxis),
  sub(?twiceoverradius, ?oneoveraxis, ?bracket),
  mul(?mu, ?bracket, ?speedsquared),
  pow(?speedsquared, 0.5, ?speed).

departure_delta_v(?mission, ?deltav) :-
  transfer_speed_at_departure(?mission, ?transferspeed),
  circular_speed_at_departure(?mission, ?circularspeed),
  sub(?transferspeed, ?circularspeed, ?deltav).

arrival_delta_v(?mission, ?deltav) :-
  circular_speed_at_arrival(?mission, ?circularspeed),
  transfer_speed_at_arrival(?mission, ?transferspeed),
  sub(?circularspeed, ?transferspeed, ?deltav).

total_delta_v(?mission, ?total) :-
  departure_delta_v(?mission, ?depart),
  arrival_delta_v(?mission, ?arrive),
  add(?depart, ?arrive, ?total).

transfer_time_days(?mission, ?days) :-
  semi_major_axis(?mission, ?axis),
  mission(?mission, centralBodyMu_km3_s2, ?mu),
  mission(?mission, pi, ?pi),
  mission(?mission, secondsPerDay, ?secondsperday),
  pow(?axis, 3.0, ?axiscubed),
  div(?axiscubed, ?mu, ?timefactor),
  pow(?timefactor, 0.5, ?halfperiodbase),
  mul(?pi, ?halfperiodbase, ?seconds),
  div(?seconds, ?secondsperday, ?days).

within_delta_v_budget(?mission) :-
  total_delta_v(?mission, ?total),
  mission(?mission, deltaVBudget_km_s, ?budget),
  le(?total, ?budget).

transferSemiMajorAxis_km(?mission, ?axis) :-
  semi_major_axis(?mission, ?axis).

departureDeltaV_km_s(?mission, ?deltav) :-
  departure_delta_v(?mission, ?deltav).

arrivalDeltaV_km_s(?mission, ?deltav) :-
  arrival_delta_v(?mission, ?deltav).

totalDeltaV_km_s(?mission, ?total) :-
  total_delta_v(?mission, ?total).

transferTime_days(?mission, ?days) :-
  transfer_time_days(?mission, ?days).

status(?mission, feasible_reference_transfer) :-
  within_delta_v_budget(?mission).

reason(?mission, "total Hohmann transfer delta-v is within the mission budget") :-
  within_delta_v_budget(?mission).
