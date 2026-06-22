sameClassBecauseOfSharedMember(a, b, a).
why(
  sameClassBecauseOfSharedMember(a, b, a),
  proof(
    goal(sameClassBecauseOfSharedMember(a, b, a)),
    by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(7))),
    bindings([binding("?x", a), binding("?y", b), binding("?z", a)]),
    uses([
      proof(
        goal(inClassOf(a, a)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", a), binding("?x", a), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          ),
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          )
        ])
      ),
      proof(
        goal(inClassOf(a, b)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", a), binding("?x", b), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          ),
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          )
        ])
      ),
      proof(
        goal(sameClass(a, b)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(6))),
        bindings([binding("?x", a), binding("?y", b), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          ),
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          )
        ])
      ),
      proof(
        goal(neq(a, b)),
        by(builtin(neq, 2))
      )
    ])
  )
).

sameClassBecauseOfSharedMember(a, c, a).
why(
  sameClassBecauseOfSharedMember(a, c, a),
  proof(
    goal(sameClassBecauseOfSharedMember(a, c, a)),
    by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(7))),
    bindings([binding("?x", a), binding("?y", c), binding("?z", a)]),
    uses([
      proof(
        goal(inClassOf(a, a)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", a), binding("?x", a), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          ),
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          )
        ])
      ),
      proof(
        goal(inClassOf(a, c)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", a), binding("?x", c), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          ),
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          )
        ])
      ),
      proof(
        goal(sameClass(a, c)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(6))),
        bindings([binding("?x", a), binding("?y", c), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          ),
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          )
        ])
      ),
      proof(
        goal(neq(a, c)),
        by(builtin(neq, 2))
      )
    ])
  )
).

sameClassBecauseOfSharedMember(b, a, a).
why(
  sameClassBecauseOfSharedMember(b, a, a),
  proof(
    goal(sameClassBecauseOfSharedMember(b, a, a)),
    by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(7))),
    bindings([binding("?x", b), binding("?y", a), binding("?z", a)]),
    uses([
      proof(
        goal(inClassOf(a, b)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", a), binding("?x", b), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          ),
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          )
        ])
      ),
      proof(
        goal(inClassOf(a, a)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", a), binding("?x", a), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          ),
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          )
        ])
      ),
      proof(
        goal(sameClass(b, a)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(6))),
        bindings([binding("?x", b), binding("?y", a), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          ),
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          )
        ])
      ),
      proof(
        goal(neq(b, a)),
        by(builtin(neq, 2))
      )
    ])
  )
).

sameClassBecauseOfSharedMember(b, c, a).
why(
  sameClassBecauseOfSharedMember(b, c, a),
  proof(
    goal(sameClassBecauseOfSharedMember(b, c, a)),
    by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(7))),
    bindings([binding("?x", b), binding("?y", c), binding("?z", a)]),
    uses([
      proof(
        goal(inClassOf(a, b)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", a), binding("?x", b), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          ),
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          )
        ])
      ),
      proof(
        goal(inClassOf(a, c)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", a), binding("?x", c), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          ),
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          )
        ])
      ),
      proof(
        goal(sameClass(b, c)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(6))),
        bindings([binding("?x", b), binding("?y", c), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          ),
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          )
        ])
      ),
      proof(
        goal(neq(b, c)),
        by(builtin(neq, 2))
      )
    ])
  )
).

sameClassBecauseOfSharedMember(c, a, a).
why(
  sameClassBecauseOfSharedMember(c, a, a),
  proof(
    goal(sameClassBecauseOfSharedMember(c, a, a)),
    by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(7))),
    bindings([binding("?x", c), binding("?y", a), binding("?z", a)]),
    uses([
      proof(
        goal(inClassOf(a, c)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", a), binding("?x", c), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          ),
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          )
        ])
      ),
      proof(
        goal(inClassOf(a, a)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", a), binding("?x", a), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          ),
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          )
        ])
      ),
      proof(
        goal(sameClass(c, a)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(6))),
        bindings([binding("?x", c), binding("?y", a), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          ),
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          )
        ])
      ),
      proof(
        goal(neq(c, a)),
        by(builtin(neq, 2))
      )
    ])
  )
).

sameClassBecauseOfSharedMember(c, b, a).
why(
  sameClassBecauseOfSharedMember(c, b, a),
  proof(
    goal(sameClassBecauseOfSharedMember(c, b, a)),
    by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(7))),
    bindings([binding("?x", c), binding("?y", b), binding("?z", a)]),
    uses([
      proof(
        goal(inClassOf(a, c)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", a), binding("?x", c), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          ),
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          )
        ])
      ),
      proof(
        goal(inClassOf(a, b)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", a), binding("?x", b), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          ),
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          )
        ])
      ),
      proof(
        goal(sameClass(c, b)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(6))),
        bindings([binding("?x", c), binding("?y", b), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          ),
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          )
        ])
      ),
      proof(
        goal(neq(c, b)),
        by(builtin(neq, 2))
      )
    ])
  )
).

