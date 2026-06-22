% EYE-inspired epidemic policy choice.
% Candidate interventions combine vaccination and mask factors against a base
% reproduction-risk estimate.  The recommended policy is the only candidate
% that satisfies the outbreak threshold in this simplified model.

materialize(riskScore, 2).
materialize(cost, 2).
materialize(status, 2).
materialize(recommendedPolicy, 2).
materialize(reason, 2).

% Candidate interventions combine vaccination and mask factors.
policy(no_mandate).
policy(vaccination_campaign).
policy(indoor_masks).
policy(vaccination_and_masks).

base_risk(1.40).

vaccination_factor(no_mandate, 1.00).
vaccination_factor(vaccination_campaign, 0.55).
vaccination_factor(indoor_masks, 1.00).
vaccination_factor(vaccination_and_masks, 0.55).

mask_factor(no_mandate, 1.00).
mask_factor(vaccination_campaign, 1.00).
mask_factor(indoor_masks, 0.65).
mask_factor(vaccination_and_masks, 0.65).

policy_cost(no_mandate, 0).
policy_cost(vaccination_campaign, 3).
policy_cost(indoor_masks, 2).
policy_cost(vaccination_and_masks, 5).

% Risk multiplies the base reproduction estimate by policy-specific factors.
risk_score(?p, ?r) :-
  base_risk(?base),
  vaccination_factor(?p, ?vf),
  mask_factor(?p, ?mf),
  mul(?base, ?vf, ?a),
  mul(?a, ?mf, ?r).

acceptable(?p) :-
  risk_score(?p, ?r),
  le(?r, 0.75).

status(?p, insufficient_control) :-
  policy(?p),
  risk_score(?p, ?r),
  gt(?r, 0.75).

status(?p, acceptable_control) :-
  acceptable(?p).

% The recommendation is the only candidate below the outbreak threshold.
recommended(vaccination_and_masks) :-
  acceptable(vaccination_and_masks),
  status(no_mandate, insufficient_control),
  status(vaccination_campaign, insufficient_control),
  status(indoor_masks, insufficient_control).

riskScore(?p, ?r) :- risk_score(?p, ?r).
cost(?p, ?c) :- policy_cost(?p, ?c).
recommendedPolicy(epidemic_policy, ?p) :- recommended(?p).
reason(epidemic_policy, "combined vaccination and indoor masks are the only policy below the outbreak threshold") :-
  recommended(vaccination_and_masks).
