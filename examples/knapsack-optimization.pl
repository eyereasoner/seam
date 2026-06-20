% 0/1 knapsack optimization with aggregate_max/5.
% subset/2 enumerates each possible expedition pack; total_weight/2 and total_value/2 score it.
% feasible_pack/3 enforces the capacity limit, and best_pack/3 keeps the highest-value feasible choice.
materialize(knapsack_answer, 2).

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

subset([], []).
subset([Item|Rest], [Item|Chosen]) :- subset(Rest, Chosen).
subset([_Item|Rest], Chosen) :- subset(Rest, Chosen).

item_weight(Item, Weight) :- item(Item, Weight, _Value).
item_value(Item, Value) :- item(Item, _Weight, Value).

total_weight(Items, Weight) :- findall(W, (member(Item, Items), item_weight(Item, W)), Weights), sum_list(Weights, Weight).
total_value(Items, Value) :- findall(V, (member(Item, Items), item_value(Item, V)), Values), sum_list(Values, Value).

feasible_pack(Pack, Weight, Value) :-
  items(All),
  subset(All, Pack),
  total_weight(Pack, Weight),
  capacity(Capacity),
  le(Weight, Capacity),
  total_value(Pack, Value).

best_pack(Pack, Weight, Value) :-
  aggregate_max(Value, pack(Pack, Weight), feasible_pack(Pack, Weight, Value), Value, pack(Pack, Weight)).

knapsack_answer(best_pack, Pack) :- best_pack(Pack, _Weight, _Value).
knapsack_answer(total_weight, Weight) :- best_pack(_Pack, Weight, _Value).
knapsack_answer(total_value, Value) :- best_pack(_Pack, _Weight, Value).
knapsack_answer(feasible_pack_count, Count) :- countall(feasible_pack(_Pack, _Weight, _Value), Count).
