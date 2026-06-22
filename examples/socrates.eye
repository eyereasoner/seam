% Socrates is mortal, adapted from Eyelet's input/socrates.eye.
%
% Eyelet uses type('Socrates', 'Man') and a single rule deriving Mortal.
% eyelang keeps the same reasoning shape and emits relation facts.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(type, 2).
materialize(is, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
type(socrates, man).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
type(?x, mortal) :-
  type(?x, man).


is(test, true) :-
  type(socrates, mortal).
