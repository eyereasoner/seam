ageAbove(patH, "P80Y").
why(
  ageAbove(patH, "P80Y"),
  proof(
    goal(ageAbove(patH, "P80Y")),
    by(rule("socket-age.eye", clause(11))),
    bindings([binding("?s", patH), binding("?a", "P80Y"), binding("?b", "1944-08-21"), binding("?d", "2026-05-30"), binding("?f", "P81Y9M9D")]),
    uses([
      proof(
        goal(birthDay(patH, "1944-08-21")),
        by(fact("socket-age.eye", clause(8)))
      ),
      proof(
        goal(duration(check, "P80Y")),
        by(fact("socket-age.eye", clause(9)))
      ),
      proof(
        goal(today("2026-05-30")),
        by(fact("socket-age.eye", clause(10)))
      ),
      proof(
        goal(difference("2026-05-30", "1944-08-21", "P81Y9M9D")),
        by(builtin(difference, 3))
      ),
      proof(
        goal(gt("P81Y9M9D", "P80Y")),
        by(builtin(gt, 2))
      )
    ])
  )
).

