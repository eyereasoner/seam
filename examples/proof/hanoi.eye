answer(3, [[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]]).
why(
  answer(3, [[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]]),
  proof(
    goal(answer(3, [[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]])),
    by(rule("hanoi.eye", clause(5))),
    bindings([binding("?moves", [[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]])]),
    uses([
      proof(
        goal(hanoi(3, left, right, center, [[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]])),
        by(rule("hanoi.eye", clause(4))),
        bindings([binding("?n", 3), binding("?from", left), binding("?to", right), binding("?via", center), binding("?moves", [[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]]), binding("?n1", 2), binding("?before", [[left, right], [left, center], [right, center]]), binding("?after", [[center, left], [center, right], [left, right]])]),
        uses([
          proof(
            goal(gt(3, 0)),
            by(builtin(gt, 2))
          ),
          proof(
            goal(sub(3, 1, 2)),
            by(builtin(sub, 3))
          ),
          proof(
            goal(hanoi(2, left, center, right, [[left, right], [left, center], [right, center]])),
            by(rule("hanoi.eye", clause(4))),
            bindings([binding("?n", 2), binding("?from", left), binding("?to", center), binding("?via", right), binding("?moves", [[left, right], [left, center], [right, center]]), binding("?n1", 1), binding("?before", [[left, right]]), binding("?after", [[right, center]])]),
            uses([
              proof(
                goal(gt(2, 0)),
                by(builtin(gt, 2))
              ),
              proof(
                goal(sub(2, 1, 1)),
                by(builtin(sub, 3))
              ),
              proof(
                goal(hanoi(1, left, right, center, [[left, right]])),
                by(rule("hanoi.eye", clause(4))),
                bindings([binding("?n", 1), binding("?from", left), binding("?to", right), binding("?via", center), binding("?moves", [[left, right]]), binding("?n1", 0), binding("?before", []), binding("?after", [])]),
                uses([
                  proof(
                    goal(gt(1, 0)),
                    by(builtin(gt, 2))
                  ),
                  proof(
                    goal(sub(1, 1, 0)),
                    by(builtin(sub, 3))
                  ),
                  proof(
                    goal(hanoi(0, left, center, right, [])),
                    by(fact("hanoi.eye", clause(3))),
                    bindings([binding("?_from", left), binding("?_to", center), binding("?_via", right)])
                  ),
                  proof(
                    goal(hanoi(0, center, right, left, [])),
                    by(fact("hanoi.eye", clause(3))),
                    bindings([binding("?_from", center), binding("?_to", right), binding("?_via", left)])
                  ),
                  proof(
                    goal(append([], [[left, right]], [[left, right]])),
                    by(builtin(append, 3))
                  )
                ])
              ),
              proof(
                goal(hanoi(1, right, center, left, [[right, center]])),
                by(rule("hanoi.eye", clause(4))),
                bindings([binding("?n", 1), binding("?from", right), binding("?to", center), binding("?via", left), binding("?moves", [[right, center]]), binding("?n1", 0), binding("?before", []), binding("?after", [])]),
                uses([
                  proof(
                    goal(gt(1, 0)),
                    by(builtin(gt, 2))
                  ),
                  proof(
                    goal(sub(1, 1, 0)),
                    by(builtin(sub, 3))
                  ),
                  proof(
                    goal(hanoi(0, right, left, center, [])),
                    by(fact("hanoi.eye", clause(3))),
                    bindings([binding("?_from", right), binding("?_to", left), binding("?_via", center)])
                  ),
                  proof(
                    goal(hanoi(0, left, center, right, [])),
                    by(fact("hanoi.eye", clause(3))),
                    bindings([binding("?_from", left), binding("?_to", center), binding("?_via", right)])
                  ),
                  proof(
                    goal(append([], [[right, center]], [[right, center]])),
                    by(builtin(append, 3))
                  )
                ])
              ),
              proof(
                goal(append([[left, right]], [[left, center], [right, center]], [[left, right], [left, center], [right, center]])),
                by(builtin(append, 3))
              )
            ])
          ),
          proof(
            goal(hanoi(2, center, right, left, [[center, left], [center, right], [left, right]])),
            by(rule("hanoi.eye", clause(4))),
            bindings([binding("?n", 2), binding("?from", center), binding("?to", right), binding("?via", left), binding("?moves", [[center, left], [center, right], [left, right]]), binding("?n1", 1), binding("?before", [[center, left]]), binding("?after", [[left, right]])]),
            uses([
              proof(
                goal(gt(2, 0)),
                by(builtin(gt, 2))
              ),
              proof(
                goal(sub(2, 1, 1)),
                by(builtin(sub, 3))
              ),
              proof(
                goal(hanoi(1, center, left, right, [[center, left]])),
                by(rule("hanoi.eye", clause(4))),
                bindings([binding("?n", 1), binding("?from", center), binding("?to", left), binding("?via", right), binding("?moves", [[center, left]]), binding("?n1", 0), binding("?before", []), binding("?after", [])]),
                uses([
                  proof(
                    goal(gt(1, 0)),
                    by(builtin(gt, 2))
                  ),
                  proof(
                    goal(sub(1, 1, 0)),
                    by(builtin(sub, 3))
                  ),
                  proof(
                    goal(hanoi(0, center, right, left, [])),
                    by(fact("hanoi.eye", clause(3))),
                    bindings([binding("?_from", center), binding("?_to", right), binding("?_via", left)])
                  ),
                  proof(
                    goal(hanoi(0, right, left, center, [])),
                    by(fact("hanoi.eye", clause(3))),
                    bindings([binding("?_from", right), binding("?_to", left), binding("?_via", center)])
                  ),
                  proof(
                    goal(append([], [[center, left]], [[center, left]])),
                    by(builtin(append, 3))
                  )
                ])
              ),
              proof(
                goal(hanoi(1, left, right, center, [[left, right]])),
                by(rule("hanoi.eye", clause(4))),
                bindings([binding("?n", 1), binding("?from", left), binding("?to", right), binding("?via", center), binding("?moves", [[left, right]]), binding("?n1", 0), binding("?before", []), binding("?after", [])]),
                uses([
                  proof(
                    goal(gt(1, 0)),
                    by(builtin(gt, 2))
                  ),
                  proof(
                    goal(sub(1, 1, 0)),
                    by(builtin(sub, 3))
                  ),
                  proof(
                    goal(hanoi(0, left, center, right, [])),
                    by(fact("hanoi.eye", clause(3))),
                    bindings([binding("?_from", left), binding("?_to", center), binding("?_via", right)])
                  ),
                  proof(
                    goal(hanoi(0, center, right, left, [])),
                    by(fact("hanoi.eye", clause(3))),
                    bindings([binding("?_from", center), binding("?_to", right), binding("?_via", left)])
                  ),
                  proof(
                    goal(append([], [[left, right]], [[left, right]])),
                    by(builtin(append, 3))
                  )
                ])
              ),
              proof(
                goal(append([[center, left]], [[center, right], [left, right]], [[center, left], [center, right], [left, right]])),
                by(builtin(append, 3))
              )
            ])
          ),
          proof(
            goal(append([[left, right], [left, center], [right, center]], [[left, right], [center, left], [center, right], [left, right]], [[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]])),
            by(builtin(append, 3))
          )
        ])
      )
    ])
  )
).

