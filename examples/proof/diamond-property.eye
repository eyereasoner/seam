holdsFor(diamondProperty, r).
why(
  holdsFor(diamondProperty, r),
  proof(
    goal(holdsFor(diamondProperty, r)),
    by(rule("diamond-property.eye", clause(17))),
    bindings([binding("?rel", r)]),
    uses([
      proof(
        goal(diamond(r, a, b, c, d)),
        by(rule("diamond-property.eye", clause(14))),
        bindings([binding("?rel", r), binding("?a", a), binding("?b", b), binding("?c", c), binding("?d", d)]),
        uses([
          proof(
            goal(step(r, a, b)),
            by(rule("diamond-property.eye", clause(15))),
            bindings([binding("?x", a), binding("?y", b)]),
            uses([
              proof(
                goal(r(a, b)),
                by(fact("diamond-property.eye", clause(8)))
              )
            ])
          ),
          proof(
            goal(step(r, a, c)),
            by(rule("diamond-property.eye", clause(15))),
            bindings([binding("?x", a), binding("?y", c)]),
            uses([
              proof(
                goal(r(a, c)),
                by(fact("diamond-property.eye", clause(9)))
              )
            ])
          ),
          proof(
            goal(step(r, b, d)),
            by(rule("diamond-property.eye", clause(15))),
            bindings([binding("?x", b), binding("?y", d)]),
            uses([
              proof(
                goal(r(b, d)),
                by(fact("diamond-property.eye", clause(10)))
              )
            ])
          ),
          proof(
            goal(step(r, c, d)),
            by(rule("diamond-property.eye", clause(15))),
            bindings([binding("?x", c), binding("?y", d)]),
            uses([
              proof(
                goal(r(c, d)),
                by(fact("diamond-property.eye", clause(11)))
              )
            ])
          )
        ])
      )
    ])
  )
).

