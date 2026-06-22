% Technology example: cache performance summary.
%
% A service has cache hits and misses with different response latencies. The
% rules compute hit rate and weighted average latency, then classify whether
% the cache is effective.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(hitRate, 2).
materialize(averageLatency_ms, 2).
materialize(status, 2).
materialize(reason, 2).

% cache_sample/5 contains hits, misses, and the two latency classes; threshold/3
% contains the operational targets used by the status rule.
cache_sample(api_cache, 8600.0, 1400.0, 5.0, 80.0).
threshold(api_cache, minimum_hit_rate, 0.80).
threshold(api_cache, maximum_average_latency_ms, 20.0).

% The rules compute total requests, hit rate, and weighted latency before
% applying both acceptance thresholds together.
total_requests(?cache, ?total) :-
  cache_sample(?cache, ?hits, ?misses, ?_hitlatency, ?_misslatency),
  add(?hits, ?misses, ?total).

hit_rate(?cache, ?rate) :-
  cache_sample(?cache, ?hits, ?_misses, ?_hitlatency, ?_misslatency),
  total_requests(?cache, ?total),
  div(?hits, ?total, ?rate).

average_latency(?cache, ?average) :-
  cache_sample(?cache, ?hits, ?misses, ?hitlatency, ?misslatency),
  mul(?hits, ?hitlatency, ?hitcost),
  mul(?misses, ?misslatency, ?misscost),
  add(?hitcost, ?misscost, ?totalcost),
  total_requests(?cache, ?total),
  div(?totalcost, ?total, ?average).

cache_effective(?cache) :-
  hit_rate(?cache, ?rate),
  threshold(?cache, minimum_hit_rate, ?minimumrate),
  gt(?rate, ?minimumrate),
  average_latency(?cache, ?average),
  threshold(?cache, maximum_average_latency_ms, ?maximumlatency),
  lt(?average, ?maximumlatency).

hitRate(?cache, ?rate) :-
  hit_rate(?cache, ?rate).

averageLatency_ms(?cache, ?average) :-
  average_latency(?cache, ?average).

status(?cache, cache_effective) :-
  cache_effective(?cache).

reason(?cache, "hit rate is above target and average latency is below limit") :-
  cache_effective(?cache).
