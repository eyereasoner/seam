% Engineering example: RC low-pass filter sizing.
%
% A resistor and capacitor define the time constant tau = R*C.  The cutoff
% frequency rule then computes fc = 1/(2*pi*tau).
%
% The model uses key/value component facts so the same pattern can be extended to
% multiple named filters or extra component attributes without changing the rules.

materialize(type, 2).
materialize(timeConstant_s, 2).
materialize(cutoffFrequency_Hz, 2).

component(filter1, resistor_ohm, 10000.0).
component(filter1, capacitor_f, 0.000001).
constant(pi, 3.141592653589793).

time_constant(?filter, ?tau) :-
  component(?filter, resistor_ohm, ?r),
  component(?filter, capacitor_f, ?c),
  mul(?r, ?c, ?tau).

cutoff_frequency(?filter, ?frequency) :-
  time_constant(?filter, ?tau),
  constant(pi, ?pi),
  mul(2.0, ?pi, ?twopi),
  mul(?twopi, ?tau, ?denominator),
  div(1.0, ?denominator, ?frequency).

type(?filter, first_order_low_pass) :-
  component(?filter, resistor_ohm, ?_r),
  component(?filter, capacitor_f, ?_c).

timeConstant_s(?filter, ?tau) :-
  time_constant(?filter, ?tau).

cutoffFrequency_Hz(?filter, ?frequency) :-
  cutoff_frequency(?filter, ?frequency).
