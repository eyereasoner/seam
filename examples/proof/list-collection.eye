append(letters, [a, b, c]).
why(
  append(letters, [a, b, c]),
  proof(
    goal(append(letters, [a, b, c])),
    by(rule("list-collection.eye", clause(10))),
    bindings([binding("?extended", [a, b, c]), binding("?list", [a, b])]),
    uses([
      proof(
        goal(collection(letters, [a, b])),
        by(fact("list-collection.eye", clause(7)))
      ),
      proof(
        goal(append([a, b], [c], [a, b, c])),
        by(builtin(append, 3))
      )
    ])
  )
).

head(letters, a).
why(
  head(letters, a),
  proof(
    goal(head(letters, a)),
    by(rule("list-collection.eye", clause(11))),
    bindings([binding("?head", a), binding("?_tail", [b])]),
    uses([
      proof(
        goal(collection(letters, [a, b])),
        by(fact("list-collection.eye", clause(7)))
      )
    ])
  )
).

tail(letters, [b]).
why(
  tail(letters, [b]),
  proof(
    goal(tail(letters, [b])),
    by(rule("list-collection.eye", clause(12))),
    bindings([binding("?tail", [b]), binding("?_head", a)]),
    uses([
      proof(
        goal(collection(letters, [a, b])),
        by(fact("list-collection.eye", clause(7)))
      )
    ])
  )
).

