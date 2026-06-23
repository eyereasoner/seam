is(socrates, human_witness(socrates)).
why(
  is(socrates, human_witness(socrates)),
  proof(
    goal(is(socrates, human_witness(socrates))),
    by(rule("existential-rule.eye", clause(4))),
    bindings([binding("?person", socrates)]),
    uses([
      proof(
        goal(type(socrates, human)),
        by(fact("existential-rule.eye", clause(2)))
      )
    ])
  )
).

is(plato, human_witness(plato)).
why(
  is(plato, human_witness(plato)),
  proof(
    goal(is(plato, human_witness(plato))),
    by(rule("existential-rule.eye", clause(4))),
    bindings([binding("?person", plato)]),
    uses([
      proof(
        goal(type(plato, human)),
        by(fact("existential-rule.eye", clause(3)))
      )
    ])
  )
).

