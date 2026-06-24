% Markov Logic Network style scoring over a tiny finite domain.
%
% Eyelang is deterministic, so this is not a probabilistic MLN engine.  The
% example encodes the usual MLN MAP idea explicitly: enumerate possible worlds,
% mark which weighted soft formulas each world satisfies, sum the weights, and
% choose the highest-scoring world.  Weights are stored as integer tenths of a
% log weight so the example stays reproducible without floating-point noise.

materialize(mlnWeight, 2).
materialize(mlnWorld, 2).
materialize(mlnSatisfied, 2).
materialize(mlnViolated, 2).
materialize(mlnContribution, 3).
materialize(mlnWorldScore, 2).
materialize(mlnMapWorld, 2).
materialize(mlnConclusion, 2).

% Evidence and candidate hidden assignments.
person(alice).
person(bob).
friend(alice, bob).
observed_smokes(alice).

candidate_world(w_bob_not_smokes_not_cancer, no, no).
candidate_world(w_bob_not_smokes_cancer, no, yes).
candidate_world(w_bob_smokes_not_cancer, yes, no).
candidate_world(w_bob_smokes_cancer, yes, yes).

% Soft formulas are weighted log features.
formula_weight_tenths(friend_smoking, 20).
formula_weight_tenths(smoking_causes_cancer, 13).
formula_weight_tenths(cancer_is_rare, 6).

% World interpretation for Bob.  Alice's smoking status is observed evidence.
smokes_in_world(?world, alice) :-
  candidate_world(?world, ?, ?),
  observed_smokes(alice).
smokes_in_world(?world, bob) :- candidate_world(?world, yes, ?).
cancer_in_world(?world, bob) :- candidate_world(?world, ?, yes).

% Grounded soft formulas for this tiny domain:
%   friend_smoking:        friend(alice,bob) and smokes(alice) => smokes(bob)
%   smoking_causes_cancer: smokes(bob) => cancer(bob)
%   cancer_is_rare:        not cancer(bob)
formula_satisfied(?world, friend_smoking) :-
  friend(alice, bob),
  smokes_in_world(?world, alice),
  smokes_in_world(?world, bob).

formula_satisfied(?world, smoking_causes_cancer) :-
  candidate_world(?world, no, ?).
formula_satisfied(?world, smoking_causes_cancer) :-
  smokes_in_world(?world, bob),
  cancer_in_world(?world, bob).

formula_satisfied(?world, cancer_is_rare) :-
  candidate_world(?world, ?, no).

formula_violated(?world, ?formula) :-
  candidate_world(?world, ?, ?),
  formula_weight_tenths(?formula, ?),
  not(formula_satisfied(?world, ?formula)).

contribution_tenths(?world, ?formula, ?weight) :-
  formula_satisfied(?world, ?formula),
  formula_weight_tenths(?formula, ?weight).

world_score_tenths(?world, ?score) :-
  candidate_world(?world, ?, ?),
  sumall(?weight, contribution_tenths(?world, ?formula, ?weight), ?score).

map_world(?world, ?score) :-
  aggregate_max(?candidate_score, ?candidate_world,
    world_score_tenths(?candidate_world, ?candidate_score),
    ?score, ?world).

mlnWeight(?formula, log_weight_tenths(?weight)) :- formula_weight_tenths(?formula, ?weight).
mlnWorld(?world, world(smokes(bob, ?smokes), cancer(bob, ?cancer))) :-
  candidate_world(?world, ?smokes, ?cancer).
mlnSatisfied(?world, ?formula) :- formula_satisfied(?world, ?formula).
mlnViolated(?world, ?formula) :- formula_violated(?world, ?formula).
mlnContribution(?world, ?formula, log_weight_tenths(?weight)) :-
  contribution_tenths(?world, ?formula, ?weight).
mlnWorldScore(?world, log_weight_tenths(?score)) :- world_score_tenths(?world, ?score).
mlnMapWorld(?world, log_weight_tenths(?score)) :- map_world(?world, ?score).
mlnConclusion(case, "MAP world predicts that Bob smokes and has cancer") :-
  map_world(w_bob_smokes_cancer, ?).
