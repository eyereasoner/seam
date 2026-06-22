% Leg Length Discrepancy Measurement, adapted from Eyeling lldm.n3.
%
% The measurement and intermediate geometry are kept in helper predicates so
% the default relation materialization stays concise.  The visible output is
% the alarm plus the small set of relations explaining why the alarm fired.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(type, 2).
materialize(lld_left_length_cm, 2).
materialize(lld_right_length_cm, 2).
materialize(lld_discrepancy_cm, 2).
materialize(lld_threshold_cm, 2).
materialize(lld_reason, 2).

% val/3 stores raw landmark coordinates, derived deltas, line coefficients,
% projected landmarks, lengths, and alarm values in one measurement namespace.
measurement(meas47).

% measured landmark coordinates, in centimetres
val(meas47, p1xCm, 10.1).
val(meas47, p1yCm, 7.8).
val(meas47, p2xCm, 45.1).
val(meas47, p2yCm, 5.6).
val(meas47, p3xCm, 3.6).
val(meas47, p3yCm, 29.8).
val(meas47, p4xCm, 54.7).
val(meas47, p4yCm, 28.5).

% threshold used by the alarm rule, in centimetres
threshold(meas47, lld_alarm_threshold_cm, 1.25).

% geometric intermediate values
% The geometry rules build from coordinate differences to projected knee points,
% then compute left/right leg lengths and compare the discrepancy with a threshold.
val(?m, dx12Cm, ?z) :- measurement(?m), val(?m, p1xCm, ?x), val(?m, p2xCm, ?y), sub(?x, ?y, ?z).
val(?m, dx51Cm, ?z) :- measurement(?m), val(?m, p5xCm, ?x), val(?m, p1xCm, ?y), sub(?x, ?y, ?z).
val(?m, dx53Cm, ?z) :- measurement(?m), val(?m, p5xCm, ?x), val(?m, p3xCm, ?y), sub(?x, ?y, ?z).
val(?m, dx62Cm, ?z) :- measurement(?m), val(?m, p6xCm, ?x), val(?m, p2xCm, ?y), sub(?x, ?y, ?z).
val(?m, dx64Cm, ?z) :- measurement(?m), val(?m, p6xCm, ?x), val(?m, p4xCm, ?y), sub(?x, ?y, ?z).
val(?m, dy12Cm, ?z) :- measurement(?m), val(?m, p1yCm, ?x), val(?m, p2yCm, ?y), sub(?x, ?y, ?z).
val(?m, dy13Cm, ?z) :- measurement(?m), val(?m, p1yCm, ?x), val(?m, p3yCm, ?y), sub(?x, ?y, ?z).
val(?m, dy24Cm, ?z) :- measurement(?m), val(?m, p2yCm, ?x), val(?m, p4yCm, ?y), sub(?x, ?y, ?z).
val(?m, dy53Cm, ?z) :- measurement(?m), val(?m, p5yCm, ?x), val(?m, p3yCm, ?y), sub(?x, ?y, ?z).
val(?m, dy64Cm, ?z) :- measurement(?m), val(?m, p6yCm, ?x), val(?m, p4yCm, ?y), sub(?x, ?y, ?z).
val(?m, cL1, ?z) :- measurement(?m), val(?m, dy12Cm, ?y), val(?m, dx12Cm, ?x), div(?y, ?x, ?z).
val(?m, dL3m, ?z) :- measurement(?m), val(?m, cL1, ?x), div(1, ?x, ?z).
val(?m, cL3, ?z) :- measurement(?m), val(?m, dL3m, ?x), sub(0, ?x, ?z).
val(?m, pL1x1Cm, ?z) :- measurement(?m), val(?m, cL1, ?x), val(?m, p1xCm, ?y), mul(?x, ?y, ?z).
val(?m, pL1x2Cm, ?z) :- measurement(?m), val(?m, cL1, ?x), val(?m, p2xCm, ?y), mul(?x, ?y, ?z).
val(?m, pL3x3Cm, ?z) :- measurement(?m), val(?m, cL3, ?x), val(?m, p3xCm, ?y), mul(?x, ?y, ?z).
val(?m, pL3x4Cm, ?z) :- measurement(?m), val(?m, cL3, ?x), val(?m, p4xCm, ?y), mul(?x, ?y, ?z).
val(?m, dd13Cm, ?z) :- measurement(?m), val(?m, pL1x1Cm, ?x), val(?m, pL3x3Cm, ?y), sub(?x, ?y, ?z).
val(?m, ddy13Cm, ?z) :- measurement(?m), val(?m, dd13Cm, ?x), val(?m, dy13Cm, ?y), sub(?x, ?y, ?z).
val(?m, dd24Cm, ?z) :- measurement(?m), val(?m, pL1x2Cm, ?x), val(?m, pL3x4Cm, ?y), sub(?x, ?y, ?z).
val(?m, ddy24Cm, ?z) :- measurement(?m), val(?m, dd24Cm, ?x), val(?m, dy24Cm, ?y), sub(?x, ?y, ?z).
val(?m, ddL13, ?z) :- measurement(?m), val(?m, cL1, ?x), val(?m, cL3, ?y), sub(?x, ?y, ?z).
val(?m, pL1dx51Cm, ?z) :- measurement(?m), val(?m, cL1, ?x), val(?m, dx51Cm, ?y), mul(?x, ?y, ?z).
val(?m, pL1dx62Cm, ?z) :- measurement(?m), val(?m, cL1, ?x), val(?m, dx62Cm, ?y), mul(?x, ?y, ?z).
val(?m, p5xCm, ?z) :- measurement(?m), val(?m, ddy13Cm, ?x), val(?m, ddL13, ?y), div(?x, ?y, ?z).
val(?m, p5yCm, ?z) :- measurement(?m), val(?m, pL1dx51Cm, ?x), val(?m, p1yCm, ?y), add(?x, ?y, ?z).
val(?m, p6xCm, ?z) :- measurement(?m), val(?m, ddy24Cm, ?x), val(?m, ddL13, ?y), div(?x, ?y, ?z).
val(?m, p6yCm, ?z) :- measurement(?m), val(?m, pL1dx62Cm, ?x), val(?m, p2yCm, ?y), add(?x, ?y, ?z).
val(?m, sdx53Cm2, ?z) :- measurement(?m), val(?m, dx53Cm, ?x), pow(?x, 2, ?z).
val(?m, sdx64Cm2, ?z) :- measurement(?m), val(?m, dx64Cm, ?x), pow(?x, 2, ?z).
val(?m, sdy53Cm2, ?z) :- measurement(?m), val(?m, dy53Cm, ?x), pow(?x, 2, ?z).
val(?m, sdy64Cm2, ?z) :- measurement(?m), val(?m, dy64Cm, ?x), pow(?x, 2, ?z).
val(?m, ssd53Cm2, ?z) :- measurement(?m), val(?m, sdx53Cm2, ?x), val(?m, sdy53Cm2, ?y), add(?x, ?y, ?z).
val(?m, ssd64Cm2, ?z) :- measurement(?m), val(?m, sdx64Cm2, ?x), val(?m, sdy64Cm2, ?y), add(?x, ?y, ?z).
val(?m, d53Cm, ?z) :- measurement(?m), val(?m, ssd53Cm2, ?x), pow(?x, 0.5, ?z).
val(?m, d64Cm, ?z) :- measurement(?m), val(?m, ssd64Cm2, ?x), pow(?x, 0.5, ?z).
val(?m, dCm, ?z) :- measurement(?m), val(?m, d53Cm, ?x), val(?m, d64Cm, ?y), sub(?x, ?y, ?z).

% concise output layer
type(?m, lld_alarm) :- measurement(?m), val(?m, dCm, ?d), threshold(?m, lld_alarm_threshold_cm, ?t), sub(0, ?t, ?negt), lt(?d, ?negt).
type(?m, lld_alarm) :- measurement(?m), val(?m, dCm, ?d), threshold(?m, lld_alarm_threshold_cm, ?t), gt(?d, ?t).
lld_left_length_cm(?m, ?l) :- type(?m, lld_alarm), val(?m, d53Cm, ?l).
lld_right_length_cm(?m, ?r) :- type(?m, lld_alarm), val(?m, d64Cm, ?r).
lld_discrepancy_cm(?m, ?d) :- type(?m, lld_alarm), val(?m, dCm, ?d).
lld_threshold_cm(?m, ?t) :- type(?m, lld_alarm), threshold(?m, lld_alarm_threshold_cm, ?t).
lld_reason(?m, "discrepancy below negative threshold") :- type(?m, lld_alarm).
