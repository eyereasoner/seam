% Cryptarithm search for SEND + MORE = MONEY.
%
% The solver assigns distinct decimal digits to letters while enforcing the
% column-by-column carries.  Rather than generate all digit assignments first,
% each column constraint is applied as soon as its letters are chosen.
materialize(cryptarithm_answer, 2).

% The search domain is a shrinking digit list threaded through select/3 calls.
all_digits([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]).

send_more_money(solution(?s, ?e, ?n, ?d, ?m, ?o, ?r, ?y)) :-
  all_digits(?digits),
  eq(?m, 1),
  eq(?o, 0),
  select(?m, ?digits, ?d0),
  select(?o, ?d0, ?d1),

  select(?d, ?d1, ?d2),
  select(?e, ?d2, ?d3),
  add(?d, ?e, ?onessum),
  mod(?onessum, 10, ?y),
  div(?onessum, 10, ?carry1),
  select(?y, ?d3, ?d4),

  select(?n, ?d4, ?d5),
  select(?r, ?d5, ?d6),
  add(?n, ?r, ?tenspartial),
  add(?tenspartial, ?carry1, ?tenssum),
  mod(?tenssum, 10, ?e),
  div(?tenssum, 10, ?carry2),

  add(?e, ?o, ?hundredspartial),
  add(?hundredspartial, ?carry2, ?hundredssum),
  mod(?hundredssum, 10, ?n),
  div(?hundredssum, 10, ?carry3),

  select(?s, ?d6, ?_d7),
  neq(?s, 0),
  add(?s, ?m, ?thousandspartial),
  add(?thousandspartial, ?carry3, ?thousandssum),
  mod(?thousandssum, 10, ?o),
  div(?thousandssum, 10, ?m).

% Number constructors are used only for readable output after a solution is found.
number4(?a, ?b, ?c, ?d, ?value) :-
  mul(?a, 1000, ?apart),
  mul(?b, 100, ?bpart),
  mul(?c, 10, ?cpart),
  add(?apart, ?bpart, ?ab),
  add(?ab, ?cpart, ?abc),
  add(?abc, ?d, ?value).

number5(?a, ?b, ?c, ?d, ?e, ?value) :-
  mul(?a, 10000, ?apart),
  mul(?b, 1000, ?bpart),
  mul(?c, 100, ?cpart),
  mul(?d, 10, ?dpart),
  add(?apart, ?bpart, ?ab),
  add(?ab, ?cpart, ?abc),
  add(?abc, ?dpart, ?abcd),
  add(?abcd, ?e, ?value).

cryptarithm_answer(assignments, solution(?s, ?e, ?n, ?d, ?m, ?o, ?r, ?y)) :-
  send_more_money(solution(?s, ?e, ?n, ?d, ?m, ?o, ?r, ?y)).
cryptarithm_answer(equation, equation(?send, ?more, ?money)) :-
  send_more_money(solution(?s, ?e, ?n, ?d, ?m, ?o, ?r, ?y)),
  number4(?s, ?e, ?n, ?d, ?send),
  number4(?m, ?o, ?r, ?e, ?more),
  number5(?m, ?o, ?n, ?e, ?y, ?money).
cryptarithm_answer(solution_count, ?count) :-
  countall(send_more_money(?_solution), ?count).
