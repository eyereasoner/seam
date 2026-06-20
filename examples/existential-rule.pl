% Existential introduction with explicit witnesses.
% Eyeling's original N3 rule creates existential blank nodes; in Eyelang the
% same idea is represented by deterministic Skolem-style witness terms so the
% generated individual is visible in ordinary output.
%
% The materialized is/2 facts show the person-to-witness relation.
materialize(is, 2).

% Source data says which people are humans and which witness term belongs to
% each human.  The single rule below is the existential-style introduction step.

type(socrates, human).
type(plato, human).

witness(socrates, sk_0).
witness(plato, sk_1).

% In proof output this rule is the step that explains why each witness exists.
is(Person, Witness) :-
  type(Person, human),
  witness(Person, Witness).
