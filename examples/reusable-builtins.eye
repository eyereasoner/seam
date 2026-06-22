% Reusable builtin tour for text, list, numeric, and quantifier helpers.
%
% Each report/2 clause demonstrates a small reusable operation: trimming and
% lowercasing text, splitting and joining tags, de-duplicating lists, slicing a
% window, aggregating scores, and validating facts with forall/2.
materialize(report, 2).

name_raw("  Ada Lovelace  ").
tag_csv("logic,math,logic,programming").
scores([8, 13, 21]).

report(normalized_name, ?name) :-
  name_raw(?raw),
  trim(?raw, ?trimmed),
  lowercase(?trimmed, ?name).

report(unique_tags, ?tags) :-
  tag_csv(?csv),
  split(?csv, ",", ?parts),
  list_to_set(?parts, ?tags).

report(tag_label, ?label) :-
  tag_csv(?csv),
  split(?csv, ",", ?parts),
  list_to_set(?parts, ?tags),
  join(?tags, " / ", ?label).

report(score_summary, summary(?total, ?peak, ?roottotal)) :-
  scores(?scores),
  sum_list(?scores, ?total),
  max_list(?scores, ?peak),
  sqrt(?total, ?roottotal).

report(window, ?slice) :-
  scores(?scores),
  slice(1, 2, ?scores, ?slice).