sameClassBecauseOfSharedMember(a, b, b).
why(
  sameClassBecauseOfSharedMember(a, b, b),
  proof(
    goal(sameClassBecauseOfSharedMember(a, b, b)),
    by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(7))),
    bindings([binding("?x", a), binding("?y", b), binding("?z", b)]),
    uses([
      proof(
        goal(inClassOf(b, a)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", b), binding("?x", a), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          ),
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          )
        ])
      ),
      proof(
        goal(inClassOf(b, b)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", b), binding("?x", b), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          ),
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          )
        ])
      ),
      proof(
        goal(sameClass(a, b)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(6))),
        bindings([binding("?x", a), binding("?y", b), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          ),
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          )
        ])
      ),
      proof(
        goal(neq(a, b)),
        by(builtin(neq, 2))
      )
    ])
  )
).

sameClassBecauseOfSharedMember(a, c, b).
why(
  sameClassBecauseOfSharedMember(a, c, b),
  proof(
    goal(sameClassBecauseOfSharedMember(a, c, b)),
    by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(7))),
    bindings([binding("?x", a), binding("?y", c), binding("?z", b)]),
    uses([
      proof(
        goal(inClassOf(b, a)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", b), binding("?x", a), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          ),
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          )
        ])
      ),
      proof(
        goal(inClassOf(b, c)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", b), binding("?x", c), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          ),
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          )
        ])
      ),
      proof(
        goal(sameClass(a, c)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(6))),
        bindings([binding("?x", a), binding("?y", c), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          ),
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          )
        ])
      ),
      proof(
        goal(neq(a, c)),
        by(builtin(neq, 2))
      )
    ])
  )
).

sameClassBecauseOfSharedMember(b, a, b).
why(
  sameClassBecauseOfSharedMember(b, a, b),
  proof(
    goal(sameClassBecauseOfSharedMember(b, a, b)),
    by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(7))),
    bindings([binding("?x", b), binding("?y", a), binding("?z", b)]),
    uses([
      proof(
        goal(inClassOf(b, b)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", b), binding("?x", b), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          ),
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          )
        ])
      ),
      proof(
        goal(inClassOf(b, a)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", b), binding("?x", a), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          ),
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          )
        ])
      ),
      proof(
        goal(sameClass(b, a)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(6))),
        bindings([binding("?x", b), binding("?y", a), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          ),
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          )
        ])
      ),
      proof(
        goal(neq(b, a)),
        by(builtin(neq, 2))
      )
    ])
  )
).

sameClassBecauseOfSharedMember(b, c, b).
why(
  sameClassBecauseOfSharedMember(b, c, b),
  proof(
    goal(sameClassBecauseOfSharedMember(b, c, b)),
    by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(7))),
    bindings([binding("?x", b), binding("?y", c), binding("?z", b)]),
    uses([
      proof(
        goal(inClassOf(b, b)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", b), binding("?x", b), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          ),
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          )
        ])
      ),
      proof(
        goal(inClassOf(b, c)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", b), binding("?x", c), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          ),
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          )
        ])
      ),
      proof(
        goal(sameClass(b, c)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(6))),
        bindings([binding("?x", b), binding("?y", c), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          ),
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          )
        ])
      ),
      proof(
        goal(neq(b, c)),
        by(builtin(neq, 2))
      )
    ])
  )
).

sameClassBecauseOfSharedMember(c, a, b).
why(
  sameClassBecauseOfSharedMember(c, a, b),
  proof(
    goal(sameClassBecauseOfSharedMember(c, a, b)),
    by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(7))),
    bindings([binding("?x", c), binding("?y", a), binding("?z", b)]),
    uses([
      proof(
        goal(inClassOf(b, c)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", b), binding("?x", c), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          ),
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          )
        ])
      ),
      proof(
        goal(inClassOf(b, a)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", b), binding("?x", a), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          ),
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          )
        ])
      ),
      proof(
        goal(sameClass(c, a)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(6))),
        bindings([binding("?x", c), binding("?y", a), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          ),
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          )
        ])
      ),
      proof(
        goal(neq(c, a)),
        by(builtin(neq, 2))
      )
    ])
  )
).

sameClassBecauseOfSharedMember(c, b, b).
why(
  sameClassBecauseOfSharedMember(c, b, b),
  proof(
    goal(sameClassBecauseOfSharedMember(c, b, b)),
    by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(7))),
    bindings([binding("?x", c), binding("?y", b), binding("?z", b)]),
    uses([
      proof(
        goal(inClassOf(b, c)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", b), binding("?x", c), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          ),
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          )
        ])
      ),
      proof(
        goal(inClassOf(b, b)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", b), binding("?x", b), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          ),
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          )
        ])
      ),
      proof(
        goal(sameClass(c, b)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(6))),
        bindings([binding("?x", c), binding("?y", b), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          ),
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          )
        ])
      ),
      proof(
        goal(neq(c, b)),
        by(builtin(neq, 2))
      )
    ])
  )
).

