% Cryptarithm search for SEND + MORE = MONEY.
% The solver assigns distinct decimal digits to letters while enforcing the usual column-by-column carries.
% Early constraints for M=1, O=0, and each column sum prune most of the search before full numbers are built.
materialize(cryptarithm_answer, 2).

all_digits([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]).

send_more_money(solution(S, E, N, D, M, O, R, Y)) :-
  all_digits(Digits),
  eq(M, 1),
  eq(O, 0),
  select(M, Digits, D0),
  select(O, D0, D1),

  select(D, D1, D2),
  select(E, D2, D3),
  add(D, E, OnesSum),
  mod(OnesSum, 10, Y),
  div(OnesSum, 10, Carry1),
  select(Y, D3, D4),

  select(N, D4, D5),
  select(R, D5, D6),
  add(N, R, TensPartial),
  add(TensPartial, Carry1, TensSum),
  mod(TensSum, 10, E),
  div(TensSum, 10, Carry2),

  add(E, O, HundredsPartial),
  add(HundredsPartial, Carry2, HundredsSum),
  mod(HundredsSum, 10, N),
  div(HundredsSum, 10, Carry3),

  select(S, D6, _D7),
  neq(S, 0),
  add(S, M, ThousandsPartial),
  add(ThousandsPartial, Carry3, ThousandsSum),
  mod(ThousandsSum, 10, O),
  div(ThousandsSum, 10, M).

number4(A, B, C, D, Value) :-
  mul(A, 1000, APart),
  mul(B, 100, BPart),
  mul(C, 10, CPart),
  add(APart, BPart, AB),
  add(AB, CPart, ABC),
  add(ABC, D, Value).

number5(A, B, C, D, E, Value) :-
  mul(A, 10000, APart),
  mul(B, 1000, BPart),
  mul(C, 100, CPart),
  mul(D, 10, DPart),
  add(APart, BPart, AB),
  add(AB, CPart, ABC),
  add(ABC, DPart, ABCD),
  add(ABCD, E, Value).

cryptarithm_answer(assignments, solution(S, E, N, D, M, O, R, Y)) :-
  send_more_money(solution(S, E, N, D, M, O, R, Y)).
cryptarithm_answer(equation, equation(Send, More, Money)) :-
  send_more_money(solution(S, E, N, D, M, O, R, Y)),
  number4(S, E, N, D, Send),
  number4(M, O, R, E, More),
  number5(M, O, N, E, Y, Money).
cryptarithm_answer(solution_count, Count) :-
  countall(send_more_money(_Solution), Count).
