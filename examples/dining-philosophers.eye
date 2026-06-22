% Chandy-Misra dining philosophers trace adapted from Eyeling dining-philosophers.n3.
%
% The example does not search for an arbitrary schedule.  Instead, it reasons over
% a finite trace of configurations and slots, deriving which fork requests are
% sent, which forks are kept, and which philosopher uses which fork in each meal.
%
% It is useful as a larger rule-translation example because many output facts are
% copied or transformed from state-transition relations.
% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(dp_type, 2).
materialize(dp_in, 2).
materialize(dp_from, 2).
materialize(dp_to, 2).
materialize(dp_fork, 2).
materialize(dp_philosopher, 2).
materialize(dp_mealNo, 2).
materialize(dp_inSlot, 2).
materialize(dp_usesFork, 2).

% The trace is represented as numbered configurations and slots.  Each slot
% records who is hungry, which forks are held, and how fork ownership changes.
left_fork(dp_P1, dp_F51). right_fork(dp_P1, dp_F12).
left_fork(dp_P2, dp_F12). right_fork(dp_P2, dp_F23).
left_fork(dp_P3, dp_F23). right_fork(dp_P3, dp_F34).
left_fork(dp_P4, dp_F34). right_fork(dp_P4, dp_F45).
left_fork(dp_P5, dp_F45). right_fork(dp_P5, dp_F51).

slot(dp_C0, dp_s1, 1). after_sends(dp_C0, dp_C1). after_eat(dp_C1, dp_C2).
slot(dp_C2, dp_s2, 1). after_sends(dp_C2, dp_C3). after_eat(dp_C3, dp_C4).
slot(dp_C4, dp_s3, 1). after_sends(dp_C4, dp_C5). after_eat(dp_C5, dp_C6).
slot(dp_C6, dp_s4, 2). after_sends(dp_C6, dp_C7). after_eat(dp_C7, dp_C8).
slot(dp_C8, dp_s5, 2). after_sends(dp_C8, dp_C9). after_eat(dp_C9, dp_C10).
slot(dp_C10, dp_s6, 2). after_sends(dp_C10, dp_C11). after_eat(dp_C11, dp_C12).
slot(dp_C12, dp_s7, 3). after_sends(dp_C12, dp_C13). after_eat(dp_C13, dp_C14).
slot(dp_C14, dp_s8, 3). after_sends(dp_C14, dp_C15). after_eat(dp_C15, dp_C16).
slot(dp_C16, dp_s9, 3). after_sends(dp_C16, dp_C17). after_eat(dp_C17, dp_C18).

hungry(dp_C0, dp_P1). hungry(dp_C0, dp_P3).
hungry(dp_C2, dp_P2). hungry(dp_C2, dp_P4).
hungry(dp_C4, dp_P5).
hungry(dp_C6, dp_P1). hungry(dp_C6, dp_P3).
hungry(dp_C8, dp_P2). hungry(dp_C8, dp_P4).
hungry(dp_C10, dp_P5).
hungry(dp_C12, dp_P1). hungry(dp_C12, dp_P3).
hungry(dp_C14, dp_P2). hungry(dp_C14, dp_P4).
hungry(dp_C16, dp_P5).

