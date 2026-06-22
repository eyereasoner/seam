% Gregorian Easter computus adapted from Eyeling's easter.n3.
% Each case is a year in a sample decade.  The rules derive the Meeus/Jones/
% Butcher remainders, the final month/day, and a separate window check showing
% that the result lies in the legal Gregorian Easter range.

materialize(easterDate, 2).
materialize(computusRemainders, 2).
materialize(legalGregorianWindow, 2).

% Sample years for which the computed Easter date is materialized.
case(y2026, 2026).
case(y2027, 2027).
case(y2028, 2028).
case(y2029, 2029).
case(y2030, 2030).
case(y2031, 2031).
case(y2032, 2032).
case(y2033, 2033).
case(y2034, 2034).
case(y2035, 2035).

% These checks document the legal ranges of intermediate computus values.
valid_golden(?n) :- between(0, 18, ?n).
valid_epact(?n) :- between(0, 29, ?n).
valid_weekday(?n) :- between(0, 6, ?n).
legal_easter_date(3, ?d) :- between(22, 31, ?d).
legal_easter_date(4, ?d) :- between(1, 25, ?d).
month_name(3, march).
month_name(4, april).

% Butcher/Meeus-style integer arithmetic, kept explicit for proof readability.
computus(?case, ?year, ?month, ?day, ?j, ?k, ?q, ?r, ?v, ?z) :-
  case(?case, ?year),
  mod(?year, 19, ?j),
  div(?year, 100, ?k),
  mod(?year, 100, ?h),
  div(?k, 4, ?m),
  mod(?k, 4, ?n),
  add(?k, 8, ?kp8),
  div(?kp8, 25, ?p),
  sub(?k, ?p, ?kminusp),
  add(?kminusp, 1, ?kminuspplus1),
  div(?kminuspplus1, 3, ?q),
  mul(19, ?j, ?nineteenj),
  add(?nineteenj, ?k, ?t1),
  sub(?t1, ?m, ?t2),
  sub(?t2, ?q, ?t3),
  add(?t3, 15, ?t4),
  mod(?t4, 30, ?r),
  div(?h, 4, ?s),
  mod(?h, 4, ?u),
  mul(2, ?n, ?twon),
  mul(2, ?s, ?twos),
  add(32, ?twon, ?l1),
  add(?l1, ?twos, ?l2),
  sub(?l2, ?r, ?l3),
  sub(?l3, ?u, ?l4),
  mod(?l4, 7, ?v),
  mul(11, ?r, ?elevenr),
  mul(22, ?v, ?twentytwov),
  add(?j, ?elevenr, ?w1),
  add(?w1, ?twentytwov, ?w2),
  div(?w2, 451, ?w),
  mul(7, ?w, ?sevenw),
  add(?r, ?v, ?x1),
  sub(?x1, ?sevenw, ?x2),
  add(?x2, 114, ?x3),
  div(?x3, 31, ?month),
  mod(?x3, 31, ?z),
  add(?z, 1, ?day).

checks_pass(?case) :-
  computus(?case, ?_year, ?month, ?day, ?j, ?_k, ?_q, ?r, ?v, ?_z),
  valid_golden(?j),
  valid_epact(?r),
  valid_weekday(?v),
  month_name(?month, ?_name),
  legal_easter_date(?month, ?day).

easterDate(?case, date(?year, ?monthname, ?day)) :-
  computus(?case, ?year, ?month, ?day, ?_j, ?_k, ?_q, ?_r, ?_v, ?_z),
  month_name(?month, ?monthname).

computusRemainders(?case, remainders(?j, ?r, ?v)) :-
  computus(?case, ?_year, ?_month, ?_day, ?j, ?_k, ?_q, ?r, ?v, ?_z).

legalGregorianWindow(?case, true) :-
  checks_pass(?case).
