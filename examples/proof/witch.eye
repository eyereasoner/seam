witch(girl).
why(
  witch(girl),
  proof(
    goal(witch(girl)),
    by(rule("witch.eye", clause(6))),
    bindings([binding("?x", girl)]),
    uses([
      proof(
        goal(burns(girl)),
        by(rule("witch.eye", clause(8))),
        bindings([binding("?x", girl)]),
        uses([
          proof(
            goal(madeOfWood(girl)),
            by(rule("witch.eye", clause(9))),
            bindings([binding("?x", girl)]),
            uses([
              proof(
                goal(floats(girl)),
                by(rule("witch.eye", clause(11))),
                bindings([binding("?y", girl), binding("?x", duck)]),
                uses([
                  proof(
                    goal(sameWeight(duck, girl)),
                    by(fact("witch.eye", clause(12)))
                  ),
                  proof(
                    goal(floats(duck)),
                    by(fact("witch.eye", clause(10)))
                  )
                ])
              )
            ])
          )
        ])
      ),
      proof(
        goal(woman(girl)),
        by(fact("witch.eye", clause(7)))
      )
    ])
  )
).

burns(duck).
why(
  burns(duck),
  proof(
    goal(burns(duck)),
    by(rule("witch.eye", clause(8))),
    bindings([binding("?x", duck)]),
    uses([
      proof(
        goal(madeOfWood(duck)),
        by(rule("witch.eye", clause(9))),
        bindings([binding("?x", duck)]),
        uses([
          proof(
            goal(floats(duck)),
            by(fact("witch.eye", clause(10)))
          )
        ])
      )
    ])
  )
).

burns(girl).
why(
  burns(girl),
  proof(
    goal(burns(girl)),
    by(rule("witch.eye", clause(8))),
    bindings([binding("?x", girl)]),
    uses([
      proof(
        goal(madeOfWood(girl)),
        by(rule("witch.eye", clause(9))),
        bindings([binding("?x", girl)]),
        uses([
          proof(
            goal(floats(girl)),
            by(rule("witch.eye", clause(11))),
            bindings([binding("?y", girl), binding("?x", duck)]),
            uses([
              proof(
                goal(sameWeight(duck, girl)),
                by(fact("witch.eye", clause(12)))
              ),
              proof(
                goal(floats(duck)),
                by(fact("witch.eye", clause(10)))
              )
            ])
          )
        ])
      )
    ])
  )
).

madeOfWood(duck).
why(
  madeOfWood(duck),
  proof(
    goal(madeOfWood(duck)),
    by(rule("witch.eye", clause(9))),
    bindings([binding("?x", duck)]),
    uses([
      proof(
        goal(floats(duck)),
        by(fact("witch.eye", clause(10)))
      )
    ])
  )
).

madeOfWood(girl).
why(
  madeOfWood(girl),
  proof(
    goal(madeOfWood(girl)),
    by(rule("witch.eye", clause(9))),
    bindings([binding("?x", girl)]),
    uses([
      proof(
        goal(floats(girl)),
        by(rule("witch.eye", clause(11))),
        bindings([binding("?y", girl), binding("?x", duck)]),
        uses([
          proof(
            goal(sameWeight(duck, girl)),
            by(fact("witch.eye", clause(12)))
          ),
          proof(
            goal(floats(duck)),
            by(fact("witch.eye", clause(10)))
          )
        ])
      )
    ])
  )
).

floats(girl).
why(
  floats(girl),
  proof(
    goal(floats(girl)),
    by(rule("witch.eye", clause(11))),
    bindings([binding("?y", girl), binding("?x", duck)]),
    uses([
      proof(
        goal(sameWeight(duck, girl)),
        by(fact("witch.eye", clause(12)))
      ),
      proof(
        goal(floats(duck)),
        by(fact("witch.eye", clause(10)))
      )
    ])
  )
).

is(witchExample, true).
why(
  is(witchExample, true),
  proof(
    goal(is(witchExample, true)),
    by(rule("witch.eye", clause(13))),
    uses([
      proof(
        goal(witch(girl)),
        by(rule("witch.eye", clause(6))),
        bindings([binding("?x", girl)]),
        uses([
          proof(
            goal(burns(girl)),
            by(rule("witch.eye", clause(8))),
            bindings([binding("?x", girl)]),
            uses([
              proof(
                goal(madeOfWood(girl)),
                by(rule("witch.eye", clause(9))),
                bindings([binding("?x", girl)]),
                uses([
                  proof(
                    goal(floats(girl)),
                    by(rule("witch.eye", clause(11))),
                    bindings([binding("?y", girl), binding("?x", duck)]),
                    uses([
                      proof(
                        goal(sameWeight(duck, girl)),
                        by(fact("witch.eye", clause(12)))
                      ),
                      proof(
                        goal(floats(duck)),
                        by(fact("witch.eye", clause(10)))
                      )
                    ])
                  )
                ])
              )
            ])
          ),
          proof(
            goal(woman(girl)),
            by(fact("witch.eye", clause(7)))
          )
        ])
      )
    ])
  )
).

