% Tiny job-shop scheduling benchmark.
%
% Three jobs each require one mill operation and one lathe operation, with fixed
% within-job precedence constraints.  The solver enumerates bounded start times,
% rejects machine overlaps, and uses aggregate_min/5 to keep the minimum makespan.
materialize(job_shop_answer, 2).

% Two operations on the same machine are compatible when either one finishes before the other starts.
nonoverlap(?_starta, ?enda, ?startb, ?_endb) :- le(?enda, ?startb).
nonoverlap(?starta, ?_enda, ?_startb, ?endb) :- le(?endb, ?starta).

feasible_schedule(?makespan, [
  op(j1_mill, ?j1millstart, ?j1millend),
  op(j1_lathe, ?j1lathestart, ?j1latheend),
  op(j2_lathe, ?j2lathestart, ?j2latheend),
  op(j2_mill, ?j2millstart, ?j2millend),
  op(j3_mill, ?j3millstart, ?j3millend),
  op(j3_lathe, ?j3lathestart, ?j3latheend)
]) :-
  between(0, 6, ?j1millstart), add(?j1millstart, 3, ?j1millend),
  between(0, 6, ?j1lathestart), add(?j1lathestart, 2, ?j1latheend),
  le(?j1millend, ?j1lathestart),

  between(0, 6, ?j2lathestart), add(?j2lathestart, 2, ?j2latheend),
  between(0, 6, ?j2millstart), add(?j2millstart, 4, ?j2millend),
  le(?j2latheend, ?j2millstart),

  between(0, 6, ?j3millstart), add(?j3millstart, 2, ?j3millend),
  between(0, 6, ?j3lathestart), add(?j3lathestart, 3, ?j3latheend),
  le(?j3millend, ?j3lathestart),

  nonoverlap(?j1millstart, ?j1millend, ?j2millstart, ?j2millend),
  nonoverlap(?j1millstart, ?j1millend, ?j3millstart, ?j3millend),
  nonoverlap(?j2millstart, ?j2millend, ?j3millstart, ?j3millend),
  nonoverlap(?j1lathestart, ?j1latheend, ?j2lathestart, ?j2latheend),
  nonoverlap(?j1lathestart, ?j1latheend, ?j3lathestart, ?j3latheend),
  nonoverlap(?j2lathestart, ?j2latheend, ?j3lathestart, ?j3latheend),

  max(?j1latheend, ?j2millend, ?partialmakespan),
  max(?partialmakespan, ?j3latheend, ?makespan).

% aggregate_min/5 returns both the best makespan and the schedule that achieved it.
best_schedule(?makespan, ?schedule) :-
  aggregate_min(?makespan, ?schedule, feasible_schedule(?makespan, ?schedule), ?makespan, ?schedule).

job_shop_answer(best_makespan, ?makespan) :- best_schedule(?makespan, ?_schedule).
job_shop_answer(best_schedule, ?schedule) :- best_schedule(?_makespan, ?schedule).
job_shop_answer(feasible_schedule_count, ?count) :- countall(feasible_schedule(?_makespan, ?_schedule), ?count).
