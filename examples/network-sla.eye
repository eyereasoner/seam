% Technology example: network path SLA check.
%
% The path latency is the sum of link delays plus jitter. The path is compliant
% when the resulting end-to-end latency stays below the SLA limit.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(endToEndLatency_ms, 2).
materialize(slaLimit_ms, 2).
materialize(status, 2).
materialize(reason, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
path(edge_path, [link_a, link_b, link_c]).
link_latency(link_a, 12.0).
link_latency(link_b, 18.0).
link_latency(link_c, 9.0).
jitter(edge_path, 8.0).
sla(edge_path, maximum_latency_ms, 50.0).

latency_sum([], 0.0).
% Derivation rules: each rule below contributes one logical step toward the displayed results.
latency_sum([?link|?links], ?total) :-
  link_latency(?link, ?linklatency),
  latency_sum(?links, ?rest),
  add(?linklatency, ?rest, ?total).

end_to_end_latency(?path, ?latency) :-
  path(?path, ?links),
  latency_sum(?links, ?linklatency),
  jitter(?path, ?jitter),
  add(?linklatency, ?jitter, ?latency).

sla_compliant(?path) :-
  end_to_end_latency(?path, ?latency),
  sla(?path, maximum_latency_ms, ?maximum),
  lt(?latency, ?maximum).

endToEndLatency_ms(?path, ?latency) :-
  end_to_end_latency(?path, ?latency).

slaLimit_ms(?path, ?maximum) :-
  sla(?path, maximum_latency_ms, ?maximum).

status(?path, sla_compliant) :-
  sla_compliant(?path).

reason(?path, "path latency including jitter is below the SLA limit") :-
  sla_compliant(?path).
