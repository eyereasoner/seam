% Illegitimate reasoning detector.
%
% The input facts describe arguments and their surface reasoning pattern. Helper
% predicates identify common invalid inference forms. The output layer emits only
% concise report relations: the argument is illegitimate, which fallacy was found,
% the challenged conclusion, and a short reason why.

% Affirming the consequent:
%   If it rained, the street is wet. The street is wet. Therefore it rained.
% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(type, 2).
materialize(fallacy, 2).
materialize(conclusion, 2).
materialize(reason, 2).
materialize(sampleSize, 2).
materialize(requiredSampleSize, 2).
materialize(omittedAlternative, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
argument(arg_affirming_consequent).
implication(arg_affirming_consequent, rain, street_wet).
observed(arg_affirming_consequent, street_wet).
concludes(arg_affirming_consequent, rain).

% Denying the antecedent:
%   If the key is present, the door opens. The key is not present. Therefore the door does not open.
argument(arg_denying_antecedent).
implication(arg_denying_antecedent, key_present, door_opens).
observed(arg_denying_antecedent, neg(key_present)).
concludes(arg_denying_antecedent, neg(door_opens)).

% Hasty generalization:
%   Three sampled cases are treated as enough for a universal conclusion.
argument(arg_hasty_generalization).
sample_size(arg_hasty_generalization, 3).
required_sample_size(arg_hasty_generalization, 30).
concludes(arg_hasty_generalization, all(crows, black)).

% False dilemma:
%   Only two choices are presented even though a relevant third option exists.
argument(arg_false_dilemma).
presented_alternatives(arg_false_dilemma, [approve_now, reject_forever]).
omitted_alternative(arg_false_dilemma, revise_proposal).
concludes(arg_false_dilemma, approve_now).

% A contrast case: modus ponens is not flagged.
argument(arg_modus_ponens).
implication(arg_modus_ponens, subscription_paid, access_allowed).
observed(arg_modus_ponens, subscription_paid).
concludes(arg_modus_ponens, access_allowed).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
fallacy(?a, affirming_consequent) :-
  argument(?a),
  implication(?a, ?antecedent, ?consequent),
  observed(?a, ?consequent),
  concludes(?a, ?antecedent).

fallacy(?a, denying_antecedent) :-
  argument(?a),
  implication(?a, ?antecedent, ?consequent),
  observed(?a, neg(?antecedent)),
  concludes(?a, neg(?consequent)).

fallacy(?a, hasty_generalization) :-
  argument(?a),
  sample_size(?a, ?n),
  required_sample_size(?a, ?min),
  lt(?n, ?min),
  concludes(?a, all(?, ?)).

fallacy(?a, false_dilemma) :-
  argument(?a),
  presented_alternatives(?a, ?),
  omitted_alternative(?a, ?),
  concludes(?a, ?).

reason(arg_affirming_consequent, "observing the consequent does not prove the antecedent").
reason(arg_denying_antecedent, "denying the antecedent does not disprove the consequent").
reason(arg_hasty_generalization, "sample size is below the threshold for a universal conclusion").
reason(arg_false_dilemma, "a relevant alternative is omitted").

type(?a, illegitimate_reasoning) :- fallacy(?a, ?).
conclusion(?a, ?c) :- fallacy(?a, ?), concludes(?a, ?c).
reason(?a, ?r) :- fallacy(?a, ?), reason(?a, ?r).
sampleSize(?a, ?n) :- fallacy(?a, hasty_generalization), sample_size(?a, ?n).
requiredSampleSize(?a, ?min) :- fallacy(?a, hasty_generalization), required_sample_size(?a, ?min).
omittedAlternative(?a, ?alt) :- fallacy(?a, false_dilemma), omitted_alternative(?a, ?alt).
