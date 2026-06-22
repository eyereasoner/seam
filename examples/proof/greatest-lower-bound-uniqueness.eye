sameGreatestLowerBound(a, b, g1, g2).
why(
  sameGreatestLowerBound(a, b, g1, g2),
  proof(
    goal(sameGreatestLowerBound(a, b, g1, g2)),
    by(rule("greatest-lower-bound-uniqueness.eye", clause(7))),
    bindings([binding("?a", a), binding("?b", b), binding("?m", g1), binding("?n", g2)]),
    uses([
      proof(
        goal(glbOf(g1, a, b)),
        by(fact("greatest-lower-bound-uniqueness.eye", clause(2)))
      ),
      proof(
        goal(glbOf(g2, a, b)),
        by(fact("greatest-lower-bound-uniqueness.eye", clause(3)))
      ),
      proof(
        goal(sameTerm(g1, g2)),
        by(rule("greatest-lower-bound-uniqueness.eye", clause(6))),
        bindings([binding("?m", g1), binding("?n", g2)]),
        uses([
          proof(
            goal(leq(g1, g2)),
            by(rule("greatest-lower-bound-uniqueness.eye", clause(5))),
            bindings([binding("?l", g1), binding("?m", g2), binding("?a", a), binding("?b", b)]),
            uses([
              proof(
                goal(glbOf(g2, a, b)),
                by(fact("greatest-lower-bound-uniqueness.eye", clause(3)))
              ),
              proof(
                goal(lowerBoundOf(g1, a, b)),
                by(rule("greatest-lower-bound-uniqueness.eye", clause(4))),
                bindings([binding("?m", g1), binding("?a", a), binding("?b", b)]),
                uses([
                  proof(
                    goal(glbOf(g1, a, b)),
                    by(fact("greatest-lower-bound-uniqueness.eye", clause(2)))
                  )
                ])
              )
            ])
          ),
          proof(
            goal(leq(g2, g1)),
            by(rule("greatest-lower-bound-uniqueness.eye", clause(5))),
            bindings([binding("?l", g2), binding("?m", g1), binding("?a", a), binding("?b", b)]),
            uses([
              proof(
                goal(glbOf(g1, a, b)),
                by(fact("greatest-lower-bound-uniqueness.eye", clause(2)))
              ),
              proof(
                goal(lowerBoundOf(g2, a, b)),
                by(rule("greatest-lower-bound-uniqueness.eye", clause(4))),
                bindings([binding("?m", g2), binding("?a", a), binding("?b", b)]),
                uses([
                  proof(
                    goal(glbOf(g2, a, b)),
                    by(fact("greatest-lower-bound-uniqueness.eye", clause(3)))
                  )
                ])
              )
            ])
          )
        ])
      ),
      proof(
        goal(neq(g1, g2)),
        by(builtin(neq, 2))
      )
    ])
  )
).

sameGreatestLowerBound(a, b, g2, g1).
why(
  sameGreatestLowerBound(a, b, g2, g1),
  proof(
    goal(sameGreatestLowerBound(a, b, g2, g1)),
    by(rule("greatest-lower-bound-uniqueness.eye", clause(7))),
    bindings([binding("?a", a), binding("?b", b), binding("?m", g2), binding("?n", g1)]),
    uses([
      proof(
        goal(glbOf(g2, a, b)),
        by(fact("greatest-lower-bound-uniqueness.eye", clause(3)))
      ),
      proof(
        goal(glbOf(g1, a, b)),
        by(fact("greatest-lower-bound-uniqueness.eye", clause(2)))
      ),
      proof(
        goal(sameTerm(g2, g1)),
        by(rule("greatest-lower-bound-uniqueness.eye", clause(6))),
        bindings([binding("?m", g2), binding("?n", g1)]),
        uses([
          proof(
            goal(leq(g2, g1)),
            by(rule("greatest-lower-bound-uniqueness.eye", clause(5))),
            bindings([binding("?l", g2), binding("?m", g1), binding("?a", a), binding("?b", b)]),
            uses([
              proof(
                goal(glbOf(g1, a, b)),
                by(fact("greatest-lower-bound-uniqueness.eye", clause(2)))
              ),
              proof(
                goal(lowerBoundOf(g2, a, b)),
                by(rule("greatest-lower-bound-uniqueness.eye", clause(4))),
                bindings([binding("?m", g2), binding("?a", a), binding("?b", b)]),
                uses([
                  proof(
                    goal(glbOf(g2, a, b)),
                    by(fact("greatest-lower-bound-uniqueness.eye", clause(3)))
                  )
                ])
              )
            ])
          ),
          proof(
            goal(leq(g1, g2)),
            by(rule("greatest-lower-bound-uniqueness.eye", clause(5))),
            bindings([binding("?l", g1), binding("?m", g2), binding("?a", a), binding("?b", b)]),
            uses([
              proof(
                goal(glbOf(g2, a, b)),
                by(fact("greatest-lower-bound-uniqueness.eye", clause(3)))
              ),
              proof(
                goal(lowerBoundOf(g1, a, b)),
                by(rule("greatest-lower-bound-uniqueness.eye", clause(4))),
                bindings([binding("?m", g1), binding("?a", a), binding("?b", b)]),
                uses([
                  proof(
                    goal(glbOf(g1, a, b)),
                    by(fact("greatest-lower-bound-uniqueness.eye", clause(2)))
                  )
                ])
              )
            ])
          )
        ])
      ),
      proof(
        goal(neq(g2, g1)),
        by(builtin(neq, 2))
      )
    ])
  )
).

