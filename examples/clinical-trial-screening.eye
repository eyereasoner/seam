% Representative example: clinical-trial screening.
%
% The program models a small diabetes trial screening workflow. Helper
% predicates keep the inclusion/exclusion logic separate from the concise
% public relation report.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
%
% Inclusion criteria are positive requirements; exclusion criteria veto a
% candidate even when the inclusion checks pass. The emitted reason/2 facts are
% the audit trail a coordinator would need for a screen-failure report.
materialize(type, 2).
materialize(status, 2).
materialize(reason, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
patient(p001).
patient(p002).
patient(p003).
patient(p004).

age(p001, 54).
age(p002, 67).
age(p003, 31).
age(p004, 45).

diagnosis(p001, type2_diabetes).
diagnosis(p002, type2_diabetes).
diagnosis(p003, type2_diabetes).
diagnosis(p004, type2_diabetes).

lab(p001, hba1c_pct, 8.4).
lab(p002, hba1c_pct, 7.9).
lab(p003, hba1c_pct, 9.1).
lab(p004, hba1c_pct, 6.4).

lab(p001, egfr_ml_min, 83.0).
lab(p002, egfr_ml_min, 38.0).
lab(p003, egfr_ml_min, 91.0).
lab(p004, egfr_ml_min, 72.0).

condition(p003, pregnant).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
inclusion_adult(?patient) :-
  patient(?patient),
  age(?patient, ?age),
  ge(?age, 18).

inclusion_diagnosis(?patient) :-
  diagnosis(?patient, type2_diabetes).

inclusion_hba1c(?patient) :-
  lab(?patient, hba1c_pct, ?hba1c),
  ge(?hba1c, 7.0),
  le(?hba1c, 10.5).

exclusion_renal(?patient) :-
  lab(?patient, egfr_ml_min, ?egfr),
  lt(?egfr, 45.0).

exclusion_pregnancy(?patient) :-
  condition(?patient, pregnant).

% A patient is eligible only when all inclusion checks pass and no exclusion is proven.
screen_eligible(?patient) :-
  inclusion_adult(?patient),
  inclusion_diagnosis(?patient),
  inclusion_hba1c(?patient),
  not(exclusion_renal(?patient)),
  not(exclusion_pregnancy(?patient)).

screen_fail(?patient) :- exclusion_renal(?patient).
screen_fail(?patient) :- exclusion_pregnancy(?patient).
screen_fail(?patient) :- patient(?patient), not(inclusion_hba1c(?patient)).

type(?patient, trial_candidate) :-
  screen_eligible(?patient).

status(?patient, eligible) :-
  screen_eligible(?patient).

reason(?patient, "meets inclusion criteria and no listed exclusion") :-
  screen_eligible(?patient).

status(?patient, screen_fail) :-
  screen_fail(?patient).

reason(?patient, "eGFR below renal safety threshold") :-
  exclusion_renal(?patient).

reason(?patient, "pregnancy exclusion applies") :-
  exclusion_pregnancy(?patient).

reason(?patient, "HbA1c is outside protocol range") :-
  patient(?patient),
  not(inclusion_hba1c(?patient)).
