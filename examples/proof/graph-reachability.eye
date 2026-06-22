reachable(reachability_case, path(a, f)).
why(
  reachable(reachability_case, path(a, f)),
  proof(
    goal(reachable(reachability_case, path(a, f))),
    by(rule("graph-reachability.eye", clause(13))),
    uses([
      proof(
        goal(is_reachable(a, f)),
        by(rule("graph-reachability.eye", clause(12))),
        bindings([binding("?start", a), binding("?goal", f)]),
        uses([
          proof(
            goal(reachable(a, f, [a])),
            by(rule("graph-reachability.eye", clause(11))),
            bindings([binding("?start", a), binding("?goal", f), binding("?visited", [a]), binding("?next", b)]),
            uses([
              proof(
                goal(edge(a, b)),
                by(fact("graph-reachability.eye", clause(3)))
              ),
              proof(
                goal(not(member(b, [a]))),
                by(builtin(not, 1))
              ),
              proof(
                goal(reachable(b, f, [b, a])),
                by(rule("graph-reachability.eye", clause(11))),
                bindings([binding("?start", b), binding("?goal", f), binding("?visited", [b, a]), binding("?next", d)]),
                uses([
                  proof(
                    goal(edge(b, d)),
                    by(fact("graph-reachability.eye", clause(5)))
                  ),
                  proof(
                    goal(not(member(d, [b, a]))),
                    by(builtin(not, 1))
                  ),
                  proof(
                    goal(reachable(d, f, [d, b, a])),
                    by(rule("graph-reachability.eye", clause(11))),
                    bindings([binding("?start", d), binding("?goal", f), binding("?visited", [d, b, a]), binding("?next", f)]),
                    uses([
                      proof(
                        goal(edge(d, f)),
                        by(fact("graph-reachability.eye", clause(7)))
                      ),
                      proof(
                        goal(not(member(f, [d, b, a]))),
                        by(builtin(not, 1))
                      ),
                      proof(
                        goal(reachable(f, f, [f, d, b, a])),
                        by(fact("graph-reachability.eye", clause(10))),
                        bindings([binding("?node", f), binding("?_visited", [f, d, b, a])])
                      )
                    ])
                  )
                ])
              )
            ])
          )
        ])
      )
    ])
  )
).

reachable(reachability_case, path(c, g)).
why(
  reachable(reachability_case, path(c, g)),
  proof(
    goal(reachable(reachability_case, path(c, g))),
    by(rule("graph-reachability.eye", clause(14))),
    uses([
      proof(
        goal(is_reachable(c, g)),
        by(rule("graph-reachability.eye", clause(12))),
        bindings([binding("?start", c), binding("?goal", g)]),
        uses([
          proof(
            goal(reachable(c, g, [c])),
            by(rule("graph-reachability.eye", clause(11))),
            bindings([binding("?start", c), binding("?goal", g), binding("?visited", [c]), binding("?next", e)]),
            uses([
              proof(
                goal(edge(c, e)),
                by(fact("graph-reachability.eye", clause(6)))
              ),
              proof(
                goal(not(member(e, [c]))),
                by(builtin(not, 1))
              ),
              proof(
                goal(reachable(e, g, [e, c])),
                by(rule("graph-reachability.eye", clause(11))),
                bindings([binding("?start", e), binding("?goal", g), binding("?visited", [e, c]), binding("?next", f)]),
                uses([
                  proof(
                    goal(edge(e, f)),
                    by(fact("graph-reachability.eye", clause(8)))
                  ),
                  proof(
                    goal(not(member(f, [e, c]))),
                    by(builtin(not, 1))
                  ),
                  proof(
                    goal(reachable(f, g, [f, e, c])),
                    by(rule("graph-reachability.eye", clause(11))),
                    bindings([binding("?start", f), binding("?goal", g), binding("?visited", [f, e, c]), binding("?next", g)]),
                    uses([
                      proof(
                        goal(edge(f, g)),
                        by(fact("graph-reachability.eye", clause(9)))
                      ),
                      proof(
                        goal(not(member(g, [f, e, c]))),
                        by(builtin(not, 1))
                      ),
                      proof(
                        goal(reachable(g, g, [g, f, e, c])),
                        by(fact("graph-reachability.eye", clause(10))),
                        bindings([binding("?node", g), binding("?_visited", [g, f, e, c])])
                      )
                    ])
                  )
                ])
              )
            ])
          )
        ])
      )
    ])
  )
).

not_reachable(reachability_case, path(b, e)).
why(
  not_reachable(reachability_case, path(b, e)),
  proof(
    goal(not_reachable(reachability_case, path(b, e))),
    by(rule("graph-reachability.eye", clause(15))),
    uses([
      proof(
        goal(not(is_reachable(b, e))),
        by(builtin(not, 1))
      )
    ])
  )
).

