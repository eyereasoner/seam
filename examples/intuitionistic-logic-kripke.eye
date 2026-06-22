% Intuitionistic logic emulation with a finite Kripke model.
%
% The preorder leq/2 represents information growth: later worlds contain at
% least as much information as earlier worlds.  Atomic facts persist upward, and
% implication is checked at every future world.  This lets the example show a
% constructive implication that holds while excluded middle is not forced at the
% root world.
materialize(intuitionistic_truth, 3).
materialize(intuitionistic_countermodel, 3).

table(leq, 2).
table(forces, 2).

world(root).
world(left).
world(right).
world(both).

step(root, left).
step(root, right).
step(left, both).
step(right, both).

base(left, p).
base(right, q).

leq(?world, ?world) :- world(?world).
leq(?from, ?to) :- step(?from, ?mid), leq(?mid, ?to).

% Upward persistence for atoms: if P becomes known at SomeWorld, every later
% world also forces P.
forces(?world, atom(?prop)) :-
  leq(?someworld, ?world),
  base(?someworld, ?prop).

forces(?world, and(?left, ?right)) :-
  forces(?world, ?left),
  forces(?world, ?right).

forces(?world, or(?left, ?_right)) :- forces(?world, ?left).
forces(?world, or(?_left, ?right)) :- forces(?world, ?right).

% A -> B holds at World when no future world has A without B.
forces(?world, implies(?left, ?right)) :-
  world(?world),
  not(bad_implication(?world, ?left, ?right)).

forces(?world, neg(?formula)) :-
  forces(?world, implies(?formula, bottom)).

bad_implication(?world, ?left, ?right) :-
  leq(?world, ?future),
  forces(?future, ?left),
  not(forces(?future, ?right)).

intuitionistic_truth(monotone_p_reaches_both, both, atom(p)) :-
  forces(both, atom(p)).

intuitionistic_truth(constructive_case_analysis, root, implies(atom(p), or(atom(p), atom(q)))) :-
  forces(root, implies(atom(p), or(atom(p), atom(q)))).

intuitionistic_truth(double_negated_branch_information, root, neg(neg(or(atom(p), atom(q))))) :-
  forces(root, neg(neg(or(atom(p), atom(q))))).

intuitionistic_countermodel(root_does_not_decide_branch, root, or(atom(p), atom(q))) :-
  not(forces(root, or(atom(p), atom(q)))).

intuitionistic_countermodel(excluded_middle_not_forced, root, or(atom(p), neg(atom(p)))) :-
  not(forces(root, or(atom(p), neg(atom(p))))).
