% Alignment demo, adapted from Eyeling's examples/alignment-demo.n3.
%
% The output is the Prolog-style counterpart of the Eyeling golden output:
% broader/narrower alignments, their transitive closure, the reflexive
% narrower-or-equal relation, and the concepts that roll up to ref_car.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(broader, 2).
materialize(narrower, 2).
materialize(broaderTransitive, 2).
materialize(narrowerTransitive, 2).
materialize(narrowerOrEqualOf, 2).
materialize(rollsUpTo, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
concept(ref_car).
concept(tel_car).
concept(tel_heavy_vehicle).
concept(anpr_vehicle_with_plate).
concept(anpr_passenger_car).

assertedBroader(tel_car, ref_car).
assertedBroader(tel_heavy_vehicle, ref_car).
assertedBroader(anpr_vehicle_with_plate, ref_car).
assertedNarrower(anpr_vehicle_with_plate, anpr_passenger_car).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
broader(?x, ?y) :- assertedBroader(?x, ?y).
broader(?x, ?y) :- assertedNarrower(?y, ?x).

narrower(?x, ?y) :- broader(?y, ?x).

broaderTransitive(?x, ?y) :- broader(?x, ?y).
broaderTransitive(?x, ?z) :- broader(?x, ?y), broaderTransitive(?y, ?z).

narrowerTransitive(?x, ?y) :- narrower(?x, ?y).
narrowerTransitive(?x, ?z) :- narrower(?x, ?y), narrowerTransitive(?y, ?z).

narrowerOrEqualOf(?x, ?x) :- concept(?x).
narrowerOrEqualOf(?x, ?y) :- broaderTransitive(?x, ?y).

rollsUpTo(?x, ref_car) :-
  narrowerOrEqualOf(?x, ref_car),
  neq(?x, ref_car).
