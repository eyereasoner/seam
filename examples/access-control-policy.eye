% Access control policy example adapted from Eyelet input/access-control-policy.eye.
%
% This version avoids findall/3 by expressing allOf/anyOf/noneOf checks as
% finite logical conditions.  The universal allOf/noneOf checks use negation
% as failure over bound policy facts.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(policy, 2).
materialize(status, 2).
materialize(reason, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
policy_request(test1, policy_x).
has(test1, claim_a).
has(test1, claim_b).
has(test1, claim_c).

policy(policy_x).
allOf(policy_x, claim_a).
allOf(policy_x, claim_b).
anyOf(policy_x, claim_c).
noneOf(policy_x, claim_d).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
passes_all_of(?request, ?policy) :-
  policy_request(?request, ?policy),
  policy(?policy),
  not((allOf(?policy, ?claim), not(has(?request, ?claim)))).

passes_any_of(?request, ?policy) :-
  policy_request(?request, ?policy),
  policy(?policy),
  anyOf(?policy, ?claim),
  has(?request, ?claim).

passes_none_of(?request, ?policy) :-
  policy_request(?request, ?policy),
  policy(?policy),
  not((noneOf(?policy, ?claim), has(?request, ?claim))).

passes_policy(?request, ?policy) :-
  passes_all_of(?request, ?policy),
  passes_any_of(?request, ?policy),
  passes_none_of(?request, ?policy).

policy(test1, policy_x).

status(test1, policy_passed) :-
  passes_policy(test1, policy_x).

reason(test1, "all required claims are present, one allowed claim is present, and no forbidden claim is present") :-
  passes_policy(test1, policy_x).