start_state(dp_C0, dp_F12, dp_P1, dp_Dirty).
start_state(dp_C0, dp_F23, dp_P2, dp_Dirty).
start_state(dp_C0, dp_F34, dp_P3, dp_Dirty).
start_state(dp_C0, dp_F45, dp_P4, dp_Dirty).
start_state(dp_C0, dp_F51, dp_P1, dp_Dirty).
start_state(dp_C2, dp_F12, dp_P1, dp_Dirty).
start_state(dp_C2, dp_F23, dp_P3, dp_Dirty).
start_state(dp_C2, dp_F34, dp_P3, dp_Dirty).
start_state(dp_C2, dp_F45, dp_P4, dp_Dirty).
start_state(dp_C2, dp_F51, dp_P1, dp_Dirty).
start_state(dp_C4, dp_F12, dp_P2, dp_Dirty).
start_state(dp_C4, dp_F23, dp_P2, dp_Dirty).
start_state(dp_C4, dp_F34, dp_P4, dp_Dirty).
start_state(dp_C4, dp_F45, dp_P4, dp_Dirty).
start_state(dp_C4, dp_F51, dp_P1, dp_Dirty).
start_state(dp_C6, dp_F12, dp_P2, dp_Dirty).
start_state(dp_C6, dp_F23, dp_P2, dp_Dirty).
start_state(dp_C6, dp_F34, dp_P4, dp_Dirty).
start_state(dp_C6, dp_F45, dp_P5, dp_Dirty).
start_state(dp_C6, dp_F51, dp_P5, dp_Dirty).
start_state(dp_C8, dp_F12, dp_P1, dp_Dirty).
start_state(dp_C8, dp_F23, dp_P3, dp_Dirty).
start_state(dp_C8, dp_F34, dp_P3, dp_Dirty).
start_state(dp_C8, dp_F45, dp_P5, dp_Dirty).
start_state(dp_C8, dp_F51, dp_P1, dp_Dirty).
start_state(dp_C10, dp_F12, dp_P2, dp_Dirty).
start_state(dp_C10, dp_F23, dp_P2, dp_Dirty).
start_state(dp_C10, dp_F34, dp_P4, dp_Dirty).
start_state(dp_C10, dp_F45, dp_P4, dp_Dirty).
start_state(dp_C10, dp_F51, dp_P1, dp_Dirty).
start_state(dp_C12, dp_F12, dp_P2, dp_Dirty).
start_state(dp_C12, dp_F23, dp_P2, dp_Dirty).
start_state(dp_C12, dp_F34, dp_P4, dp_Dirty).
start_state(dp_C12, dp_F45, dp_P5, dp_Dirty).
start_state(dp_C12, dp_F51, dp_P5, dp_Dirty).
start_state(dp_C14, dp_F12, dp_P1, dp_Dirty).
start_state(dp_C14, dp_F23, dp_P3, dp_Dirty).
start_state(dp_C14, dp_F34, dp_P3, dp_Dirty).
start_state(dp_C14, dp_F45, dp_P5, dp_Dirty).
start_state(dp_C14, dp_F51, dp_P1, dp_Dirty).
start_state(dp_C16, dp_F12, dp_P2, dp_Dirty).
start_state(dp_C16, dp_F23, dp_P2, dp_Dirty).
start_state(dp_C16, dp_F34, dp_P4, dp_Dirty).
start_state(dp_C16, dp_F45, dp_P4, dp_Dirty).
start_state(dp_C16, dp_F51, dp_P1, dp_Dirty).
keep(dp_C0, dp_F12). keep(dp_C0, dp_F34). keep(dp_C0, dp_F45). keep(dp_C0, dp_F51).
keep(dp_C2, dp_F45). keep(dp_C2, dp_F51).
keep(dp_C4, dp_F12). keep(dp_C4, dp_F23). keep(dp_C4, dp_F34).
keep(dp_C6, dp_F45).
keep(dp_C8, dp_F51).
keep(dp_C10, dp_F12). keep(dp_C10, dp_F23). keep(dp_C10, dp_F34).
keep(dp_C12, dp_F45).
keep(dp_C14, dp_F51).
keep(dp_C16, dp_F12). keep(dp_C16, dp_F23). keep(dp_C16, dp_F34).

