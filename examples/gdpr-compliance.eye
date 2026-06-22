% GDPR-style compliance check.
% Each processing case is tested for purpose compatibility, legal basis,
% minimisation, special-category safeguards, and international-transfer safety.
% Separate failure rules produce concise reasons for noncompliant cases.

materialize(status, 2).
materialize(reason, 2).

% case_alpha is intended to pass; case_beta is intentionally incomplete.
processing(case_alpha).
processing(case_beta).

purpose(case_alpha, care_coordination).
purpose(case_beta, marketing).

legal_basis(case_alpha, explicit_consent).
% case_beta intentionally has no legal basis.

minimized(case_alpha).
not_minimized(case_beta).

special_category(case_alpha, health_data).
special_category(case_beta, health_data).

safeguard(case_alpha, encryption).
safeguard(case_alpha, access_logging).
safeguard(case_beta, encryption).

third_country_transfer(case_beta).
adequacy_decision(case_alpha).

% Compliance is decomposed into reusable checks so reasons can be reported.
has_required_basis(?case) :- legal_basis(?case, explicit_consent).
has_required_basis(?case) :- legal_basis(?case, medical_care).

has_health_safeguards(?case) :-
  special_category(?case, health_data),
  safeguard(?case, encryption),
  safeguard(?case, access_logging).

transfer_ok(?case) :- not(third_country_transfer(?case)).
transfer_ok(?case) :- adequacy_decision(?case).

compliant(?case) :-
  processing(?case),
  has_required_basis(?case),
  minimized(?case),
  has_health_safeguards(?case),
  transfer_ok(?case).

% Individual failure rules explain why a case is noncompliant.
noncompliance_reason(?case, missing_legal_basis) :-
  processing(?case),
  not(has_required_basis(?case)).

noncompliance_reason(?case, not_minimized) :-
  not_minimized(?case).

noncompliance_reason(?case, missing_access_logging) :-
  special_category(?case, health_data),
  not(safeguard(?case, access_logging)).

noncompliance_reason(?case, transfer_without_adequacy) :-
  third_country_transfer(?case),
  not(adequacy_decision(?case)).

status(?case, gdpr_compliant) :- compliant(?case).
status(?case, gdpr_noncompliant) :- noncompliance_reason(?case, ?_reason).
reason(?case, ?reason) :- noncompliance_reason(?case, ?reason).
