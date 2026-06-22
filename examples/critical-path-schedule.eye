% Critical-path scheduling for a small project network.
%
% earliest_start/2 is the maximum finish time over all predecessors; finish_time/2
% adds task duration.  Critical tasks are reconstructed by following predecessors
% that attain those maxima.  Memoization lets the schedule, finish date, and path
% queries share the same project-network subproblems.
materialize(critical_path_answer, 2).

table(earliest_start, 2).
table(finish_time, 2).

% Durations are in arbitrary project time units.
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

earliest_start(?task, 0) :-
  task(?task, ?_duration),
  not(depends(?task, ?_pred)).
earliest_start(?task, ?start) :-
  depends(?task, ?_pred),
  aggregate_max(?finish, ?pred,
    (depends(?task, ?pred), finish_time(?pred, ?finish)),
    ?start, ?_criticalpred).

finish_time(?task, ?finish) :-
  task(?task, ?duration),
  earliest_start(?task, ?start),
  add(?start, ?duration, ?finish).

% For each task, choose a predecessor that determines its earliest start.
critical_predecessor(?task, ?pred) :-
  depends(?task, ?_anypred),
  aggregate_max(?finish, ?p,
    (depends(?task, ?p), finish_time(?p, ?finish)),
    ?_bestfinish, ?pred).

project_finish(?finish) :-
  aggregate_max(?finishtime, ?task, finish_time(?task, ?finishtime), ?finish, ?_lasttask).

final_task(?task) :-
  project_finish(?finish),
  finish_time(?task, ?finish).

critical_chain(?task, ?task).
critical_chain(?task, ?pred) :-
  critical_predecessor(?task, ?parent),
  critical_chain(?parent, ?pred).

critical_task(?task) :-
  final_task(?final),
  critical_chain(?final, ?task).

critical_path_answer(project_finish, ?finish) :- project_finish(?finish).
critical_path_answer(critical_task, ?task) :- critical_task(?task).
critical_path_answer(schedule, task(?task, ?start, ?finish)) :-
  task(?task, ?_duration),
  earliest_start(?task, ?start),
  finish_time(?task, ?finish).
