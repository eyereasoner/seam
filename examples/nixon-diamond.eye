% Nixon diamond: two independent defaults support incompatible conclusions.
% This mirrors the classic EYE reasoning theme while keeping the conclusion explicit:
% a subject with both defaults is reported as conflicted rather than forced to
% choose one extension.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(defaultSupports, 2).
materialize(conflict, 2).
materialize(status, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
kind(nixon, quaker).
kind(nixon, republican).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
supports_default(?person, pacifist) :-
  kind(?person, quaker).

supports_default(?person, hawk) :-
  kind(?person, republican).

contrary(pacifist, hawk).
contrary(hawk, pacifist).

conflicted(?person, ?a, ?b) :-
  supports_default(?person, ?a),
  supports_default(?person, ?b),
  contrary(?a, ?b).

defaultSupports(?person, ?conclusion) :-
  supports_default(?person, ?conclusion).

conflict(?person, conflict(?a, ?b)) :-
  conflicted(?person, ?a, ?b).

status(?person, conflicted_default_case) :-
  conflicted(?person, ?_a, ?_b).
