% Register allocation as bounded graph coloring with spilling.
%
% Production allocators combine liveness analysis, interference graphs, register
% classes, coalescing, rematerialization, and spill-code insertion.  This Eyelang
% example reduces the problem to its logical core: enumerate assignments of a
% few temporaries to two registers or memory, reject register conflicts, and use
% aggregate_min/5 to choose the cheapest spill plan.

materialize(registerAnswer, 2).

% Two physical registers are available.  The synthetic place spill means the
% temporary is kept in memory instead of a register.
register(r1).
register(r2).
place(?reg) :- register(?reg).
place(spill).

% Temporaries and the cost of spilling each one.  The triangle a-b-c cannot be
% colored with only two registers, so at least one of them must spill.
temporary(a, 10).
temporary(b, 1).
temporary(c, 10).
temporary(d, 2).

interferes(a, b).
interferes(b, c).
interferes(c, a).
interferes(c, d).

% A candidate allocation is an immutable list of bindings.  This is deliberately
% brute force: three choices for each of four temporaries.
candidate_allocation([
  bind(a, ?a_place),
  bind(b, ?b_place),
  bind(c, ?c_place),
  bind(d, ?d_place)
]) :-
  place(?a_place),
  place(?b_place),
  place(?c_place),
  place(?d_place).

assigned(?var, [[?var, ?place] | ?], ?place).
assigned(?var, [bind(?var, ?place) | ?], ?place).
assigned(?var, [bind(?, ?) | ?rest], ?place) :- assigned(?var, ?rest, ?place).

% A conflict exists only when both interfering temporaries choose the same real
% register.  Spilled temporaries do not occupy registers.
allocation_conflict(?allocation) :-
  interferes(?left, ?right),
  assigned(?left, ?allocation, ?reg),
  assigned(?right, ?allocation, ?reg),
  register(?reg).

valid_allocation(?allocation) :-
  candidate_allocation(?allocation),
  not(allocation_conflict(?allocation)).

spill_cost_of_place(?var, spill, ?cost) :- temporary(?var, ?cost).
spill_cost_of_place(?var, ?reg, 0) :- temporary(?var, ?), register(?reg).

allocation_cost(?allocation, ?cost) :-
  findall(?item_cost,
    (member(bind(?var, ?place), ?allocation), spill_cost_of_place(?var, ?place, ?item_cost)),
    ?costs),
  sum_list(?costs, ?cost).

best_allocation(?allocation, ?cost) :-
  aggregate_min([?candidate_cost, ?candidate], ?candidate,
    (valid_allocation(?candidate), allocation_cost(?candidate, ?candidate_cost)),
    [?cost, ?allocation], ?allocation).

registerAnswer(best_allocation, ?allocation) :- best_allocation(?allocation, ?).
registerAnswer(spill_cost, ?cost) :- best_allocation(?, ?cost).
registerAnswer(place(?var), ?place) :- best_allocation(?allocation, ?), assigned(?var, ?allocation, ?place).
registerAnswer(valid_allocation_count, ?count) :- countall(valid_allocation(?), ?count).
registerAnswer(note, "the cheapest solution spills b to color the a-b-c triangle with two registers") :- best_allocation(?, ?).
