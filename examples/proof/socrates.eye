type(socrates, mortal).
why(
  type(socrates, mortal),
  proof(
    goal(type(socrates, mortal)),
    by(rule("socrates.eye", clause(4))),
    bindings([binding("?x", socrates)]),
    uses([
      proof(
        goal(type(socrates, man)),
        by(fact("socrates.eye", clause(3)))
      )
    ])
  )
).

is(test, true).
why(
  is(test, true),
  proof(
    goal(is(test, true)),
    by(rule("socrates.eye", clause(5))),
    uses([
      proof(
        goal(type(socrates, mortal)),
        by(rule("socrates.eye", clause(4))),
        bindings([binding("?x", socrates)]),
        uses([
          proof(
            goal(type(socrates, man)),
            by(fact("socrates.eye", clause(3)))
          )
        ])
      )
    ])
  )
).

