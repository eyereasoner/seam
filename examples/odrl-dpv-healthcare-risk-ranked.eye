% ODRL + DPV healthcare risk ranking adapted from Eyeling.
%
% The scenario models a healthcare data-use agreement, patient needs, processing
% clauses, risk scores, and mitigation suggestions.  Rules derive violations, raw
% and normalized scores, risk levels, and small formula-valued suggestion graphs.
%
% This is one of the richer policy examples: it combines structured policy data,
% ranked risk computation, and report-oriented materialization.
% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(policyGraph, 2).
materialize(contains, 2).
materialize(dpv_hasRisk, 2).
materialize(type, 2).
materialize(scoreRaw, 2).
materialize(score, 2).
materialize(dpv_hasRiskLevel, 2).
materialize(dpv_hasSeverity, 2).
materialize(aboutClause, 2).
materialize(violatesNeed, 2).
materialize(dct_source, 2).
materialize(dct_description, 2).
materialize(reportKey, 2).
materialize(dpv_isMitigatedByMeasure, 2).
materialize(suggestAddGraph, 2).
materialize(firstRisk, 2).
materialize(retentionRiskScore, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
party(hospital).
party(researchUnit).
party(pharmaPartner).
party(clinicalAIService).
data_asset(healthRecordData).
data_asset(genomicData).
process(processContextHC1).

title(agreementHC1, "Example Healthcare & Life-Sciences Data Use Agreement").
title(patientExample, "Example patient profile").

has_need(patientExample, need_ConsentForResearch).
has_need(patientExample, need_DeIdentifyBeforeSharing).
has_need(patientExample, need_HumanReviewForAutomatedTriage).
has_need(patientExample, need_RetentionLimit3y).

importance(need_ConsentForResearch, 35).
importance(need_DeIdentifyBeforeSharing, 35).
importance(need_HumanReviewForAutomatedTriage, 25).
importance(need_RetentionLimit3y, 15).
max_retention_days(need_RetentionLimit3y, 1095).

clause_id(clauseH1, "H1").
clause_text(clauseH1, "Hospital may use EHR and genomic data for internal clinical research and publication.").
clause_id(clauseH2, "H2").
clause_text(clauseH2, "Hospital may share genomic data with pharmaceutical partners for drug discovery and R&D.").
clause_id(clauseH3, "H3").
clause_text(clauseH3, "Hospital may use automated triage and prioritisation systems using EHR data.").
clause_id(clauseH4, "H4").
clause_text(clauseH4, "Hospital retains patient health records for 10 years.").

agreement_policy_graph(agreementHC1, policyGraphHC1).

policy_graph(policyGraphHC1, (
  type(policyHC1, odrl_Policy),
  odrl_permission(policyHC1, permResearchUse),
  odrl_permission(policyHC1, permShareWithPharma),
  odrl_permission(policyHC1, permAutomatedTriage),
  odrl_permission(policyHC1, permRetention10y),

  type(permResearchUse, odrl_Permission),
  odrl_assigner(permResearchUse, hospital),
  odrl_assignee(permResearchUse, researchUnit),
  odrl_action(permResearchUse, hl7ca_use),
  odrl_target(permResearchUse, healthRecordData),
  odrl_target(permResearchUse, genomicData),
  odrl_constraint(permResearchUse, cResearchPurpose),
  odrl_leftOperand(cResearchPurpose, odrl_purpose),
  odrl_rightOperandReference(cResearchPurpose, purposeHMB),
  clause(permResearchUse, clauseH1),

  type(permShareWithPharma, odrl_Permission),
  odrl_assigner(permShareWithPharma, hospital),
  odrl_assignee(permShareWithPharma, pharmaPartner),
  odrl_action(permShareWithPharma, hl7ca_disclose),
  odrl_target(permShareWithPharma, genomicData),
  odrl_constraint(permShareWithPharma, cSharePurpose),
  odrl_leftOperand(cSharePurpose, odrl_purpose),
  odrl_rightOperandReference(cSharePurpose, purposeHMB),
  clause(permShareWithPharma, clauseH2),

  type(permAutomatedTriage, odrl_Permission),
  odrl_assigner(permAutomatedTriage, hospital),
  odrl_assignee(permAutomatedTriage, clinicalAIService),
  odrl_action(permAutomatedTriage, hl7ca_use),
  odrl_target(permAutomatedTriage, healthRecordData),
  odrl_constraint(permAutomatedTriage, cTriagePurpose),
  odrl_leftOperand(cTriagePurpose, odrl_purpose),
  odrl_rightOperandReference(cTriagePurpose, purposeCC),
  odrl_duty(permAutomatedTriage, dutyHumanReview),
  odrl_action(dutyHumanReview, humanReview),
  odrl_constraint(dutyHumanReview, cTriageEncryption),
  odrl_leftOperand(cTriageEncryption, encryptionAtRest),
  odrl_rightOperand(cTriageEncryption, true),
  clause(permAutomatedTriage, clauseH3),

  type(permRetention10y, odrl_Permission),
  odrl_assigner(permRetention10y, hospital),
  odrl_assignee(permRetention10y, hospital),
  odrl_action(permRetention10y, hl7ca_collect),
  odrl_target(permRetention10y, healthRecordData),
  odrl_constraint(permRetention10y, cRetentionPurpose),
  odrl_leftOperand(cRetentionPurpose, odrl_purpose),
  odrl_rightOperandReference(cRetentionPurpose, purposeCC),
  odrl_constraint(permRetention10y, cRetentionDays),
  odrl_leftOperand(cRetentionDays, retentionDays),
  odrl_rightOperand(cRetentionDays, 3650),
  clause(permRetention10y, clauseH4)
)).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
policy_statement(?graphname, ?subject, ?predicate, ?object) :-
  policy_graph(?graphname, ?context),
  holds(?context, ?predicate, [?subject, ?object]).

permission(?graph, ?permission) :- policy_statement(?graph, policyHC1, odrl_permission, ?permission).
clause(?graph, ?permission, ?clause) :- policy_statement(?graph, ?permission, clause, ?clause).
action(?graph, ?permission, ?action) :- policy_statement(?graph, ?permission, odrl_action, ?action).
target(?graph, ?permission, ?target) :- policy_statement(?graph, ?permission, odrl_target, ?target).
duty(?graph, ?permission, ?duty) :- policy_statement(?graph, ?permission, odrl_duty, ?duty).
duty_action(?graph, ?duty, ?action) :- policy_statement(?graph, ?duty, odrl_action, ?action).
constraint(?graph, ?permission, ?constraint) :- policy_statement(?graph, ?permission, odrl_constraint, ?constraint).
constraint_left(?graph, ?constraint, ?left) :- policy_statement(?graph, ?constraint, odrl_leftOperand, ?left).
constraint_right(?graph, ?constraint, ?right) :- policy_statement(?graph, ?constraint, odrl_rightOperand, ?right).

has_constraint(?graph, ?permission, ?left, ?right) :-
  constraint(?graph, ?permission, ?constraint),
  constraint_left(?graph, ?constraint, ?left),
  constraint_right(?graph, ?constraint, ?right).

has_duty_action(?graph, ?permission, ?action) :-
  duty(?graph, ?permission, ?duty),
  duty_action(?graph, ?duty, ?action).

missing_explicit_consent(?graph, ?permission) :-
  permission(?graph, ?permission),
  not(has_constraint(?graph, ?permission, explicitConsent, true)).

missing_deidentified(?graph, ?permission) :-
  permission(?graph, ?permission),
  not(has_constraint(?graph, ?permission, deIdentified, true)).

missing_human_review(?graph, ?permission) :-
  permission(?graph, ?permission),
  not(has_duty_action(?graph, ?permission, humanReview)).

retention_days(?graph, ?permission, ?days) :-
  has_constraint(?graph, ?permission, retentionDays, ?days).

risk(riskH1) :-
  agreement_policy_graph(agreementHC1, ?graph),
  has_need(patientExample, need_ConsentForResearch),
  permission(?graph, permResearchUse),
  clause(?graph, permResearchUse, clauseH1),
  missing_explicit_consent(?graph, permResearchUse).

risk(riskH2) :-
  agreement_policy_graph(agreementHC1, ?graph),
  has_need(patientExample, need_DeIdentifyBeforeSharing),
  permission(?graph, permShareWithPharma),
  target(?graph, permShareWithPharma, genomicData),
  clause(?graph, permShareWithPharma, clauseH2),
  missing_deidentified(?graph, permShareWithPharma).

risk(riskH3) :-
  agreement_policy_graph(agreementHC1, ?graph),
  has_need(patientExample, need_HumanReviewForAutomatedTriage),
  permission(?graph, permAutomatedTriage),
  clause(?graph, permAutomatedTriage, clauseH3),
  missing_human_review(?graph, permAutomatedTriage).

risk(riskH4) :-
  agreement_policy_graph(agreementHC1, ?graph),
  has_need(patientExample, need_RetentionLimit3y),
  max_retention_days(need_RetentionLimit3y, ?max),
  permission(?graph, permRetention10y),
  clause(?graph, permRetention10y, clauseH4),
  retention_days(?graph, permRetention10y, ?days),
  gt(?days, ?max).

base_score(riskH1, 85).
base_score(riskH2, 90).
base_score(riskH3, 80).
base_score(riskH4, 55).
violates_need(riskH1, need_ConsentForResearch).
violates_need(riskH2, need_DeIdentifyBeforeSharing).
violates_need(riskH3, need_HumanReviewForAutomatedTriage).
violates_need(riskH4, need_RetentionLimit3y).
about_clause(riskH1, clauseH1).
about_clause(riskH2, clauseH2).
about_clause(riskH3, clauseH3).
about_clause(riskH4, clauseH4).
risk_source_of(riskH1, permResearchUse).
risk_source_of(riskH2, permShareWithPharma).
risk_source_of(riskH3, permAutomatedTriage).
risk_source_of(riskH4, permRetention10y).

description(riskH1, "Risk: health/genomic data may be used for research without explicit opt-in consent.").
description(riskH2, "Risk: genomic data may be shared with external pharma partners without a de-identification/pseudonymisation requirement.").
description(riskH3, "Risk: automated triage may affect care pathways without a human review/override safeguard.").
description(riskH4, "Risk: retention (3650 days) exceeds patient preference (1095 days).").

mitigation_graph(riskH1, mitigateConsent, (
  odrl_constraint(permResearchUse, cExplicitConsent),
  odrl_leftOperand(cExplicitConsent, explicitConsent),
  odrl_rightOperand(cExplicitConsent, true)
)).
mitigation_graph(riskH2, mitigateDeId, (
  odrl_constraint(permShareWithPharma, cDeIdentified),
  odrl_leftOperand(cDeIdentified, deIdentified),
  odrl_rightOperand(cDeIdentified, true),
  odrl_duty(permShareWithPharma, dutyDeIdentify),
  odrl_action(dutyDeIdentify, deIdentify)
)).
mitigation_graph(riskH3, mitigateHumanReview, (
  odrl_duty(permAutomatedTriage, dutyHumanReview),
  odrl_action(dutyHumanReview, humanReview)
)).
mitigation_graph(riskH4, mitigateRetention, (
  odrl_constraint(permRetention10y, cRetentionLimit),
  odrl_leftOperand(cRetentionLimit, retentionDays),
  odrl_rightOperand(cRetentionLimit, 1095)
)).

score_raw(?risk, ?raw) :-
  risk(?risk),
  base_score(?risk, ?base),
  violates_need(?risk, ?need),
  importance(?need, ?weight),
  add(?base, ?weight, ?raw).

score(?risk, 100) :- score_raw(?risk, ?raw), gt(?raw, 100).
score(?risk, ?raw) :- score_raw(?risk, ?raw), ge(100, ?raw).

severity(?risk, risk_HighSeverity) :- score(?risk, ?score), gt(?score, 79).
severity(?risk, risk_ModerateSeverity) :- score(?risk, ?score), lt(?score, 80), gt(?score, 49).
risk_level(?risk, risk_HighRisk) :- score(?risk, ?score), gt(?score, 79).
risk_level(?risk, risk_ModerateRisk) :- score(?risk, ?score), lt(?score, 80), gt(?score, 49).

report_key(?risk, ?key) :- score(?risk, ?score), sub(1000, ?score, ?key).

policyGraph(agreementHC1, ?graphterm) :-
  agreement_policy_graph(agreementHC1, ?graph),
  policy_graph(?graph, ?graphterm).

contains(policyGraphHC1, statement(?subject, ?predicate, ?object)) :-
  policy_statement(policyGraphHC1, ?subject, ?predicate, ?object).

dpv_hasRisk(processContextHC1, ?risk) :- risk(?risk).
type(?risk, dpv_Risk) :- risk(?risk).
scoreRaw(?risk, ?raw) :- score_raw(?risk, ?raw).
dpv_hasRiskLevel(?risk, ?level) :- risk_level(?risk, ?level).
dpv_hasSeverity(?risk, ?severity) :- severity(?risk, ?severity).
aboutClause(?risk, ?clause) :- risk(?risk), about_clause(?risk, ?clause).
violatesNeed(?risk, ?need) :- risk(?risk), violates_need(?risk, ?need).
dct_source(?risk, ?source) :- risk(?risk), risk_source_of(?risk, ?source).
dct_description(?risk, ?description) :- risk(?risk), description(?risk, ?description).
reportKey(?risk, ?key) :- report_key(?risk, ?key).
dpv_isMitigatedByMeasure(?risk, ?mitigation) :- risk(?risk), mitigation_graph(?risk, ?mitigation, ?_graph).
suggestAddGraph(?mitigation, ?graph) :- mitigation_graph(?risk, ?mitigation, ?graph), risk(?risk).
firstRisk(report, riskH1) :- score(riskH1, 100), score(riskH2, 100).
retentionRiskScore(report, ?score) :- score(riskH4, ?score).
