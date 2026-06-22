% Annotation with quoted formula data.
%
% The program keeps the annotation as data and derives visible relations from it.
% Context members become default output only when explicit rules project them.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(name, 2).
materialize(log_nameOf, 2).
materialize(statedBy, 2).
materialize(recorded, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
annotation(t, (
  name(a, "Alice"),
  statedBy(t, bob),
  recorded(t, "2021-07-07")
)).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
name(?s, ?o) :-
  annotation(?_t, ?context),
  holds(?context, name(?s, ?o)).

log_nameOf(?t, name(?s, ?o)) :-
  annotation(?t, ?context),
  holds(?context, name(?s, ?o)).

statedBy(?s, ?o) :-
  annotation(?_t, ?context),
  holds(?context, statedBy(?s, ?o)).

recorded(?s, ?o) :-
  annotation(?_t, ?context),
  holds(?context, recorded(?s, ?o)).
