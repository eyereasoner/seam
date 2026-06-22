name(a, "Alice").
why(
  name(a, "Alice"),
  proof(
    goal(name(a, "Alice")),
    by(rule("annotation.eye", clause(6))),
    bindings([binding("?s", a), binding("?o", "Alice"), binding("?_t", t), binding("?context", (name(a, "Alice"), statedBy(t, bob), recorded(t, "2021-07-07")))]),
    uses([
      proof(
        goal(annotation(t, (name(a, "Alice"), statedBy(t, bob), recorded(t, "2021-07-07")))),
        by(fact("annotation.eye", clause(5)))
      ),
      proof(
        goal(holds((name(a, "Alice"), statedBy(t, bob), recorded(t, "2021-07-07")), name(a, "Alice"))),
        by(builtin(holds, 2))
      )
    ])
  )
).

log_nameOf(t, name(a, "Alice")).
why(
  log_nameOf(t, name(a, "Alice")),
  proof(
    goal(log_nameOf(t, name(a, "Alice"))),
    by(rule("annotation.eye", clause(7))),
    bindings([binding("?t", t), binding("?s", a), binding("?o", "Alice"), binding("?context", (name(a, "Alice"), statedBy(t, bob), recorded(t, "2021-07-07")))]),
    uses([
      proof(
        goal(annotation(t, (name(a, "Alice"), statedBy(t, bob), recorded(t, "2021-07-07")))),
        by(fact("annotation.eye", clause(5)))
      ),
      proof(
        goal(holds((name(a, "Alice"), statedBy(t, bob), recorded(t, "2021-07-07")), name(a, "Alice"))),
        by(builtin(holds, 2))
      )
    ])
  )
).

statedBy(t, bob).
why(
  statedBy(t, bob),
  proof(
    goal(statedBy(t, bob)),
    by(rule("annotation.eye", clause(8))),
    bindings([binding("?s", t), binding("?o", bob), binding("?_t", t), binding("?context", (name(a, "Alice"), statedBy(t, bob), recorded(t, "2021-07-07")))]),
    uses([
      proof(
        goal(annotation(t, (name(a, "Alice"), statedBy(t, bob), recorded(t, "2021-07-07")))),
        by(fact("annotation.eye", clause(5)))
      ),
      proof(
        goal(holds((name(a, "Alice"), statedBy(t, bob), recorded(t, "2021-07-07")), statedBy(t, bob))),
        by(builtin(holds, 2))
      )
    ])
  )
).

recorded(t, "2021-07-07").
why(
  recorded(t, "2021-07-07"),
  proof(
    goal(recorded(t, "2021-07-07")),
    by(rule("annotation.eye", clause(9))),
    bindings([binding("?s", t), binding("?o", "2021-07-07"), binding("?_t", t), binding("?context", (name(a, "Alice"), statedBy(t, bob), recorded(t, "2021-07-07")))]),
    uses([
      proof(
        goal(annotation(t, (name(a, "Alice"), statedBy(t, bob), recorded(t, "2021-07-07")))),
        by(fact("annotation.eye", clause(5)))
      ),
      proof(
        goal(holds((name(a, "Alice"), statedBy(t, bob), recorded(t, "2021-07-07")), recorded(t, "2021-07-07"))),
        by(builtin(holds, 2))
      )
    ])
  )
).

