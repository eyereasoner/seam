% Delfour insight-economy case adapted from Eyeling delfour.n3.
% The original N3 emits a Markdown answer.  This eyelang
% translation derives the same authorization, shopping banner, alternative, and
% checklist facts as relation materialization.
%
% Static input is kept as scoped data: the case, insight, policy, envelope, and
% signature are context terms, while the product catalog is a list of records.
% Rules project only the fields they need, avoiding global permission/prohibition
% facts that could contradict another policy formula in the same program.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(caseName, 2).
materialize(needsLowSugar, 2).
materialize(derivedFromNeed, 2).
materialize(outcome, 2).
materialize(target, 2).
materialize(metric, 2).
materialize(threshold, 2).
materialize(scope, 2).
materialize(retailer, 2).
materialize(expiresAt, 2).
materialize(scannedProduct, 2).
materialize(suggestedAlternative, 2).
materialize(headline, 2).
materialize(note, 2).
materialize(reason, 2).
materialize(value, 2).
materialize(alg, 2).
materialize(auditEntries, 2).
materialize(filesWritten, 2).
materialize(allChecksPass, 2).
materialize(signatureVerifies, 2).
materialize(payloadHashMatches, 2).
materialize(minimizationStripsSensitiveTerms, 2).
materialize(scopeComplete, 2).
materialize(authorizationAllowed, 2).
materialize(bannerFlagsHighSugar, 2).
materialize(alternativeIsLowerSugar, 2).
materialize(dutyTimingConsistent, 2).
materialize(marketingProhibited, 2).
materialize(filesWrittenExpected, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
% Context-valued facts keep each input graph scoped and easy to project.
case_graph(delfourCaseGraph, (
  caseName(case, "delfour"),
  requestPurpose(case, "shopping_assist"),
  requestAction(case, odrl_use),
  phoneCreatedAt(case, "2025-10-05T20:33:48.907163+00:00"),
  phoneExpiresAt(case, "2025-10-05T22:33:48.907185+00:00"),
  scannerAuthAt(case, "2025-10-05T20:35:48.907163+00:00"),
  scannerDutyAt(case, "2025-10-05T20:37:48.907163+00:00"),
  filesWritten(case, 6),
  auditEntries(case, 1),
  condition(householdProfile, "Diabetes"),
  scannedProduct(scan, prod_BIS_001)
)).

% Catalog rows are product(IdTerm, DisplayId, Name, SugarTenths, SugarG).
product_catalog(delfourCatalog, [
  product(prod_BIS_001, "prod_BIS_001", "Classic Tea Biscuits", 120, 12.0),
  product(prod_BIS_101, "prod_BIS_101", "Low-Sugar Tea Biscuits", 30, 3.0),
  product(prod_CHOC_050, "prod_CHOC_050", "Milk Chocolate Bar", 150, 15.0),
  product(prod_CHOC_150, "prod_CHOC_150", "85% Dark Chocolate", 60, 6.0)
]).

insight_graph(delfourInsightGraph, (
  metric(insight, "sugar_g_per_serving"),
  thresholdTenths(insight, 100),
  thresholdDisplay(insight, "10.0"),
  thresholdG(insight, 10.0),
  suggestionPolicy(insight, "lower_metric_first_higher_price_ok"),
  scopeDevice(insight, "self-scanner"),
  scopeEvent(insight, "pick_up_scanner"),
  retailer(insight, "Delfour"),
  createdAt(insight, "2025-10-05T20:33:48.907163+00:00"),
  expiresAt(insight, "2025-10-05T22:33:48.907185+00:00"),
  serializedLowercase(insight, "createdat expiresat insight metric sugar_g_per_serving retailer delfour scopedevice self-scanner scopeevent pick_up_scanner")
)).

policy_graph(delfourPolicyGraph, (
  odrl_permission(policy, permission(odrl_use, insight, "shopping_assist")),
  odrl_prohibition(policy, prohibition(odrl_distribute, insight, "marketing")),
  odrl_duty(policy, duty(odrl_delete, "2025-10-05T22:33:48.907185+00:00"))
)).

envelope_graph(delfourEnvelopeGraph, (
  insight(envelope, delfourInsightGraph),
  policy(envelope, delfourPolicyGraph),
  hash(envelope, "34ad35638dfd7c67d031eeca8abb235ec24280740f863f3f31cd9d7b6517f098")
)).

signature_graph(delfourSignatureGraph, (
  alg(signature, "HMAC-SHA256"),
  keyid(signature, "demo-shared-secret"),
  created(signature, "2025-10-05T20:33:48.907163+00:00"),
  payloadHashSha256(signature, "34ad35638dfd7c67d031eeca8abb235ec24280740f863f3f31cd9d7b6517f098"),
  hmac(signature, "b21d0072d90112a9f820aced0286889f4b6ef92b145e6fdef1011f3bfa4608c2"),
  hmacVerificationMode(signature, trustedPrecomputedInput)
)).

reason_text(reasonText, "Household requires low-sugar guidance (diabetes in POD). A neutral Insight is scoped to device 'self-scanner', event 'pick_up_scanner', retailer 'Delfour', and expires soon; the policy confines use to shopping assistance.").

% Derivation rules: each rule below contributes one logical step toward the displayed results.
case_statement(?s, ?p, ?o) :- case_graph(delfourCaseGraph, ?context), holds(?context, ?p, [?s, ?o]).
insight_statement(?s, ?p, ?o) :- insight_graph(delfourInsightGraph, ?context), holds(?context, ?p, [?s, ?o]).
policy_statement(?s, ?p, ?o) :- policy_graph(delfourPolicyGraph, ?context), holds(?context, ?p, [?s, ?o]).
envelope_statement(?s, ?p, ?o) :- envelope_graph(delfourEnvelopeGraph, ?context), holds(?context, ?p, [?s, ?o]).
signature_statement(?s, ?p, ?o) :- signature_graph(delfourSignatureGraph, ?context), holds(?context, ?p, [?s, ?o]).

case_name(case, ?name) :- case_statement(case, caseName, ?name).
request_purpose(case, ?purpose) :- case_statement(case, requestPurpose, ?purpose).
request_action(case, ?action) :- case_statement(case, requestAction, ?action).
phone_created_at(case, ?time) :- case_statement(case, phoneCreatedAt, ?time).
phone_expires_at(case, ?time) :- case_statement(case, phoneExpiresAt, ?time).
scanner_auth_at(case, ?time) :- case_statement(case, scannerAuthAt, ?time).
scanner_duty_at(case, ?time) :- case_statement(case, scannerDutyAt, ?time).
files_written(case, ?count) :- case_statement(case, filesWritten, ?count).
audit_entries(case, ?count) :- case_statement(case, auditEntries, ?count).
condition(householdProfile, ?condition) :- case_statement(householdProfile, condition, ?condition).
scanned_product(scan, ?product) :- case_statement(scan, scannedProduct, ?product).

product(?product) :- product_catalog(delfourCatalog, ?products), member(product(?product, ?_id, ?_name, ?_sugartenths, ?_sugarg), ?products).
product_id(?product, ?id) :- product_catalog(delfourCatalog, ?products), member(product(?product, ?id, ?_name, ?_sugartenths, ?_sugarg), ?products).
product_name(?product, ?name) :- product_catalog(delfourCatalog, ?products), member(product(?product, ?_id, ?name, ?_sugartenths, ?_sugarg), ?products).
sugar_tenths(?product, ?sugar) :- product_catalog(delfourCatalog, ?products), member(product(?product, ?_id, ?_name, ?sugar, ?_sugarg), ?products).
sugar_per_serving(?product, ?sugar) :- product_catalog(delfourCatalog, ?products), member(product(?product, ?_id, ?_name, ?_sugartenths, ?sugar), ?products).

insight(insight).
metric(insight, ?metric) :- insight_statement(insight, metric, ?metric).
threshold_tenths(insight, ?threshold) :- insight_statement(insight, thresholdTenths, ?threshold).
threshold_display(insight, ?threshold) :- insight_statement(insight, thresholdDisplay, ?threshold).
threshold_g(insight, ?threshold) :- insight_statement(insight, thresholdG, ?threshold).
suggestion_policy(insight, ?policy) :- insight_statement(insight, suggestionPolicy, ?policy).
scope_device(insight, ?device) :- insight_statement(insight, scopeDevice, ?device).
scope_event(insight, ?event) :- insight_statement(insight, scopeEvent, ?event).
retailer(insight, ?retailer) :- insight_statement(insight, retailer, ?retailer).
created_at(insight, ?time) :- insight_statement(insight, createdAt, ?time).
expires_at(insight, ?time) :- insight_statement(insight, expiresAt, ?time).
serialized_lowercase(insight, ?text) :- insight_statement(insight, serializedLowercase, ?text).

policy(policy).
permission(policy, ?action, ?target, ?purpose) :- policy_statement(policy, odrl_permission, permission(?action, ?target, ?purpose)).
prohibition(policy, ?action, ?target, ?purpose) :- policy_statement(policy, odrl_prohibition, prohibition(?action, ?target, ?purpose)).
duty(policy, ?action, ?time) :- policy_statement(policy, odrl_duty, duty(?action, ?time)).

envelope_insight(envelope, ?insight) :- envelope_statement(envelope, insight, ?insight).
envelope_policy(envelope, ?policy) :- envelope_statement(envelope, policy, ?policy).
envelope_hash(envelope, ?hash) :- envelope_statement(envelope, hash, ?hash).
signature_alg(signature, ?alg) :- signature_statement(signature, alg, ?alg).
signature_keyid(signature, ?keyid) :- signature_statement(signature, keyid, ?keyid).
signature_created(signature, ?time) :- signature_statement(signature, created, ?time).
payload_hash_sha256(signature, ?hash) :- signature_statement(signature, payloadHashSha256, ?hash).
signature_hmac(signature, ?hmac) :- signature_statement(signature, hmac, ?hmac).
hmac_verification_mode(signature, ?mode) :- signature_statement(signature, hmacVerificationMode, ?mode).

% The household profile creates the low-sugar need used by the insight.
needs_low_sugar(case) :-
  condition(householdProfile, "Diabetes").

derived_from_need(insight, "low_sugar") :-
  needs_low_sugar(case).

payload_hash_matches(check) :-
  envelope_hash(envelope, ?digest),
  payload_hash_sha256(signature, ?digest).

signature_verifies(check) :-
  hmac_verification_mode(signature, trustedPrecomputedInput).

minimization_strips_sensitive_terms(check) :-
  serialized_lowercase(insight, ?text),
  not_matches(?text, "diabetes|medical").

scope_complete(check) :-
  scope_device(insight, ?_device),
  scope_event(insight, ?_event),
  expires_at(insight, ?_expiry).

authorization_allowed(check) :-
  permission(policy, odrl_use, insight, "shopping_assist"),
  request_purpose(case, "shopping_assist"),
  scanner_auth_at(case, ?authat),
  expires_at(insight, ?expiresat),
  le(?authat, ?expiresat).

decision(decision, "Allowed", insight) :-
  authorization_allowed(check).

banner_flags_high_sugar(check) :-
  decision(decision, "Allowed", insight),
  scanned_product(scan, ?product),
  sugar_per_serving(?product, ?sugar),
  threshold_g(insight, ?threshold),
  ge(?sugar, ?threshold).

banner_headline(banner, "Track sugar per serving while you scan") :-
  banner_flags_high_sugar(check).

banner_note(banner, "High sugar") :-
  banner_flags_high_sugar(check).

better_lower_sugar(?scannedsugar, ?candidatesugar) :-
  product(?other),
  sugar_tenths(?other, ?othersugar),
  gt(?scannedsugar, ?othersugar),
  lt(?othersugar, ?candidatesugar).

% Pick the lowest-sugar alternative according to the insight suggestion policy.
suggested_alternative(case, ?candidate) :-
  scanned_product(scan, ?scanned),
  sugar_tenths(?scanned, ?scannedsugar),
  product(?candidate),
  sugar_tenths(?candidate, ?candidatesugar),
  gt(?scannedsugar, ?candidatesugar),
  not(better_lower_sugar(?scannedsugar, ?candidatesugar)).

banner_suggested_alternative(banner, ?name) :-
  banner_note(banner, "High sugar"),
  suggested_alternative(case, ?alternative),
  product_name(?alternative, ?name).

alternative_is_lower_sugar(check) :-
  scanned_product(scan, ?scanned),
  sugar_tenths(?scanned, ?scannedsugar),
  suggested_alternative(case, ?alternative),
  sugar_tenths(?alternative, ?alternativesugar),
  gt(?scannedsugar, ?alternativesugar).

duty_timing_consistent(check) :-
  scanner_duty_at(case, ?dutyat),
  expires_at(insight, ?expiresat),
  le(?dutyat, ?expiresat).

marketing_prohibited(check) :-
  prohibition(policy, odrl_distribute, insight, "marketing").

files_written_expected(check) :-
  files_written(case, 6).

all_checks_pass(result) :-
  signature_verifies(check),
  payload_hash_matches(check),
  minimization_strips_sensitive_terms(check),
  scope_complete(check),
  authorization_allowed(check),
  banner_flags_high_sugar(check),
  alternative_is_lower_sugar(check),
  duty_timing_consistent(check),
  marketing_prohibited(check),
  files_written_expected(check).

caseName(case, ?name) :- case_name(case, ?name).
needsLowSugar(case, true) :- needs_low_sugar(case).
derivedFromNeed(insight, ?need) :- derived_from_need(insight, ?need).
outcome(decision, ?outcome) :- decision(decision, ?outcome, ?_target).
target(decision, ?target) :- decision(decision, ?_outcome, ?target).
scannedProduct(scan, ?productname) :- scanned_product(scan, ?product), product_name(?product, ?productname).
suggestedAlternative(case, ?name) :- suggested_alternative(case, ?alternative), product_name(?alternative, ?name).
threshold(insight, ?threshold) :- threshold_display(insight, ?threshold).
scope(insight, "self-scanner @ pick_up_scanner") :- scope_device(insight, "self-scanner"), scope_event(insight, "pick_up_scanner").
expiresAt(insight, ?time) :- expires_at(insight, ?time).
reason(why, "The phone desensitizes a diabetes-related household condition into a scoped low-sugar need, wraps it in an expiring Insight + Policy envelope, signs it, and the scanner consumes that envelope for shopping assistance.") :- authorization_allowed(check).
headline(banner, ?headline) :- banner_headline(banner, ?headline).
note(banner, ?note) :- banner_note(banner, ?note).
suggestedAlternative(banner, ?name) :- banner_suggested_alternative(banner, ?name).
value(reasonText, ?text) :- reason_text(reasonText, ?text).
alg(signature, ?alg) :- signature_alg(signature, ?alg).
auditEntries(case, ?count) :- audit_entries(case, ?count).
filesWritten(case, ?count) :- files_written(case, ?count).
allChecksPass(result, true) :- all_checks_pass(result).
signatureVerifies(check, true) :- signature_verifies(check).
payloadHashMatches(check, true) :- payload_hash_matches(check).
minimizationStripsSensitiveTerms(check, true) :- minimization_strips_sensitive_terms(check).
scopeComplete(check, true) :- scope_complete(check).
authorizationAllowed(check, true) :- authorization_allowed(check).
bannerFlagsHighSugar(check, true) :- banner_flags_high_sugar(check).
alternativeIsLowerSugar(check, true) :- alternative_is_lower_sugar(check).
dutyTimingConsistent(check, true) :- duty_timing_consistent(check).
marketingProhibited(check, true) :- marketing_prohibited(check).
filesWrittenExpected(check, true) :- files_written_expected(check).
