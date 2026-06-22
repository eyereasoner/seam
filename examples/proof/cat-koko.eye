type(sk_0, cat).
why(
  type(sk_0, cat),
  proof(
    goal(type(sk_0, cat)),
    by(rule("cat-koko.eye", clause(6))),
    bindings([binding("?x", sk_0)]),
    uses([
      proof(
        goal(animal(koko)),
        by(fact("cat-koko.eye", clause(3)))
      ),
      proof(
        goal(witness(cat, sk_0)),
        by(fact("cat-koko.eye", clause(4)))
      )
    ])
  )
).

type(sk_1, british_short_hair).
why(
  type(sk_1, british_short_hair),
  proof(
    goal(type(sk_1, british_short_hair)),
    by(rule("cat-koko.eye", clause(7))),
    bindings([binding("?x", sk_1)]),
    uses([
      proof(
        goal(animal(koko)),
        by(fact("cat-koko.eye", clause(3)))
      ),
      proof(
        goal(witness(british_short_hair, sk_1)),
        by(fact("cat-koko.eye", clause(5)))
      )
    ])
  )
).

is(test, true).
why(
  is(test, true),
  proof(
    goal(is(test, true)),
    by(rule("cat-koko.eye", clause(8))),
    bindings([binding("?x", sk_0), binding("?y", sk_1)]),
    uses([
      proof(
        goal(type(sk_0, cat)),
        by(rule("cat-koko.eye", clause(6))),
        bindings([binding("?x", sk_0)]),
        uses([
          proof(
            goal(animal(koko)),
            by(fact("cat-koko.eye", clause(3)))
          ),
          proof(
            goal(witness(cat, sk_0)),
            by(fact("cat-koko.eye", clause(4)))
          )
        ])
      ),
      proof(
        goal(type(sk_1, british_short_hair)),
        by(rule("cat-koko.eye", clause(7))),
        bindings([binding("?x", sk_1)]),
        uses([
          proof(
            goal(animal(koko)),
            by(fact("cat-koko.eye", clause(3)))
          ),
          proof(
            goal(witness(british_short_hair, sk_1)),
            by(fact("cat-koko.eye", clause(5)))
          )
        ])
      ),
      proof(
        goal(neq(sk_0, sk_1)),
        by(builtin(neq, 2))
      )
    ])
  )
).

