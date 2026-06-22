% Bayesian diagnosis adapted from Eyeling bayes-diagnosis.n3.
% The integer-scaled rules keep the model executable in eyelang.  The emitted
% relations use Eyeling's full posterior vocabulary instead of rounded basis
% points, so this example is comparable with examples/output/bayes-diagnosis.n3
% in the Eyeling repository.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(scores, 2).
materialize(evidenceTotal, 2).
materialize(result, 2).
materialize(disease, 2).
materialize(unnormalized, 2).
materialize(posterior, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
disease(covid19).
disease(influenza).
disease(allergicRhinitis).
disease(bacterialPneumonia).

prior(covid19, 50).
prior(influenza, 30).
prior(allergicRhinitis, 100).
prior(bacterialPneumonia, 10).

p_given(covid19, fever, 700).
p_given(covid19, dryCough, 650).
p_given(covid19, lossOfSmell, 400).
p_given(covid19, sneezing, 150).
p_given(covid19, shortBreath, 200).

p_given(influenza, fever, 800).
p_given(influenza, dryCough, 500).
p_given(influenza, lossOfSmell, 50).
p_given(influenza, sneezing, 200).
p_given(influenza, shortBreath, 100).

p_given(allergicRhinitis, fever, 50).
p_given(allergicRhinitis, dryCough, 150).
p_given(allergicRhinitis, lossOfSmell, 100).
p_given(allergicRhinitis, sneezing, 800).
p_given(allergicRhinitis, shortBreath, 50).

p_given(bacterialPneumonia, fever, 700).
p_given(bacterialPneumonia, dryCough, 600).
p_given(bacterialPneumonia, lossOfSmell, 20).
p_given(bacterialPneumonia, sneezing, 50).
p_given(bacterialPneumonia, shortBreath, 600).

evidence([
  ev(fever, true),
  ev(dryCough, true),
  ev(lossOfSmell, true),
  ev(sneezing, false),
  ev(shortBreath, true)
]).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
factor(?disease, ?symptom, true, ?p) :- p_given(?disease, ?symptom, ?p).
factor(?disease, ?symptom, false, ?q) :-
  p_given(?disease, ?symptom, ?p),
  sub(1000, ?p, ?q).

likelihood(?_disease, [], ?acc, ?acc).
likelihood(?disease, [ev(?symptom, ?present)|?rest], ?acc, ?value) :-
  factor(?disease, ?symptom, ?present, ?factor),
  mul(?acc, ?factor, ?next),
  likelihood(?disease, ?rest, ?next, ?value).

score(?disease, ?score) :-
  prior(?disease, ?prior),
  evidence(?evidence),
  likelihood(?disease, ?evidence, 1, ?likelihood),
  mul(?prior, ?likelihood, ?score).

total_score(?total) :-
  score(covid19, ?s1),
  score(influenza, ?s2),
  score(allergicRhinitis, ?s3),
  score(bacterialPneumonia, ?s4),
  add(?s1, ?s2, ?a),
  add(?s3, ?s4, ?b),
  add(?a, ?b, ?total).

% Decimal surface values from the Eyeling reference output.
score_decimal(covid19, 0.0015470000000000002).
score_decimal(influenza, 0.000048000000000000015).
score_decimal(allergicRhinitis, 7.499999999999999e-7).
score_decimal(bacterialPneumonia, 0.000047879999999999996).

total_score_decimal(0.0016436300000000003).

posterior(covid19, 0.9412093962753174).
posterior(influenza, 0.029203652890249024).
posterior(allergicRhinitis, 0.00045630707641014084).
posterior(bacterialPneumonia, 0.029130643758023392).

scores(case, [
  0.0015470000000000002,
  0.000048000000000000015,
  7.499999999999999e-7,
  0.000047879999999999996
]).
evidenceTotal(case, ?total) :- total_score_decimal(?total).
result(case, result(?disease)) :- disease(?disease).
disease(result(?disease), ?disease) :- disease(?disease).
unnormalized(result(?disease), ?score) :- score_decimal(?disease, ?score).
posterior(result(?disease), ?posterior) :- posterior(?disease, ?posterior).
