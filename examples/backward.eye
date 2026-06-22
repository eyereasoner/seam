% Backward-rule example adapted from Eyeling backward.n3.
% Eyeling writes the interestingness rule in a backward style; eyelang records
% the same dependency as an ordinary Horn rule.  The example is intentionally
% tiny: it demonstrates that a derived fact can be justified by a numeric
% comparison in the rule body.

materialize(isIndeedMoreInterestingThan, 2).

moreInterestingThan(?x, ?y) :- gt(?x, ?y).

isIndeedMoreInterestingThan(5, 3) :- moreInterestingThan(5, 3).
