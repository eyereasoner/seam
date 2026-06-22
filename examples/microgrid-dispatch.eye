% Representative example: microgrid dispatch planning.
%
% The rules compute renewable supply, reserve-aware battery dispatch, remaining
% grid import, and a concise feasibility report for a campus microgrid interval.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
%
% The dispatch policy is greedy but auditable: use renewables first, discharge
% the battery only down to reserve, then import the remaining deficit from grid.
materialize(renewablePower_kW, 2).
materialize(batteryDispatch_kW, 2).
materialize(gridImport_kW, 2).
materialize(reserveAfterDispatch_kW, 2).
materialize(status, 2).
materialize(reason, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
site(campus_interval_17).

load_kW(campus_interval_17, 620.0).
solar_kW(campus_interval_17, 180.0).
wind_kW(campus_interval_17, 90.0).
battery_max_discharge_kW(campus_interval_17, 320.0).
required_battery_reserve_kW(campus_interval_17, 80.0).
grid_contract_limit_kW(campus_interval_17, 150.0).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
renewable_kW(?site, ?renewable) :-
  solar_kW(?site, ?solar),
  wind_kW(?site, ?wind),
  add(?solar, ?wind, ?renewable).

net_deficit_kW(?site, ?deficit) :-
  load_kW(?site, ?load),
  renewable_kW(?site, ?renewable),
  sub(?load, ?renewable, ?deficit).

reserve_aware_battery_limit_kW(?site, ?limit) :-
  battery_max_discharge_kW(?site, ?maxdischarge),
  required_battery_reserve_kW(?site, ?reserve),
  sub(?maxdischarge, ?reserve, ?limit).

battery_dispatch_kW(?site, ?dispatch) :-
  net_deficit_kW(?site, ?deficit),
  reserve_aware_battery_limit_kW(?site, ?limit),
  min(?deficit, ?limit, ?dispatch).

grid_import_kW(?site, ?import) :-
  net_deficit_kW(?site, ?deficit),
  battery_dispatch_kW(?site, ?dispatch),
  sub(?deficit, ?dispatch, ?import).

battery_reserve_after_dispatch_kW(?site, ?reserveleft) :-
  battery_max_discharge_kW(?site, ?maxdischarge),
  battery_dispatch_kW(?site, ?dispatch),
  sub(?maxdischarge, ?dispatch, ?reserveleft).

contract_ok(?site) :-
  grid_import_kW(?site, ?import),
  grid_contract_limit_kW(?site, ?limit),
  le(?import, ?limit).

reserve_ok(?site) :-
  battery_reserve_after_dispatch_kW(?site, ?reserveleft),
  required_battery_reserve_kW(?site, ?required),
  ge(?reserveleft, ?required).

% stable_dispatch/1 passes only when contract and reserve constraints remain satisfied.
stable_dispatch(?site) :-
  contract_ok(?site),
  reserve_ok(?site).

renewablePower_kW(?site, ?renewable) :-
  renewable_kW(?site, ?renewable).

batteryDispatch_kW(?site, ?dispatch) :-
  battery_dispatch_kW(?site, ?dispatch).

gridImport_kW(?site, ?import) :-
  grid_import_kW(?site, ?import).

reserveAfterDispatch_kW(?site, ?reserveleft) :-
  battery_reserve_after_dispatch_kW(?site, ?reserveleft).

status(?site, stable_dispatch) :-
  stable_dispatch(?site).

reason(?site, "battery dispatch covers the deficit while preserving reserve and grid contract limits") :-
  stable_dispatch(?site).
