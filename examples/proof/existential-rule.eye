is(socrates, sk_0).
why(
  is(socrates, sk_0),
  proof(
    goal(is(socrates, sk_0)),
    by(rule("existential-rule.eye", clause(6))),
    bindings([binding("?person", socrates), binding("?witness", sk_0)]),
    uses([
      proof(
        goal(type(socrates, human)),
        by(fact("existential-rule.eye", clause(2)))
      ),
      proof(
        goal(witness(socrates, sk_0)),
        by(fact("existential-rule.eye", clause(4)))
      )
    ])
  )
).

is(plato, sk_1).
why(
  is(plato, sk_1),
  proof(
    goal(is(plato, sk_1)),
    by(rule("existential-rule.eye", clause(6))),
    bindings([binding("?person", plato), binding("?witness", sk_1)]),
    uses([
      proof(
        goal(type(plato, human)),
        by(fact("existential-rule.eye", clause(3)))
      ),
      proof(
        goal(witness(plato, sk_1)),
        by(fact("existential-rule.eye", clause(5)))
      )
    ])
  )
).

