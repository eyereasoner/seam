% Reference 9.6: matches/2 and not_matches/2 can filter candidate strings.
text(a, "alpha").
text(b, "beta").
answer(has_ph, ?k) :- text(?k, ?t), matches(?t, "ph").
answer(no_ph, ?k) :- text(?k, ?t), not_matches(?t, "ph").
materialize(answer, 2).
