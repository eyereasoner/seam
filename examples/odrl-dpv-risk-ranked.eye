% ODRL + DPV ranked-risk assessment adapted from Eyeling odrl-dpv-risk-ranked.n3.
% Eyeling keeps the ODRL rules inside an N3 quoted policy formula and prints a
% Markdown report.  This eyelang translation also keeps the
% policy as a formula-valued term, projects local predicates from that formula for
% reasoning, and materializes the derived DPV risks as relation output.

% Consumer profile and needs.
% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(dct_title, 2).
materialize(dpv_hasRisk, 2).
materialize(type, 2).
materialize(policyGraph, 2).
materialize(contains, 2).
materialize(source, 2).
materialize(profile, 2).
materialize(firstRisk, 2).
materialize(before, 2).
materialize(dct_source, 2).
materialize(risk_hasRiskSource, 2).
materialize(dpv_hasConsequence, 2).
materialize(dpv_hasImpact, 2).
materialize(aboutClause, 2).
materialize(violatesNeed, 2).
materialize(scoreRaw, 2).
materialize(score, 2).
materialize(dpv_hasSeverity, 2).
materialize(dpv_hasRiskLevel, 2).
materialize(dct_description, 2).
materialize(reportKey, 2).
materialize(dpv_isMitigatedByMeasure, 2).
materialize(dpv_mitigatesRisk, 2).
materialize(clauseId, 2).
materialize(text, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
consumer(consumerExample).
title(consumerExample, "Example consumer profile").
has_need(consumerExample, need_DataCannotBeRemoved).
has_need(consumerExample, need_ChangeOnlyWithPriorNotice).
has_need(consumerExample, need_NoSharingWithoutConsent).
has_need(consumerExample, need_DataPortability).

importance(need_DataCannotBeRemoved, 20).
description(need_DataCannotBeRemoved, "Provider must not remove the consumer account/data.").
importance(need_ChangeOnlyWithPriorNotice, 15).
min_notice_days(need_ChangeOnlyWithPriorNotice, 14).
description(need_ChangeOnlyWithPriorNotice, "Agreement may change only with prior notice (>= 14 days).").
importance(need_NoSharingWithoutConsent, 12).
description(need_NoSharingWithoutConsent, "No data sharing without explicit consent.").
importance(need_DataPortability, 10).
description(need_DataPortability, "Consumer must be able to export their data.").

% Agreement and ODRL-style policy structure.
agreement(agreement1).
title(agreement1, "Example Agreement").
process_context(processContext1, agreement1).
title(processContext1, "Service operation under Agreement1").

% The ODRL policy is kept as a graph value.  The clauses below are not asserted
% globally as permission/2, prohibition/2, action/2, ... facts; they are
% binary terms inside policyGraph1.  The local projection predicates below read from the
% formula when evaluating this agreement.  This mirrors N3 quoted formulae and avoids
% making policy statements true outside the formula that contains them.
policy_graph(policyGraph1, (
  type(policy1, odrl_Policy),
  odrl_appliesTo(policy1, agreement1),
  odrl_permission(policy1, permDeleteAccount),
  odrl_permission(policy1, permChangeTerms),
  odrl_permission(policy1, permShareData),
  odrl_prohibition(policy1, prohibitExportData),

  odrl_assigner(permDeleteAccount, provider),
  odrl_assignee(permDeleteAccount, consumerExample),
  odrl_action(permDeleteAccount, tosl_removeAccount),
  odrl_target(permDeleteAccount, userAccount),
  clause(permDeleteAccount, clauseC1),

  odrl_assigner(permChangeTerms, provider),
  odrl_assignee(permChangeTerms, consumerExample),
  odrl_action(permChangeTerms, tosl_changeTerms),
  odrl_target(permChangeTerms, agreementText),
  clause(permChangeTerms, clauseC2),
  odrl_duty(permChangeTerms, odrl_inform),
  noticeDays(permChangeTerms, 3),

  odrl_assigner(permShareData, provider),
  odrl_assignee(permShareData, consumerExample),
  odrl_action(permShareData, tosl_shareData),
  odrl_target(permShareData, userData),
  clause(permShareData, clauseC3),

  odrl_assigner(prohibitExportData, provider),
  odrl_assignee(prohibitExportData, consumerExample),
  odrl_action(prohibitExportData, tosl_exportData),
  odrl_target(prohibitExportData, userData),
  clause(prohibitExportData, clauseC4)
)).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
policy_statement(?subject, ?predicate, ?object) :-
  policy_graph(?_graph, ?context),
  holds(?context, ?predicate, [?subject, ?object]).

policy(?policy, ?agreement) :- policy_statement(?policy, odrl_appliesTo, ?agreement).
permission(?policy, ?rule) :- policy_statement(?policy, odrl_permission, ?rule).
prohibition(?policy, ?rule) :- policy_statement(?policy, odrl_prohibition, ?rule).
assigner(?rule, ?party) :- policy_statement(?rule, odrl_assigner, ?party).
assignee(?rule, ?party) :- policy_statement(?rule, odrl_assignee, ?party).
action(?rule, ?action) :- policy_statement(?rule, odrl_action, ?action).
target(?rule, ?target) :- policy_statement(?rule, odrl_target, ?target).
clause(?rule, ?clause) :- policy_statement(?rule, clause, ?clause).
duty(?rule, ?duty) :- policy_statement(?rule, odrl_duty, ?duty).
notice_days(?rule, ?days) :- policy_statement(?rule, noticeDays, ?days).
consent_constraint(?rule, ?value) :- policy_statement(?rule, consentConstraint, ?value).

clause_id(clauseC1, "C1").
clause_text(clauseC1, "Provider may remove the user account (and associated data) at its discretion.").
clause_id(clauseC2, "C2").
clause_text(clauseC2, "Provider may change terms by informing users at least 3 days in advance.").
clause_id(clauseC3, "C3").
clause_text(clauseC3, "Provider may share user data with partners for business purposes.").
clause_id(clauseC4, "C4").
clause_text(clauseC4, "Users are not permitted to export their data.").

% Missing-safeguard checks corresponding to the log_notIncludes tests in N3.
missing_notice_constraint(?perm) :-
  permission(policy1, ?perm),
  not(notice_days(?perm, ?_days)).

missing_inform_duty(?perm) :-
  permission(policy1, ?perm),
  not(duty(?perm, odrl_inform)).

missing_consent_constraint(?perm) :-
  permission(policy1, ?perm),
  action(?perm, tosl_shareData),
  not(consent_constraint(?perm, true)).

% ODRL -> DPV risk derivation.
risk(risk1) :-
  has_need(consumerExample, need_DataCannotBeRemoved),
  permission(policy1, permDeleteAccount),
  action(permDeleteAccount, tosl_removeAccount),
  missing_notice_constraint(permDeleteAccount),
  missing_inform_duty(permDeleteAccount).

risk_source(risk1, src1).
risk_class(risk1, risk_UnwantedDataDeletion).
risk_class(risk1, risk_DataUnavailable).
risk_class(risk1, risk_DataErasureError).
risk_class(risk1, risk_DataLoss).
risk_source_class(src1, risk_LegalComplianceRisk).
risk_source_of(src1, permDeleteAccount).
risk_consequence(risk1, risk_DataLoss).
risk_consequence(risk1, risk_DataUnavailable).
risk_consequence(risk1, risk_CustomerConfidenceLoss).
risk_impact(risk1, risk_FinancialLoss).
risk_impact(risk1, risk_NonMaterialDamage).
about_clause(risk1, clauseC1).
violates_need(risk1, need_DataCannotBeRemoved).
risk_description(risk1, "Risk: account/data removal is permitted without notice safeguards (no notice constraint and no duty to inform). Clause C1: Provider may remove the user account (and associated data) at its discretion.").
base_score(risk1, 90).
mitigation(risk1, m11, "Add a notice constraint (minimum noticeDays) before account removal.").
mitigation(risk1, m21, "Add a duty to inform the consumer prior to account removal.").

risk(risk2) :-
  has_need(consumerExample, need_ChangeOnlyWithPriorNotice),
  min_notice_days(need_ChangeOnlyWithPriorNotice, ?required),
  permission(policy1, permChangeTerms),
  action(permChangeTerms, tosl_changeTerms),
  duty(permChangeTerms, odrl_inform),
  notice_days(permChangeTerms, ?days),
  lt(?days, ?required).

risk_source(risk2, src2).
risk_class(risk2, risk_PolicyRisk).
risk_class(risk2, risk_CustomerConfidenceLoss).
risk_source_class(src2, risk_PolicyRisk).
risk_source_of(src2, permChangeTerms).
risk_consequence(risk2, risk_CustomerConfidenceLoss).
risk_impact(risk2, risk_NonMaterialDamage).
about_clause(risk2, clauseC2).
violates_need(risk2, need_ChangeOnlyWithPriorNotice).
risk_description(risk2, "Risk: terms may change with notice (3 days) below consumer requirement (14 days). Clause C2: Provider may change terms by informing users at least 3 days in advance.").
base_score(risk2, 70).
mitigation(risk2, m12, "Increase minimum noticeDays in the inform duty to meet the consumer requirement.").

risk(risk3) :-
  has_need(consumerExample, need_NoSharingWithoutConsent),
  permission(policy1, permShareData),
  action(permShareData, tosl_shareData),
  missing_consent_constraint(permShareData).

risk_source(risk3, src3).
risk_class(risk3, risk_UnwantedDisclosureData).
risk_class(risk3, risk_CustomerConfidenceLoss).
risk_source_class(src3, risk_PolicyRisk).
risk_source_of(src3, permShareData).
risk_consequence(risk3, risk_CustomerConfidenceLoss).
risk_impact(risk3, risk_NonMaterialDamage).
risk_impact(risk3, risk_FinancialLoss).
about_clause(risk3, clauseC3).
violates_need(risk3, need_NoSharingWithoutConsent).
risk_description(risk3, "Risk: user data sharing is permitted without an explicit consent constraint. Clause C3: Provider may share user data with partners for business purposes.").
base_score(risk3, 85).
mitigation(risk3, m13, "Add an explicit consent constraint before data sharing.").

risk(risk4) :-
  has_need(consumerExample, need_DataPortability),
  prohibition(policy1, prohibitExportData),
  action(prohibitExportData, tosl_exportData).

risk_source(risk4, src4).
risk_class(risk4, risk_PolicyRisk).
risk_class(risk4, risk_CustomerConfidenceLoss).
risk_source_class(src4, risk_PolicyRisk).
risk_source_of(src4, prohibitExportData).
risk_consequence(risk4, risk_CustomerConfidenceLoss).
risk_impact(risk4, risk_NonMaterialDamage).
about_clause(risk4, clauseC4).
violates_need(risk4, need_DataPortability).
risk_description(risk4, "Risk: portability is restricted because exporting user data is prohibited. Clause C4: Users are not permitted to export their data.").
base_score(risk4, 60).
mitigation(risk4, m14, "Add a permission allowing data export (or remove the prohibition) to support portability.").

score_raw(?risk, ?raw) :-
  risk(?risk),
  base_score(?risk, ?base),
  violates_need(?risk, ?need),
  importance(?need, ?weight),
  add(?base, ?weight, ?raw).

score(?risk, 100) :-
  score_raw(?risk, ?raw),
  gt(?raw, 100).

score(?risk, ?raw) :-
  score_raw(?risk, ?raw),
  ge(100, ?raw).

severity(?risk, risk_HighSeverity) :-
  score(?risk, ?score),
  gt(?score, 79).

risk_level(?risk, risk_HighRisk) :-
  score(?risk, ?score),
  gt(?score, 79).

severity(?risk, risk_ModerateSeverity) :-
  score(?risk, ?score),
  lt(?score, 80),
  gt(?score, 49).

risk_level(?risk, risk_ModerateRisk) :-
  score(?risk, ?score),
  lt(?score, 80),
  gt(?score, 49).

severity(?risk, risk_LowSeverity) :-
  score(?risk, ?score),
  lt(?score, 50).

risk_level(?risk, risk_LowRisk) :-
  score(?risk, ?score),
  lt(?score, 50).

report_key(?risk, key(?invscore, ?clauseid)) :-
  risk(?risk),
  score(?risk, ?score),
  sub(1000, ?score, ?invscore),
  about_clause(?risk, ?clause),
  clause_id(?clause, ?clauseid).

ranked_before(?left, ?right) :-
  report_key(?left, key(?leftinv, ?_leftclause)),
  report_key(?right, key(?rightinv, ?_rightclause)),
  lt(?leftinv, ?rightinv).

ranked_before(?left, ?right) :-
  report_key(?left, key(?inv, ?leftclause)),
  report_key(?right, key(?inv, ?rightclause)),
  not_matches(?leftclause, ?rightclause),
  lt(?leftclause, ?rightclause).

% Output layer.
dct_title(agreement1, ?title) :- title(agreement1, ?title).
dct_title(consumerExample, ?title) :- title(consumerExample, ?title).
dct_title(processContext1, ?title) :- title(processContext1, ?title).
dpv_hasRisk(processContext1, ?risk) :- risk(?risk).
type(policyGraph1, policyGraph).
policyGraph(agreement1, policyGraph1).
contains(policyGraph1, statement(?subject, ?predicate, ?object)) :-
  policy_statement(?subject, ?predicate, ?object).
source(report, agreement1).
profile(report, consumerExample).
firstRisk(report, ?risk) :- risk(?risk), not(ranked_before(?_other, ?risk)).
before(riskRanking, pair(?left, ?right)) :- ranked_before(?left, ?right).

type(?risk, dpv_Risk) :- risk(?risk).
type(?risk, ?class) :- risk(?risk), risk_class(?risk, ?class).
dct_source(?risk, ?source) :- risk(?risk), risk_source(?risk, ?src), risk_source_of(?src, ?source).
risk_hasRiskSource(?risk, ?src) :- risk(?risk), risk_source(?risk, ?src).
type(?src, risk_RiskSource) :- risk_source(?_risk, ?src).
type(?src, ?class) :- risk_source_class(?src, ?class).
dct_source(?src, ?source) :- risk_source_of(?src, ?source).
dpv_hasConsequence(?risk, ?consequence) :- risk(?risk), risk_consequence(?risk, ?consequence).
dpv_hasImpact(?risk, ?impact) :- risk(?risk), risk_impact(?risk, ?impact).
aboutClause(?risk, ?clause) :- risk(?risk), about_clause(?risk, ?clause).
violatesNeed(?risk, ?need) :- risk(?risk), violates_need(?risk, ?need).
scoreRaw(?risk, ?raw) :- score_raw(?risk, ?raw).
dpv_hasSeverity(?risk, ?severity) :- severity(?risk, ?severity).
dpv_hasRiskLevel(?risk, ?level) :- risk_level(?risk, ?level).
dct_description(?risk, ?text) :- risk(?risk), risk_description(?risk, ?text).
reportKey(?risk, ?key) :- report_key(?risk, ?key).
dpv_isMitigatedByMeasure(?risk, ?measure) :- mitigation(?risk, ?measure, ?_text).
type(?measure, dpv_RiskMitigationMeasure) :- mitigation(?_risk, ?measure, ?_text).
dpv_mitigatesRisk(?measure, ?risk) :- mitigation(?risk, ?measure, ?_text).
dct_description(?measure, ?text) :- mitigation(?_risk, ?measure, ?text).
clauseId(?clause, ?id) :- clause_id(?clause, ?id).
text(?clause, ?text) :- clause_text(?clause, ?text).
