value(nativeMath, 1.0).
why(
  value(nativeMath, 1.0),
  proof(
    goal(value(nativeMath, 1.0)),
    by(rule("aliases-and-namespaces.eye", clause(5))),
    bindings([binding("?x", 1.0)]),
    uses([
      proof(
        goal(add(0.125, 0.875, 1.0)),
        by(builtin(add, 3))
      )
    ])
  )
).

ok(nativeCompare, true).
why(
  ok(nativeCompare, true),
  proof(
    goal(ok(nativeCompare, true)),
    by(rule("aliases-and-namespaces.eye", clause(6))),
    uses([
      proof(
        goal(lt(2, 3)),
        by(builtin(lt, 2))
      )
    ])
  )
).

ok(nativeString, true).
why(
  ok(nativeString, true),
  proof(
    goal(ok(nativeString, true)),
    by(rule("aliases-and-namespaces.eye", clause(7))),
    uses([
      proof(
        goal(matches("scoped retail insight", "retail|medical")),
        by(builtin(matches, 2))
      )
    ])
  )
).

tail(nativeList, [b, c]).
why(
  tail(nativeList, [b, c]),
  proof(
    goal(tail(nativeList, [b, c])),
    by(rule("aliases-and-namespaces.eye", clause(8))),
    bindings([binding("?tail", [b, c])]),
    uses([
      proof(
        goal(rest([a, b, c], [b, c])),
        by(builtin(rest, 2))
      )
    ])
  )
).

label(vocabularyExample, "vocabulary names are ordinary predicate names").
why(
  label(vocabularyExample, "vocabulary names are ordinary predicate names"),
  proof(
    goal(label(vocabularyExample, "vocabulary names are ordinary predicate names")),
    by(rule("aliases-and-namespaces.eye", clause(10))),
    bindings([binding("?text", "vocabulary names are ordinary predicate names")]),
    uses([
      proof(
        goal(example_label(vocabularyExample, "vocabulary names are ordinary predicate names")),
        by(fact("aliases-and-namespaces.eye", clause(9)))
      )
    ])
  )
).

