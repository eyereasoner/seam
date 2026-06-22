mustHave(alice, dogLicense).
why(
  mustHave(alice, dogLicense),
  proof(
    goal(mustHave(alice, dogLicense)),
    by(rule("dog.eye", clause(10))),
    bindings([binding("?subject", alice), binding("?count", 5)]),
    uses([
      proof(
        goal(dogCount(alice, 5)),
        by(rule("dog.eye", clause(9))),
        bindings([binding("?subject", alice), binding("?count", 5), binding("?_any", dog1)]),
        uses([
          proof(
            goal(hasDog(alice, dog1)),
            by(fact("dog.eye", clause(2)))
          ),
          proof(
            goal(countall(hasDog(alice, ?_dog), 5)),
            by(builtin(countall, 2))
          )
        ])
      ),
      proof(
        goal(gt(5, 4)),
        by(builtin(gt, 2))
      )
    ])
  )
).

