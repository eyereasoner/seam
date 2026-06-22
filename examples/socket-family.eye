% socket-family.eye
%
% A small runnable eyelang Socket example.
%
% The socket facts below are ordinary eyelang data. They document the
% semantic opening: this reasoning module expects a provider for parent/2.
% The plug fact says which provider is connected.
%
% Run:
%   eyelang socket-family.eye

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(ancestor, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
socket(family_source, provides(parent_2)).
plug(family_file, family_source).

parent(pat, jan).
parent(jan, emma).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
ancestor(?x, ?y) :-
    parent(?x, ?y).

ancestor(?x, ?z) :-
    parent(?x, ?y),
    ancestor(?y, ?z).
