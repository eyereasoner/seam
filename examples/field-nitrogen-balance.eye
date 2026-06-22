% EYE-inspired field nitrogen balance case study.
%
% field(Field, SoilN, FertilizerN, LossFraction, CropDemandN) stores a compact
% nutrient budget.  Rules derive retained nitrogen, deficit, surplus, and a
% leaching-risk index before assigning each field a status.
materialize(availableN_kg_ha, 2).
materialize(deficitN_kg_ha, 2).
materialize(surplusN_kg_ha, 2).
materialize(leachingIndex, 2).
materialize(status, 2).
materialize(highestLeachingRisk, 2).
materialize(reason, 2).

% The four fields cover under-supplied, balanced, and over-supplied scenarios
% with different loss fractions so leaching risk is not just total surplus.
field(low_input, 25, 40, 0.10, 110).
field(balanced_loam, 45, 80, 0.12, 110).
field(sandy_high, 30, 150, 0.35, 105).
field(clay_surplus, 70, 90, 0.08, 120).

% total_n/2 and available_n/2 build the nutrient budget; surplus/deficit and
% leaching rules then explain the resulting field status.
total_n(?f, ?total) :-
  field(?f, ?soil, ?fert, ?_, ?_),
  add(?soil, ?fert, ?total).

available_n(?f, ?avail) :-
  total_n(?f, ?total),
  field(?f, ?_, ?_, ?loss, ?_),
  sub(1.0, ?loss, ?retained),
  mul(?total, ?retained, ?avail).

% surplus_n/2 and deficit_n/2 split the signed balance into reportable quantities.
surplus_n(?f, ?surplus) :-
  available_n(?f, ?avail),
  field(?f, ?_, ?_, ?_, ?demand),
  gt(?avail, ?demand),
  sub(?avail, ?demand, ?surplus).

surplus_n(?f, 0.0) :-
  available_n(?f, ?avail),
  field(?f, ?_, ?_, ?_, ?demand),
  le(?avail, ?demand).

deficit_n(?f, ?deficit) :-
  available_n(?f, ?avail),
  field(?f, ?_, ?_, ?_, ?demand),
  lt(?avail, ?demand),
  sub(?demand, ?avail, ?deficit).

deficit_n(?f, 0.0) :-
  available_n(?f, ?avail),
  field(?f, ?_, ?_, ?_, ?demand),
  ge(?avail, ?demand).

leaching_index(?f, ?index) :-
  surplus_n(?f, ?surplus),
  field(?f, ?_, ?_, ?loss, ?_),
  mul(?surplus, ?loss, ?index).

status(?f, under_supplied) :- deficit_n(?f, ?d), gt(?d, 10.0).
status(?f, balanced) :- deficit_n(?f, ?d), surplus_n(?f, ?s), le(?d, 10.0), le(?s, 10.0).
status(?f, over_supplied) :- surplus_n(?f, ?s), gt(?s, 10.0).

availableN_kg_ha(?f, ?a) :- available_n(?f, ?a).
deficitN_kg_ha(?f, ?d) :- deficit_n(?f, ?d).
surplusN_kg_ha(?f, ?s) :- surplus_n(?f, ?s).
leachingIndex(?f, ?i) :- leaching_index(?f, ?i).
highestLeachingRisk(field_nitrogen_balance, sandy_high) :-
  leaching_index(sandy_high, ?sandy),
  leaching_index(clay_surplus, ?clay),
  gt(?sandy, ?clay).
reason(field_nitrogen_balance, "available nitrogen is total input retained after losses compared with crop demand").