meal_handle(dp_P1, 1, dp_mP1_1). meal_handle(dp_P1, 2, dp_mP1_2). meal_handle(dp_P1, 3, dp_mP1_3).
meal_handle(dp_P2, 1, dp_mP2_1). meal_handle(dp_P2, 2, dp_mP2_2). meal_handle(dp_P2, 3, dp_mP2_3).
meal_handle(dp_P3, 1, dp_mP3_1). meal_handle(dp_P3, 2, dp_mP3_2). meal_handle(dp_P3, 3, dp_mP3_3).
meal_handle(dp_P4, 1, dp_mP4_1). meal_handle(dp_P4, 2, dp_mP4_2). meal_handle(dp_P4, 3, dp_mP4_3).
meal_handle(dp_P5, 1, dp_mP5_1). meal_handle(dp_P5, 2, dp_mP5_2). meal_handle(dp_P5, 3, dp_mP5_3).

% Rules derive requests, sends, kept forks, and eating events for each
% configuration transition, mirroring Chandy-Misra message passing.
request(?c, ?p, ?q, ?f) :-
  hungry(?c, ?p), left_fork(?p, ?f), start_state(?c, ?f, ?q, ?_cleanliness), neq(?q, ?p).
request(?c, ?p, ?q, ?f) :-
  hungry(?c, ?p), right_fork(?p, ?f), start_state(?c, ?f, ?q, ?_cleanliness), neq(?q, ?p).

send_fork(?c, ?q, ?p, ?f) :-
  request(?c, ?p, ?q, ?f), start_state(?c, ?f, ?q, dp_Dirty).

after_send_state(?cs, ?f, ?p, dp_Clean) :-
  after_sends(?c, ?cs), send_fork(?c, ?_q, ?p, ?f).
after_send_state(?cs, ?f, ?h, ?cleanliness) :-
  after_sends(?c, ?cs), keep(?c, ?f), start_state(?c, ?f, ?h, ?cleanliness).

meal(?m, ?p, ?n, ?s) :-
  after_sends(?c, ?cs), slot(?c, ?s, ?n), hungry(?c, ?p), meal_handle(?p, ?n, ?m),
  left_fork(?p, ?lf), right_fork(?p, ?rf),
  after_send_state(?cs, ?lf, ?p, ?_leftcleanliness),
  after_send_state(?cs, ?rf, ?p, ?_rightcleanliness).

dp_type(request(?c, ?p, ?q, ?f), dp_Request) :- request(?c, ?p, ?q, ?f).
dp_in(request(?c, ?p, ?q, ?f), ?c) :- request(?c, ?p, ?q, ?f).
dp_from(request(?c, ?p, ?q, ?f), ?p) :- request(?c, ?p, ?q, ?f).
dp_to(request(?c, ?p, ?q, ?f), ?q) :- request(?c, ?p, ?q, ?f).
dp_fork(request(?c, ?p, ?q, ?f), ?f) :- request(?c, ?p, ?q, ?f).

dp_type(send(?c, ?q, ?p, ?f), dp_SendFork) :- send_fork(?c, ?q, ?p, ?f).
dp_in(send(?c, ?q, ?p, ?f), ?c) :- send_fork(?c, ?q, ?p, ?f).
dp_from(send(?c, ?q, ?p, ?f), ?q) :- send_fork(?c, ?q, ?p, ?f).
dp_to(send(?c, ?q, ?p, ?f), ?p) :- send_fork(?c, ?q, ?p, ?f).
dp_fork(send(?c, ?q, ?p, ?f), ?f) :- send_fork(?c, ?q, ?p, ?f).

dp_type(?m, dp_Meal) :- meal(?m, ?_p, ?_n, ?_s).
dp_philosopher(?m, ?p) :- meal(?m, ?p, ?_n, ?_s).
dp_mealNo(?m, ?n) :- meal(?m, ?_p, ?n, ?_s).
dp_inSlot(?m, ?s) :- meal(?m, ?_p, ?_n, ?s).
dp_usesFork(?m, ?lf) :- meal(?m, ?p, ?_n, ?_s), left_fork(?p, ?lf).
dp_usesFork(?m, ?rf) :- meal(?m, ?p, ?_n, ?_s), right_fork(?p, ?rf).