sameClassBecauseOfSharedMember(a, b, c).
why(
  sameClassBecauseOfSharedMember(a, b, c),
  proof(
    goal(sameClassBecauseOfSharedMember(a, b, c)),
    by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(7))),
    bindings([binding("?x", a), binding("?y", b), binding("?z", c)]),
    uses([
      proof(
        goal(inClassOf(c, a)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", c), binding("?x", a), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          ),
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          )
        ])
      ),
      proof(
        goal(inClassOf(c, b)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", c), binding("?x", b), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          ),
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          )
        ])
      ),
      proof(
        goal(sameClass(a, b)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(6))),
        bindings([binding("?x", a), binding("?y", b), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          ),
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          )
        ])
      ),
      proof(
        goal(neq(a, b)),
        by(builtin(neq, 2))
      )
    ])
  )
).

sameClassBecauseOfSharedMember(a, c, c).
why(
  sameClassBecauseOfSharedMember(a, c, c),
  proof(
    goal(sameClassBecauseOfSharedMember(a, c, c)),
    by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(7))),
    bindings([binding("?x", a), binding("?y", c), binding("?z", c)]),
    uses([
      proof(
        goal(inClassOf(c, a)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", c), binding("?x", a), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          ),
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          )
        ])
      ),
      proof(
        goal(inClassOf(c, c)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", c), binding("?x", c), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          ),
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          )
        ])
      ),
      proof(
        goal(sameClass(a, c)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(6))),
        bindings([binding("?x", a), binding("?y", c), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          ),
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          )
        ])
      ),
      proof(
        goal(neq(a, c)),
        by(builtin(neq, 2))
      )
    ])
  )
).

sameClassBecauseOfSharedMember(b, a, c).
why(
  sameClassBecauseOfSharedMember(b, a, c),
  proof(
    goal(sameClassBecauseOfSharedMember(b, a, c)),
    by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(7))),
    bindings([binding("?x", b), binding("?y", a), binding("?z", c)]),
    uses([
      proof(
        goal(inClassOf(c, b)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", c), binding("?x", b), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          ),
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          )
        ])
      ),
      proof(
        goal(inClassOf(c, a)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", c), binding("?x", a), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          ),
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          )
        ])
      ),
      proof(
        goal(sameClass(b, a)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(6))),
        bindings([binding("?x", b), binding("?y", a), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          ),
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          )
        ])
      ),
      proof(
        goal(neq(b, a)),
        by(builtin(neq, 2))
      )
    ])
  )
).

sameClassBecauseOfSharedMember(b, c, c).
why(
  sameClassBecauseOfSharedMember(b, c, c),
  proof(
    goal(sameClassBecauseOfSharedMember(b, c, c)),
    by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(7))),
    bindings([binding("?x", b), binding("?y", c), binding("?z", c)]),
    uses([
      proof(
        goal(inClassOf(c, b)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", c), binding("?x", b), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          ),
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          )
        ])
      ),
      proof(
        goal(inClassOf(c, c)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", c), binding("?x", c), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          ),
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          )
        ])
      ),
      proof(
        goal(sameClass(b, c)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(6))),
        bindings([binding("?x", b), binding("?y", c), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          ),
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          )
        ])
      ),
      proof(
        goal(neq(b, c)),
        by(builtin(neq, 2))
      )
    ])
  )
).

sameClassBecauseOfSharedMember(c, a, c).
why(
  sameClassBecauseOfSharedMember(c, a, c),
  proof(
    goal(sameClassBecauseOfSharedMember(c, a, c)),
    by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(7))),
    bindings([binding("?x", c), binding("?y", a), binding("?z", c)]),
    uses([
      proof(
        goal(inClassOf(c, c)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", c), binding("?x", c), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          ),
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          )
        ])
      ),
      proof(
        goal(inClassOf(c, a)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", c), binding("?x", a), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          ),
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          )
        ])
      ),
      proof(
        goal(sameClass(c, a)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(6))),
        bindings([binding("?x", c), binding("?y", a), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          ),
          proof(
            goal(classMember(class_abc, a)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(2)))
          )
        ])
      ),
      proof(
        goal(neq(c, a)),
        by(builtin(neq, 2))
      )
    ])
  )
).

sameClassBecauseOfSharedMember(c, b, c).
why(
  sameClassBecauseOfSharedMember(c, b, c),
  proof(
    goal(sameClassBecauseOfSharedMember(c, b, c)),
    by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(7))),
    bindings([binding("?x", c), binding("?y", b), binding("?z", c)]),
    uses([
      proof(
        goal(inClassOf(c, c)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", c), binding("?x", c), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          ),
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          )
        ])
      ),
      proof(
        goal(inClassOf(c, b)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(5))),
        bindings([binding("?u", c), binding("?x", b), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          ),
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          )
        ])
      ),
      proof(
        goal(sameClass(c, b)),
        by(rule("equivalence-classes-overlap-implies-same-class.eye", clause(6))),
        bindings([binding("?x", c), binding("?y", b), binding("?class", class_abc)]),
        uses([
          proof(
            goal(classMember(class_abc, c)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(4)))
          ),
          proof(
            goal(classMember(class_abc, b)),
            by(fact("equivalence-classes-overlap-implies-same-class.eye", clause(3)))
          )
        ])
      ),
      proof(
        goal(neq(c, b)),
        by(builtin(neq, 2))
      )
    ])
  )
).

