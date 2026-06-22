type(joe, human).
why(
  type(joe, human),
  proof(
    goal(type(joe, human)),
    by(rule("animal.eye", clause(7))),
    uses([
      proof(
        goal(human(joe)),
        by(fact("animal.eye", clause(4)))
      )
    ])
  )
).

type(joe, animal).
why(
  type(joe, animal),
  proof(
    goal(type(joe, animal)),
    by(rule("animal.eye", clause(8))),
    uses([
      proof(
        goal(animal(joe)),
        by(rule("animal.eye", clause(6))),
        bindings([binding("?x", joe)]),
        uses([
          proof(
            goal(human(joe)),
            by(fact("animal.eye", clause(4)))
          )
        ])
      )
    ])
  )
).

subclassOf(human, animal).
why(
  subclassOf(human, animal),
  proof(
    goal(subclassOf(human, animal)),
    by(rule("animal.eye", clause(9))),
    uses([
      proof(
        goal(animal(human)),
        by(fact("animal.eye", clause(5)))
      )
    ])
  )
).

succeeds(animalExample, true).
why(
  succeeds(animalExample, true),
  proof(
    goal(succeeds(animalExample, true)),
    by(rule("animal.eye", clause(10))),
    bindings([binding("__anon0", human)]),
    uses([
      proof(
        goal(animal(human)),
        by(fact("animal.eye", clause(5)))
      )
    ])
  )
).

