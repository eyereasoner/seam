% Bounded drone corridor planner adapted from Eyeling drone-corridor-planner.n3.
% States track city, battery level, and corridor permit.  A finite fuel list
% bounds recursion; path/9 sums duration and cost while multiplying belief and
% comfort.  Memoization helps because many surviving-plan checks reuse prefixes.

materialize(gps_plan, 2).

table(path, 9).

fuel(fuel7, [t, t, t, t, t, t, t]).

step(state(gent, full, ?p), state(brugge, mid, ?p), fly_gent_brugge, 1500.0, 0.006, 0.99, 0.99).
step(state(gent, ?b, ?p), state(brugge, ?b, ?p), train_gent_brugge, 1700.0, 0.012, 0.999, 0.995).
step(state(gent, full, ?p), state(kortrijk, mid, ?p), fly_gent_kortrijk, 1600.0, 0.007, 0.99, 0.99).
step(state(kortrijk, mid, ?p), state(brugge, low, ?p), fly_kortrijk_brugge, 1600.0, 0.007, 0.99, 0.99).
step(state(brugge, mid, ?p), state(kortrijk, low, ?p), fly_brugge_kortrijk, 1600.0, 0.007, 0.985, 0.98).
step(state(kortrijk, ?b, none), state(kortrijk, ?b, yes), get_zone_permit_kortrijk, 300.0, 0.001, 0.999, 1.0).
step(state(brugge, ?b, none), state(brugge, ?b, yes), buy_permit_brugge, 450.0, 0.002, 0.98, 1.0).
step(state(brugge, low, ?p), state(brugge, full, ?p), quick_charge_brugge, 600.0, 0.004, 0.999, 0.97).
step(state(brugge, mid, ?p), state(brugge, full, ?p), topup_brugge, 400.0, 0.003, 0.999, 0.98).
step(state(kortrijk, mid, ?p), state(kortrijk, full, ?p), emergency_charge_kortrijk, 500.0, 0.003, 0.999, 0.95).
step(state(brugge, full, yes), state(oostende, mid, yes), cross_corridor_brugge_oostende, 900.0, 0.004, 0.98, 1.0).
step(state(brugge, mid, ?p), state(oostende, low, ?p), public_coastline_brugge_oostende, 1300.0, 0.006, 0.97, 0.96).
step(state(brugge, full, ?p), state(oostende, mid, ?p), public_coastline_brugge_oostende, 1200.0, 0.006, 0.975, 0.96).
step(state(kortrijk, full, yes), state(oostende, mid, yes), direct_corridor_kortrijk_oostende, 1100.0, 0.009, 0.955, 0.92).

path(?from, ?to, [?act], ?duration, ?cost, ?belief, ?comfort, ?fuelin, ?fuelout) :-
  step(?from, ?to, ?act, ?duration, ?cost, ?belief, ?comfort),
  rest(?fuelin, ?fuelout).

path(?from, ?to, ?actions, ?duration, ?cost, ?belief, ?comfort, ?fuelin, ?fuelout) :-
  step(?from, ?mid, ?act, ?d1, ?c1, ?b1, ?m1),
  rest(?fuelin, ?fuelmid),
  path(?mid, ?to, ?restactions, ?d2, ?c2, ?b2, ?m2, ?fuelmid, ?fuelout),
  append([?act], ?restactions, ?actions),
  add(?d1, ?d2, ?duration),
  add(?c1, ?c2, ?cost),
  mul(?b1, ?b2, ?belief),
  mul(?m1, ?m2, ?comfort).

surviving_plan(?actions, ?duration, ?cost, ?belief, ?comfort, ?battery, ?permit, ?fuelleft) :-
  fuel(fuel7, ?fuel),
  path(state(gent, full, none), state(oostende, ?battery, ?permit), ?actions, ?duration, ?cost, ?belief, ?comfort, ?fuel, ?fuelleft),
  gt(?belief, 0.94),
  lt(?cost, 0.03).

gps_plan(d1, plan(?actions, ?duration, ?cost, ?belief, ?comfort, ?battery, ?permit, ?fuelleft)) :-
  surviving_plan(?actions, ?duration, ?cost, ?belief, ?comfort, ?battery, ?permit, ?fuelleft).
