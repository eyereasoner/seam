% Reference 9.6: matches/3 extracts named regular-expression captures into a context.
materialize(answer, 3).

line("event=login_failed user=alice trace=4bf92f3577b34da6a3ce929d0e0e4736").
pattern("^event=(?<event>\\w+) user=(?<user>\\w+) trace=(?<trace_id>[0-9a-f]{32})$").

answer(?user, ?event, ?traceid) :-
  line(?text),
  pattern(?pattern),
  matches(?text, ?pattern, ?context),
  holds(?context, event(?event)),
  holds(?context, user(?user)),
  holds(?context, trace_id(?traceid)).
