% Tiny job-shop scheduling benchmark.
%
% Three jobs each require one mill operation and one lathe operation, with fixed
% within-job precedence constraints.  The solver enumerates bounded start times,
% rejects machine overlaps, and uses aggregate_min/5 to keep the minimum makespan.
materialize(job_shop_answer, 2).

% Two operations on the same machine are compatible when either one finishes before the other starts.
nonoverlap(_StartA, EndA, StartB, _EndB) :- le(EndA, StartB).
nonoverlap(StartA, _EndA, _StartB, EndB) :- le(EndB, StartA).

feasible_schedule(Makespan, [
  op(j1_mill, J1MillStart, J1MillEnd),
  op(j1_lathe, J1LatheStart, J1LatheEnd),
  op(j2_lathe, J2LatheStart, J2LatheEnd),
  op(j2_mill, J2MillStart, J2MillEnd),
  op(j3_mill, J3MillStart, J3MillEnd),
  op(j3_lathe, J3LatheStart, J3LatheEnd)
]) :-
  between(0, 6, J1MillStart), add(J1MillStart, 3, J1MillEnd),
  between(0, 6, J1LatheStart), add(J1LatheStart, 2, J1LatheEnd),
  le(J1MillEnd, J1LatheStart),

  between(0, 6, J2LatheStart), add(J2LatheStart, 2, J2LatheEnd),
  between(0, 6, J2MillStart), add(J2MillStart, 4, J2MillEnd),
  le(J2LatheEnd, J2MillStart),

  between(0, 6, J3MillStart), add(J3MillStart, 2, J3MillEnd),
  between(0, 6, J3LatheStart), add(J3LatheStart, 3, J3LatheEnd),
  le(J3MillEnd, J3LatheStart),

  nonoverlap(J1MillStart, J1MillEnd, J2MillStart, J2MillEnd),
  nonoverlap(J1MillStart, J1MillEnd, J3MillStart, J3MillEnd),
  nonoverlap(J2MillStart, J2MillEnd, J3MillStart, J3MillEnd),
  nonoverlap(J1LatheStart, J1LatheEnd, J2LatheStart, J2LatheEnd),
  nonoverlap(J1LatheStart, J1LatheEnd, J3LatheStart, J3LatheEnd),
  nonoverlap(J2LatheStart, J2LatheEnd, J3LatheStart, J3LatheEnd),

  max(J1LatheEnd, J2MillEnd, PartialMakespan),
  max(PartialMakespan, J3LatheEnd, Makespan).

% aggregate_min/5 returns both the best makespan and the schedule that achieved it.
best_schedule(Makespan, Schedule) :-
  aggregate_min(Makespan, Schedule, feasible_schedule(Makespan, Schedule), Makespan, Schedule).

job_shop_answer(best_makespan, Makespan) :- best_schedule(Makespan, _Schedule).
job_shop_answer(best_schedule, Schedule) :- best_schedule(_Makespan, Schedule).
job_shop_answer(feasible_schedule_count, Count) :- countall(feasible_schedule(_Makespan, _Schedule), Count).
