isIndeedMoreInterestingThan(5, 3).
why(
  isIndeedMoreInterestingThan(5, 3),
  proof(
    goal(isIndeedMoreInterestingThan(5, 3)),
    by(rule("backward.eye", clause(3))),
    uses([
      proof(
        goal(moreInterestingThan(5, 3)),
        by(rule("backward.eye", clause(2))),
        bindings([binding("?x", 5), binding("?y", 3)]),
        uses([
          proof(
            goal(gt(5, 3)),
            by(builtin(gt, 2))
          )
        ])
      )
    ])
  )
).

