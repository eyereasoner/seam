% Context schema audit.
%
% This example needs holds/3 rather than holds/2 because the audit rule does
% not know the predicate names or arities in advance.  It inspects a whole
% context as data, extracts each member as Name + Args, computes the arity, and
% checks that shape against an allowed schema.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(context_shape, 3).
materialize(schema_violation, 3).

% Program structure: each message carries heterogeneous context data.  The
% members deliberately use different arities: heartbeat/0, source/1,
% temperature/2, gps/3, and signature/4.
message_context(msg_ok, (
  heartbeat,
  source(sensor17),
  temperature(sensor17, 38),
  gps(sensor17, 51, 4),
  signature(sensor17, sha256, "9f86d081", "2026-06-18T09:30:00Z")
)).

message_context(msg_bad, (
  heartbeat,
  source(sensor18),
  temperature(sensor18, 99),
  gps(sensor18, 51),
  tampered(sensor18)
)).

allowed_shape(heartbeat, 0).
allowed_shape(source, 1).
allowed_shape(temperature, 2).
allowed_shape(gps, 3).
allowed_shape(signature, 4).

% Derivation rules: holds/3 exposes arbitrary context members as predicate name
% plus argument list, so one generic rule can audit mixed-arity data.
context_shape(?message, ?name, ?arity) :-
  message_context(?message, ?context),
  holds(?context, ?name, ?args),
  length(?args, ?arity).

schema_violation(?message, ?name, ?arity) :-
  context_shape(?message, ?name, ?arity),
  not(allowed_shape(?name, ?arity)).
