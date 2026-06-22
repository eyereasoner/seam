% Observability example: parse unstructured service logs with named regex
% captures, then reason over the extracted context to correlate events that
% share a W3C trace id.
%
% The noisy health-check line is deliberately present to show that only logs
% matching the pattern become parsed events.
materialize(parsed_event, 5).
materialize(captured_field, 3).
materialize(trace_alert, 3).

log_pattern("^ts=(?<ts>\\S+) level=(?<level>\\w+) event=(?<event>\\w+) user=(?<user>\\w+) ip=(?<ip>\\S+) traceparent=00-(?<trace_id>[0-9a-f]{32})-(?<span_id>[0-9a-f]{16})-(?<flags>[0-9a-f]{2})$").

raw_log(l1, "ts=2026-06-18T10:00:00Z level=warn event=login_failed user=alice ip=203.0.113.9 traceparent=00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01").
raw_log(l2, "ts=2026-06-18T10:00:03Z level=error event=payment_denied user=alice ip=203.0.113.9 traceparent=00-4bf92f3577b34da6a3ce929d0e0e4736-aaf067aa0ba90000-01").
raw_log(l3, "ts=2026-06-18T10:01:12Z level=info event=login_success user=bob ip=198.51.100.4 traceparent=00-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-bbbbbbbbbbbbbbbb-01").
raw_log(noise, "healthcheck ok").

parsed(?log, ?context) :-
  raw_log(?log, ?text),
  log_pattern(?pattern),
  matches(?text, ?pattern, ?context).

% matches/3 returns a context term containing named captures.  holds/3 then
% projects either Name, Value pairs or field(Value) shorthand facts from that
% same context without writing one regex per field.
captured_field(?log, ?name, ?value) :-
  parsed(?log, ?context),
  holds(?context, ?name, [?value]).

parsed_event(?log, ?event, ?user, ?ip, ?traceid) :-
  parsed(?log, ?context),
  holds(?context, event(?event)),
  holds(?context, user(?user)),
  holds(?context, ip(?ip)),
  holds(?context, trace_id(?traceid)).

trace_alert(?user, ?traceid, ?ip) :-
  parsed_event(?loginlog, "login_failed", ?user, ?ip, ?traceid),
  parsed_event(?paymentlog, "payment_denied", ?user, ?ip, ?traceid),
  neq(?loginlog, ?paymentlog).
