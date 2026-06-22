% ODRL + DPV + local FPV trust-flow decisioning in Eyelang.
%
% Each flow has a source, recipient, data item, action, and purpose.  Permissions
% and prohibitions are checked together with source trust scores to produce
% permit, review, or deny decisions.
%
% The example separates the policy vocabulary from the local FPV-style report
% predicates, which keeps the final decision/confidence/status/risk facts easy to
% consume.

materialize(decision, 2).
materialize(confidence, 2).
materialize(status, 2).
materialize(risk, 2).

trust_score(hospital_a, 0.92).
trust_score(small_clinic, 0.63).
trust_score(ad_network, 0.28).

flow(flow_care, hospital_a, research_partner, lab_result, dpv_use, dpv_healthcare).
flow(flow_clinic, small_clinic, research_partner, lab_result, dpv_use, dpv_healthcare).
flow(flow_ads, hospital_a, ad_network, lab_result, dpv_share, dpv_marketing).

permission(permit_healthcare_research, research_partner, lab_result, dpv_use, dpv_healthcare, 0.80).
prohibition(prohibit_marketing_disclosure, ad_network, lab_result, dpv_share, dpv_marketing).

permitted_flow(?flow, ?score) :-
  flow(?flow, ?source, ?recipient, ?data, ?action, ?purpose),
  permission(?_permission, ?recipient, ?data, ?action, ?purpose, ?mintrust),
  trust_score(?source, ?score),
  ge(?score, ?mintrust).

review_flow(?flow, ?score) :-
  flow(?flow, ?source, ?recipient, ?data, ?action, ?purpose),
  permission(?_permission, ?recipient, ?data, ?action, ?purpose, ?mintrust),
  trust_score(?source, ?score),
  lt(?score, ?mintrust).

denied_flow(?flow) :-
  flow(?flow, ?_source, ?recipient, ?data, ?action, ?purpose),
  prohibition(?_prohibition, ?recipient, ?data, ?action, ?purpose).

decision(?flow, fpv_permit) :- permitted_flow(?flow, ?_score).
decision(?flow, fpv_review) :- review_flow(?flow, ?_score).
decision(?flow, fpv_deny) :- denied_flow(?flow).
confidence(?flow, ?score) :- permitted_flow(?flow, ?score).
confidence(?flow, ?score) :- review_flow(?flow, ?score).
status(?flow, fpv_executable_flow) :- permitted_flow(?flow, ?_score).
status(?flow, fpv_blocked_flow) :- denied_flow(?flow).
risk(?flow, risk_trustworthiness_risk) :- review_flow(?flow, ?_score).
risk(?flow, risk_unwanted_disclosure_data) :- denied_flow(?flow).
