log_impliedBy(childOf(var(x), var(y)), parentOf(var(y), var(x))).
why(
  log_impliedBy(childOf(var(x), var(y)), parentOf(var(y), var(x))),
  proof(
    goal(log_impliedBy(childOf(var(x), var(y)), parentOf(var(y), var(x)))),
    by(rule("derived-backward-rule.eye", clause(6))),
    uses([
      proof(
        goal(invOf(parentOf, childOf)),
        by(fact("derived-backward-rule.eye", clause(4)))
      )
    ])
  )
).

childOf(bob, alice).
why(
  childOf(bob, alice),
  proof(
    goal(childOf(bob, alice)),
    by(rule("derived-backward-rule.eye", clause(7))),
    bindings([binding("?x", bob), binding("?y", alice)]),
    uses([
      proof(
        goal(log_impliedBy(childOf(var(x), var(y)), parentOf(var(y), var(x)))),
        by(rule("derived-backward-rule.eye", clause(6))),
        uses([
          proof(
            goal(invOf(parentOf, childOf)),
            by(fact("derived-backward-rule.eye", clause(4)))
          )
        ])
      ),
      proof(
        goal(parentOf(alice, bob)),
        by(fact("derived-backward-rule.eye", clause(5)))
      )
    ])
  )
).

hasParent(bob, alice).
why(
  hasParent(bob, alice),
  proof(
    goal(hasParent(bob, alice)),
    by(rule("derived-backward-rule.eye", clause(8))),
    bindings([binding("?x", bob), binding("?y", alice)]),
    uses([
      proof(
        goal(childOf(bob, alice)),
        by(rule("derived-backward-rule.eye", clause(7))),
        bindings([binding("?x", bob), binding("?y", alice)]),
        uses([
          proof(
            goal(log_impliedBy(childOf(var(x), var(y)), parentOf(var(y), var(x)))),
            by(rule("derived-backward-rule.eye", clause(6))),
            uses([
              proof(
                goal(invOf(parentOf, childOf)),
                by(fact("derived-backward-rule.eye", clause(4)))
              )
            ])
          ),
          proof(
            goal(parentOf(alice, bob)),
            by(fact("derived-backward-rule.eye", clause(5)))
          )
        ])
      )
    ])
  )
).