holdsFor(diamondProperty, re).
why(
  holdsFor(diamondProperty, re),
  proof(
    goal(holdsFor(diamondProperty, re)),
    by(rule("diamond-property.eye", clause(17))),
    bindings([binding("?rel", re)]),
    uses([
      proof(
        goal(diamond(re, a, b, c, d)),
        by(rule("diamond-property.eye", clause(14))),
        bindings([binding("?rel", re), binding("?a", a), binding("?b", b), binding("?c", c), binding("?d", d)]),
        uses([
          proof(
            goal(step(re, a, b)),
            by(rule("diamond-property.eye", clause(16))),
            bindings([binding("?x", a), binding("?y", b)]),
            uses([
              proof(
                goal(re(a, b)),
                by(rule("diamond-property.eye", clause(13))),
                bindings([binding("?x", a), binding("?y", b)]),
                uses([
                  proof(
                    goal(r(a, b)),
                    by(fact("diamond-property.eye", clause(8)))
                  )
                ])
              )
            ])
          ),
          proof(
            goal(step(re, a, c)),
            by(rule("diamond-property.eye", clause(16))),
            bindings([binding("?x", a), binding("?y", c)]),
            uses([
              proof(
                goal(re(a, c)),
                by(rule("diamond-property.eye", clause(13))),
                bindings([binding("?x", a), binding("?y", c)]),
                uses([
                  proof(
                    goal(r(a, c)),
                    by(fact("diamond-property.eye", clause(9)))
                  )
                ])
              )
            ])
          ),
          proof(
            goal(step(re, b, d)),
            by(rule("diamond-property.eye", clause(16))),
            bindings([binding("?x", b), binding("?y", d)]),
            uses([
              proof(
                goal(re(b, d)),
                by(rule("diamond-property.eye", clause(13))),
                bindings([binding("?x", b), binding("?y", d)]),
                uses([
                  proof(
                    goal(r(b, d)),
                    by(fact("diamond-property.eye", clause(10)))
                  )
                ])
              )
            ])
          ),
          proof(
            goal(step(re, c, d)),
            by(rule("diamond-property.eye", clause(16))),
            bindings([binding("?x", c), binding("?y", d)]),
            uses([
              proof(
                goal(re(c, d)),
                by(rule("diamond-property.eye", clause(13))),
                bindings([binding("?x", c), binding("?y", d)]),
                uses([
                  proof(
                    goal(r(c, d)),
                    by(fact("diamond-property.eye", clause(11)))
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

commonSuccessor(diamondProperty, d).
why(
  commonSuccessor(diamondProperty, d),
  proof(
    goal(commonSuccessor(diamondProperty, d)),
    by(rule("diamond-property.eye", clause(18))),
    bindings([binding("?d", d)]),
    uses([
      proof(
        goal(diamond(r, a, b, c, d)),
        by(rule("diamond-property.eye", clause(14))),
        bindings([binding("?rel", r), binding("?a", a), binding("?b", b), binding("?c", c), binding("?d", d)]),
        uses([
          proof(
            goal(step(r, a, b)),
            by(rule("diamond-property.eye", clause(15))),
            bindings([binding("?x", a), binding("?y", b)]),
            uses([
              proof(
                goal(r(a, b)),
                by(fact("diamond-property.eye", clause(8)))
              )
            ])
          ),
          proof(
            goal(step(r, a, c)),
            by(rule("diamond-property.eye", clause(15))),
            bindings([binding("?x", a), binding("?y", c)]),
            uses([
              proof(
                goal(r(a, c)),
                by(fact("diamond-property.eye", clause(9)))
              )
            ])
          ),
          proof(
            goal(step(r, b, d)),
            by(rule("diamond-property.eye", clause(15))),
            bindings([binding("?x", b), binding("?y", d)]),
            uses([
              proof(
                goal(r(b, d)),
                by(fact("diamond-property.eye", clause(10)))
              )
            ])
          ),
          proof(
            goal(step(r, c, d)),
            by(rule("diamond-property.eye", clause(15))),
            bindings([binding("?x", c), binding("?y", d)]),
            uses([
              proof(
                goal(r(c, d)),
                by(fact("diamond-property.eye", clause(11)))
              )
            ])
          )
        ])
      )
    ])
  )
).

preservedUnderReflexiveClosure(diamondProperty, true).
why(
  preservedUnderReflexiveClosure(diamondProperty, true),
  proof(
    goal(preservedUnderReflexiveClosure(diamondProperty, true)),
    by(rule("diamond-property.eye", clause(19))),
    uses([
      proof(
        goal(diamond(re, a, b, c, d)),
        by(rule("diamond-property.eye", clause(14))),
        bindings([binding("?rel", re), binding("?a", a), binding("?b", b), binding("?c", c), binding("?d", d)]),
        uses([
          proof(
            goal(step(re, a, b)),
            by(rule("diamond-property.eye", clause(16))),
            bindings([binding("?x", a), binding("?y", b)]),
            uses([
              proof(
                goal(re(a, b)),
                by(rule("diamond-property.eye", clause(13))),
                bindings([binding("?x", a), binding("?y", b)]),
                uses([
                  proof(
                    goal(r(a, b)),
                    by(fact("diamond-property.eye", clause(8)))
                  )
                ])
              )
            ])
          ),
          proof(
            goal(step(re, a, c)),
            by(rule("diamond-property.eye", clause(16))),
            bindings([binding("?x", a), binding("?y", c)]),
            uses([
              proof(
                goal(re(a, c)),
                by(rule("diamond-property.eye", clause(13))),
                bindings([binding("?x", a), binding("?y", c)]),
                uses([
                  proof(
                    goal(r(a, c)),
                    by(fact("diamond-property.eye", clause(9)))
                  )
                ])
              )
            ])
          ),
          proof(
            goal(step(re, b, d)),
            by(rule("diamond-property.eye", clause(16))),
            bindings([binding("?x", b), binding("?y", d)]),
            uses([
              proof(
                goal(re(b, d)),
                by(rule("diamond-property.eye", clause(13))),
                bindings([binding("?x", b), binding("?y", d)]),
                uses([
                  proof(
                    goal(r(b, d)),
                    by(fact("diamond-property.eye", clause(10)))
                  )
                ])
              )
            ])
          ),
          proof(
            goal(step(re, c, d)),
            by(rule("diamond-property.eye", clause(16))),
            bindings([binding("?x", c), binding("?y", d)]),
            uses([
              proof(
                goal(re(c, d)),
                by(rule("diamond-property.eye", clause(13))),
                bindings([binding("?x", c), binding("?y", d)]),
                uses([
                  proof(
                    goal(r(c, d)),
                    by(fact("diamond-property.eye", clause(11)))
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

