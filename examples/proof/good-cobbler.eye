is(test, is(joe, good(cobbler))).
why(
  is(test, is(joe, good(cobbler))),
  proof(
    goal(is(test, is(joe, good(cobbler)))),
    by(rule("good-cobbler.eye", clause(3))),
    bindings([binding("?x", joe), binding("?y", cobbler)]),
    uses([
      proof(
        goal(assertedIs(joe, good(cobbler))),
        by(fact("good-cobbler.eye", clause(2)))
      )
    ])
  )
).

