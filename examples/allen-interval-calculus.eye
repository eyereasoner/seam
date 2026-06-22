% Allen interval calculus adapted from Eyeling allen-interval-calculus.n3.
% Eyeling demonstrates dateTime and duration built-ins; this eyelang version
% uses integer hour offsets so the interval rules remain pure Horn clauses.
% The input interval table is a list of records, showing how tabular data can
% stay scoped as one term instead of many unrelated global start/end facts.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(start, 2).
materialize(end, 2).
materialize(duration, 2).
materialize(statement, 3).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
interval_table([
  interval(a, 10, 12),
  interval(b, 13, 15),
  interval(c, 12, 14),
  interval(d, 11, 13),
  interval(e, 10, 12),
  interval(f, 10, 11),
  interval(g, 11, 12),
  interval(h, 9, 16),
  interval(i, 16, 18),
  interval(j, 15, 16),
  interval(k, 13, 14)
]).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
interval(?i) :- interval_table(?table), member(interval(?i, ?_start, ?_end), ?table).
start(?i, ?start) :- interval_table(?table), member(interval(?i, ?start, ?_end), ?table).
end(?i, ?end) :- interval_table(?table), member(interval(?i, ?_start, ?end), ?table).

relation(?i, before, ?j) :- end(?i, ?ei), start(?j, ?sj), lt(?ei, ?sj).
relation(?i, meets, ?j) :- end(?i, ?e), start(?j, ?e).
relation(?i, overlaps, ?j) :-
  start(?i, ?si), end(?i, ?ei),
  start(?j, ?sj), end(?j, ?ej),
  lt(?si, ?sj), lt(?sj, ?ei), lt(?ei, ?ej).
relation(?i, starts, ?j) :-
  start(?i, ?s), start(?j, ?s),
  end(?i, ?ei), end(?j, ?ej),
  lt(?ei, ?ej).
relation(?i, during, ?j) :-
  start(?i, ?si), end(?i, ?ei),
  start(?j, ?sj), end(?j, ?ej),
  lt(?sj, ?si), lt(?ei, ?ej).
relation(?i, finishes, ?j) :-
  end(?i, ?e), end(?j, ?e),
  start(?i, ?si), start(?j, ?sj),
  lt(?sj, ?si).
relation(?i, equals, ?j) :-
  start(?i, ?s), start(?j, ?s),
  end(?i, ?e), end(?j, ?e).

relation(?j, after, ?i) :- relation(?i, before, ?j).
relation(?j, metBy, ?i) :- relation(?i, meets, ?j).
relation(?j, overlappedBy, ?i) :- relation(?i, overlaps, ?j).
relation(?j, startedBy, ?i) :- relation(?i, starts, ?j).
relation(?j, contains, ?i) :- relation(?i, during, ?j).
relation(?j, finishedBy, ?i) :- relation(?i, finishes, ?j).

duration(?i, ?d) :- end(?i, ?e), start(?i, ?s), sub(?e, ?s, ?d).

statement(?i, ?rel, ?j) :- relation(?i, ?rel, ?j).
