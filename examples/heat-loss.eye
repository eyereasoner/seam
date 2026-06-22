% Engineering example: one-dimensional conductive heat loss through a wall.
%
% Thermal resistance is L/(k*A), and heat loss is DeltaT/R.  The facts store wall
% properties as a small attribute table, while rules derive temperature
% difference, resistance, heat loss, and a qualitative status.
%
% Keeping each physical quantity as its own relation makes the proof explanation
% read like a worked calculation.
materialize(type, 2).
materialize(temperatureDifference_K, 2).
materialize(thermalResistance_K_W, 2).
materialize(heatLoss_W, 2).
materialize(status, 2).

% Wall properties are stored as key/value facts: conductivity, area, thickness,
% and inside/outside temperatures.
wall(wall1, conductivity_W_mK, 0.8).
wall(wall1, area_m2, 12.0).
wall(wall1, thickness_m, 0.2).
wall(wall1, indoor_C, 21.0).
wall(wall1, outdoor_C, -4.0).

% The model first derives the temperature difference and thermal resistance,
% then divides DeltaT by resistance to classify the heat loss.
temperature_difference(?wall, ?deltat) :-
  wall(?wall, indoor_C, ?indoor),
  wall(?wall, outdoor_C, ?outdoor),
  sub(?indoor, ?outdoor, ?deltat).

thermal_resistance(?wall, ?resistance) :-
  wall(?wall, thickness_m, ?thickness),
  wall(?wall, conductivity_W_mK, ?conductivity),
  wall(?wall, area_m2, ?area),
  mul(?conductivity, ?area, ?conductance),
  div(?thickness, ?conductance, ?resistance).

heat_loss(?wall, ?heatloss) :-
  temperature_difference(?wall, ?deltat),
  thermal_resistance(?wall, ?resistance),
  div(?deltat, ?resistance, ?heatloss).

type(?wall, conduction_heat_loss) :-
  wall(?wall, thickness_m, ?_thickness).

temperatureDifference_K(?wall, ?deltat) :-
  temperature_difference(?wall, ?deltat).

thermalResistance_K_W(?wall, ?resistance) :-
  thermal_resistance(?wall, ?resistance).

heatLoss_W(?wall, ?heatloss) :-
  heat_loss(?wall, ?heatloss).

status(?wall, high_heat_loss) :-
  heat_loss(?wall, ?heatloss),
  gt(?heatloss, 1000.0).
