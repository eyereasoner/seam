% Reference 9.6 and 9.9: matches/3 turns named captures into context terms.
materialize(answer, 2).
line("level=warn code=E42 user=bob").
answer(level, ?x) :- line(?l), matches(?l, "level=(?<level>\\w+) code=(?<code>\\w+) user=(?<user>\\w+)", ?c), holds(?c, level(?x)).
answer(code, ?x) :- line(?l), matches(?l, "level=(?<level>\\w+) code=(?<code>\\w+) user=(?<user>\\w+)", ?c), holds(?c, code(?x)).
answer(user, ?x) :- line(?l), matches(?l, "level=(?<level>\\w+) code=(?<code>\\w+) user=(?<user>\\w+)", ?c), holds(?c, user(?x)).
answer(no_named_groups_rejected, ok) :- not(matches("abc", "a(b)c", ?c)).
answer(bad_regex_rejected, ok) :- not(matches("abc", "(", ?c)).
