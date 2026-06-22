% Technology example: canary release decision.
%
% A canary deployment is rolled back when its measured error rate exceeds the
% allowed budget, even when latency is still acceptable.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(errorRate, 2).
materialize(p95Latency_ms, 2).
materialize(latencyCheck, 2).
materialize(status, 2).
materialize(reason, 2).

% canary/4 records request count, error count, and p95 latency; thresholds
% make the rollout policy explicit data rather than constants hidden in rules.
canary(canary42, 5000.0, 75.0, 180.0).
threshold(canary42, maximum_error_rate, 0.01).
threshold(canary42, maximum_p95_latency_ms, 200.0).

% The latency and error-budget checks are independent so the final rollback
% reason can point to the failing guard.
error_rate(?release, ?rate) :-
  canary(?release, ?requests, ?errors, ?_p95latency),
  div(?errors, ?requests, ?rate).

latency_ok(?release) :-
  canary(?release, ?_requests, ?_errors, ?p95latency),
  threshold(?release, maximum_p95_latency_ms, ?maximum),
  lt(?p95latency, ?maximum).

error_budget_exceeded(?release) :-
  error_rate(?release, ?rate),
  threshold(?release, maximum_error_rate, ?maximum),
  gt(?rate, ?maximum).

rollback_recommended(?release) :-
  error_budget_exceeded(?release).

errorRate(?release, ?rate) :-
  error_rate(?release, ?rate).

p95Latency_ms(?release, ?p95latency) :-
  canary(?release, ?_requests, ?_errors, ?p95latency).

latencyCheck(?release, ok) :-
  latency_ok(?release).

status(?release, rollback_recommended) :-
  rollback_recommended(?release).

reason(?release, "canary error rate exceeds the allowed budget") :-
  rollback_recommended(?release).
