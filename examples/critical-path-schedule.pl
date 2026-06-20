% Critical-path scheduling for a small project network.
% earliest_start/2 and finish_time/2 are memoized because many schedule and
% critical-path queries reuse the same predecessor subproblems.
materialize(critical_path_answer, 2).

memoize(earliest_start, 2).
memoize(finish_time, 2).

task(requirements, 2).
task(architecture, 3).
task(api_design, 2).
task(database, 4).
task(backend, 6).
task(frontend, 5).
task(auth, 3).
task(integration, 4).
task(security_review, 3).
task(load_test, 2).
task(launch, 1).

depends(architecture, requirements).
depends(api_design, requirements).
depends(database, architecture).
depends(backend, api_design).
depends(backend, database).
depends(frontend, api_design).
depends(auth, architecture).
depends(integration, backend).
depends(integration, frontend).
depends(integration, auth).
depends(security_review, integration).
depends(load_test, integration).
depends(launch, security_review).
depends(launch, load_test).

earliest_start(Task, 0) :-
  task(Task, _Duration),
  not(depends(Task, _Pred)).
earliest_start(Task, Start) :-
  depends(Task, _Pred),
  aggregate_max(Finish, Pred,
    (depends(Task, Pred), finish_time(Pred, Finish)),
    Start, _CriticalPred).

finish_time(Task, Finish) :-
  task(Task, Duration),
  earliest_start(Task, Start),
  add(Start, Duration, Finish).

critical_predecessor(Task, Pred) :-
  depends(Task, _AnyPred),
  aggregate_max(Finish, P,
    (depends(Task, P), finish_time(P, Finish)),
    _BestFinish, Pred).

project_finish(Finish) :-
  aggregate_max(FinishTime, Task, finish_time(Task, FinishTime), Finish, _LastTask).

final_task(Task) :-
  project_finish(Finish),
  finish_time(Task, Finish).

critical_chain(Task, Task).
critical_chain(Task, Pred) :-
  critical_predecessor(Task, Parent),
  critical_chain(Parent, Pred).

critical_task(Task) :-
  final_task(Final),
  critical_chain(Final, Task).

critical_path_answer(project_finish, Finish) :- project_finish(Finish).
critical_path_answer(critical_task, Task) :- critical_task(Task).
critical_path_answer(schedule, task(Task, Start, Finish)) :-
  task(Task, _Duration),
  earliest_start(Task, Start),
  finish_time(Task, Finish).
