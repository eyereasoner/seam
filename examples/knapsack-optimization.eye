% 0/1 knapsack optimization with aggregate_max/5.
%
% subset/2 enumerates candidate expedition packs; total_weight/2 and total_value/2
% score each pack.  feasible_pack/3 applies the capacity limit, and best_pack/3
% keeps the highest-value feasible choice together with its weight.
materialize(knapsack_answer, 2).

% Capacity and item table are separated from the optimization rule for easy tuning.
capacity(15).
items([atlas, battery, camera, drone, emergency_radio, field_laptop, medkit, sensor]).

item(atlas, 2, 6).
item(battery, 4, 10).
item(camera, 3, 8).
item(drone, 6, 13).
item(emergency_radio, 5, 11).
item(field_laptop, 7, 16).
item(medkit, 4, 9).
item(sensor, 2, 7).

% The include/exclude subset generator explores every 0/1 choice once.
subset([], []).
subset([?item|?rest], [?item|?chosen]) :- subset(?rest, ?chosen).
subset([?_item|?rest], ?chosen) :- subset(?rest, ?chosen).

item_weight(?item, ?weight) :- item(?item, ?weight, ?_value).
item_value(?item, ?value) :- item(?item, ?_weight, ?value).

total_weight(?items, ?weight) :- findall(?w, (member(?item, ?items), item_weight(?item, ?w)), ?weights), sum_list(?weights, ?weight).
total_value(?items, ?value) :- findall(?v, (member(?item, ?items), item_value(?item, ?v)), ?values), sum_list(?values, ?value).

feasible_pack(?pack, ?weight, ?value) :-
  items(?all),
  subset(?all, ?pack),
  total_weight(?pack, ?weight),
  capacity(?capacity),
  le(?weight, ?capacity),
  total_value(?pack, ?value).

best_pack(?pack, ?weight, ?value) :-
  aggregate_max(?value, pack(?pack, ?weight), feasible_pack(?pack, ?weight, ?value), ?value, pack(?pack, ?weight)).

knapsack_answer(best_pack, ?pack) :- best_pack(?pack, ?_weight, ?_value).
knapsack_answer(total_weight, ?weight) :- best_pack(?_pack, ?weight, ?_value).
knapsack_answer(total_value, ?value) :- best_pack(?_pack, ?_weight, ?value).
knapsack_answer(feasible_pack_count, ?count) :- countall(feasible_pack(?_pack, ?_weight, ?_value), ?count).
