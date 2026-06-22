% Memoize shared inference layers: the score vector, disease likelihood tails,
% and expected therapy success are reused by several report relations.
% Output declarations: materialize/2 selects the relations written to this example's golden output.
%
% Read this as two stacked inference problems: first infer disease posterior
% probabilities from symptoms, then score each therapy by averaging outcomes
% over that posterior distribution. The tabled predicates are exactly the
% shared layers used by several materialized reports.
materialize(diseases, 2).
materialize(therapies, 2).
materialize(evidence, 2).
materialize(scores, 2).
materialize(evidenceTotal, 2).
materialize(posteriors, 2).
materialize(posterior, 2).
materialize(expectedSuccess, 2).
materialize(expectedAdverse, 2).
materialize(utility, 2).
materialize(recommendedTherapy, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
table(scores_for, 2).
table(likelihood, 3).
table(expected_success, 2).

% Bayes therapy decision support adapted from Eyeling bayes-therapy.n3.
% Probabilities are illustrative and are not medical advice.
% The example combines a tiny Naive Bayes diagnosis model with a therapy
% utility layer: expected utility = 10 * expectedSuccess - 3 * expectedAdverse.

diseases(case, [covid19, influenza, allergicRhinitis, bacterialPneumonia]).
therapies(case, [paxlovid, oseltamivir, supportiveCare, antibiotic, antihistamine]).
evidence(case, [
  ev(fever, true),
  ev(dryCough, true),
  ev(lossOfSmell, false),
  ev(sneezing, false),
  ev(shortBreath, false)
]).

prior(covid19, 0.05).
prior(influenza, 0.03).
prior(allergicRhinitis, 0.10).
prior(bacterialPneumonia, 0.01).

p_given(covid19, fever, 0.70).
p_given(covid19, dryCough, 0.65).
p_given(covid19, lossOfSmell, 0.40).
p_given(covid19, sneezing, 0.15).
p_given(covid19, shortBreath, 0.20).

p_given(influenza, fever, 0.80).
p_given(influenza, dryCough, 0.50).
p_given(influenza, lossOfSmell, 0.05).
p_given(influenza, sneezing, 0.20).
p_given(influenza, shortBreath, 0.10).

p_given(allergicRhinitis, fever, 0.05).
p_given(allergicRhinitis, dryCough, 0.15).
p_given(allergicRhinitis, lossOfSmell, 0.10).
p_given(allergicRhinitis, sneezing, 0.80).
p_given(allergicRhinitis, shortBreath, 0.05).

p_given(bacterialPneumonia, fever, 0.70).
p_given(bacterialPneumonia, dryCough, 0.60).
p_given(bacterialPneumonia, lossOfSmell, 0.02).
p_given(bacterialPneumonia, sneezing, 0.05).
p_given(bacterialPneumonia, shortBreath, 0.60).

therapy(paxlovid).
therapy(oseltamivir).
therapy(antihistamine).
therapy(antibiotic).
therapy(supportiveCare).

success_by_disease(paxlovid, [0.75, 0.05, 0.02, 0.05]).
success_by_disease(oseltamivir, [0.05, 0.60, 0.02, 0.05]).
success_by_disease(antihistamine, [0.10, 0.10, 0.75, 0.05]).
success_by_disease(antibiotic, [0.05, 0.05, 0.02, 0.80]).
success_by_disease(supportiveCare, [0.30, 0.30, 0.25, 0.20]).

adverse(paxlovid, 0.10).
adverse(oseltamivir, 0.08).
adverse(antihistamine, 0.03).
adverse(antibiotic, 0.07).
adverse(supportiveCare, 0.01).

benefit_weight(10).
harm_weight(3).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
factor(?disease, ev(?symptom, true), ?p) :- p_given(?disease, ?symptom, ?p).
factor(?disease, ev(?symptom, false), ?q) :-
  p_given(?disease, ?symptom, ?p),
  sub(1.0, ?p, ?q).

likelihood(?_disease, [], 1.0).
likelihood(?disease, [?evidence|?rest], ?likelihood) :-
  factor(?disease, ?evidence, ?factor),
  likelihood(?disease, ?rest, ?taillikelihood),
  mul(?factor, ?taillikelihood, ?likelihood).

% score/2 combines prior probability with the likelihood of the observed evidence.
score(?disease, ?score) :-
  prior(?disease, ?prior),
  evidence(case, ?evidence),
  likelihood(?disease, ?evidence, ?likelihood),
  mul(?prior, ?likelihood, ?score).

scores_for([], []).
scores_for([?disease|?restdiseases], [?score|?restscores]) :-
  score(?disease, ?score),
  scores_for(?restdiseases, ?restscores).

score_sum([], 0.0).
score_sum([?value|?rest], ?sum) :-
  score_sum(?rest, ?tailsum),
  add(?value, ?tailsum, ?sum).

normalize_scores([], ?_total, []).
normalize_scores([?score|?restscores], ?total, [?posterior|?restposteriors]) :-
  div(?score, ?total, ?posterior),
  normalize_scores(?restscores, ?total, ?restposteriors).

disease_posterior([?disease|?_restdiseases], [?posterior|?_restposteriors], ?disease, ?posterior).
disease_posterior([?_otherdisease|?restdiseases], [?_otherposterior|?restposteriors], ?disease, ?posterior) :-
  disease_posterior(?restdiseases, ?restposteriors, ?disease, ?posterior).

dot_product([], [], 0.0).
dot_product([?left|?restleft], [?right|?restright], ?sum) :-
  mul(?left, ?right, ?term),
  dot_product(?restleft, ?restright, ?tailsum),
  add(?term, ?tailsum, ?sum).

expected_success(?therapy, ?expectedsuccess) :-
  posteriors(case, ?posteriors),
  success_by_disease(?therapy, ?successbydisease),
  dot_product(?posteriors, ?successbydisease, ?expectedsuccess).

% utility/2 turns expected success and adverse effects into a ranking score.
utility(?therapy, ?utility) :-
  expected_success(?therapy, ?expectedsuccess),
  adverse(?therapy, ?adverse),
  benefit_weight(?benefitweight),
  harm_weight(?harmweight),
  mul(?benefitweight, ?expectedsuccess, ?benefit),
  mul(?harmweight, ?adverse, ?harmcost),
  sub(?benefit, ?harmcost, ?utility).

better_of(?therapy1, ?therapy2, ?therapy1) :-
  utility(?therapy1, ?utility1),
  utility(?therapy2, ?utility2),
  ge(?utility1, ?utility2).
better_of(?therapy1, ?therapy2, ?therapy2) :-
  utility(?therapy1, ?utility1),
  utility(?therapy2, ?utility2),
  lt(?utility1, ?utility2).

best_therapy([?therapy], ?therapy).
best_therapy([?head, ?next|?rest], ?best) :-
  best_therapy([?next|?rest], ?bestrest),
  better_of(?head, ?bestrest, ?best).

scores(case, ?scores) :-
  diseases(case, ?diseases),
  scores_for(?diseases, ?scores).
evidenceTotal(case, ?total) :-
  scores(case, ?scores),
  score_sum(?scores, ?total).
posteriors(case, ?posteriors) :-
  scores(case, ?scores),
  evidenceTotal(case, ?total),
  normalize_scores(?scores, ?total, ?posteriors).
posterior(?disease, ?posterior) :-
  diseases(case, ?diseases),
  posteriors(case, ?posteriors),
  disease_posterior(?diseases, ?posteriors, ?disease, ?posterior).
expectedSuccess(?therapy, ?expectedsuccess) :-
  therapy(?therapy),
  expected_success(?therapy, ?expectedsuccess).
expectedAdverse(?therapy, ?adverse) :-
  therapy(?therapy),
  adverse(?therapy, ?adverse).
utility(?therapy, ?utility) :-
  therapy(?therapy),
  utility(?therapy, ?utility).
recommendedTherapy(case, ?best) :-
  therapies(case, ?therapies),
  best_therapy(?therapies, ?best).
