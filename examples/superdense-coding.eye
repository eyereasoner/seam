% Superdense coding using discrete quantum computing, adapted from
% Eyelet's input/superdense-coding.eye.
%
% The Eyelet program toggles dynamic sdcoding/2 facts so answers appearing an
% even number of times cancel. eyelang expresses the same finite example
% declaratively: for this protocol the surviving messages are exactly those
% with a single support path after the interference choices are expanded.

% |R) = |0, 0) + |1, 1)
% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(decodesAs, 2).
materialize(preservesMessage, 2).
materialize(cancelsCrossTalk, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
r(false, false).
r(true, true).

% ID |0) = |0), ID |1) = |1)
identity(false, false).
identity(true, true).

% G |0) = |1), G |1) = |0)
g(false, true).
g(true, false).

% K |0) = |0), K |1) = |0) + |1)
k(false, false).
k(true, false).
k(true, true).

% KG and GK compositions.
% Derivation rules: each rule below contributes one logical step toward the displayed results.
kg(?x, ?y) :-
  g(?x, ?z),
  k(?z, ?y).

gk(?x, ?y) :-
  k(?x, ?z),
  g(?z, ?y).

% Alice encodes two classical bits as one of four transformations.
alice(0, ?x, ?y) :- identity(?x, ?y).
alice(1, ?x, ?y) :- g(?x, ?y).
alice(2, ?x, ?y) :- k(?x, ?y).
alice(3, ?x, ?y) :- kg(?x, ?y).

% Bob decodes with the Bell-style measurement basis.
bob(?x, ?y, 0) :- gk(?x, ?y).
bob(?x, ?y, 1) :- k(?x, ?y).
bob(?x, ?y, 2) :- g(?x, ?y).
bob(?x, ?y, 3) :- identity(?x, ?y).

% One concrete support path through the entangled pair and the two transforms.
sdc_path(?n, ?m, path(?x, ?y, ?b)) :-
  r(?x, ?y),
  alice(?n, ?x, ?b),
  bob(?b, ?y, ?m).

% If another different support path gives the same answer, this answer cancels
% in pairs in the finite superdense-coding table.
duplicate_sdc_path(?n, ?m, ?proof) :-
  sdc_path(?n, ?m, ?proof),
  sdc_path(?n, ?m, ?other),
  neq(?proof, ?other).

sdcoding(?n, ?m) :-
  sdc_path(?n, ?m, ?proof),
  not(duplicate_sdc_path(?n, ?m, ?proof)).

decodesAs(message(?n), ?m) :-
  sdcoding(?n, ?m).

preservesMessage(protocol, true) :-
  sdcoding(0, 0),
  sdcoding(1, 1),
  sdcoding(2, 2),
  sdcoding(3, 3).

cancelsCrossTalk(protocol, true) :-
  not(sdcoding(0, 1)),
  not(sdcoding(1, 0)),
  not(sdcoding(2, 3)),
  not(sdcoding(3, 2)).
