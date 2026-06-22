sameInputByCompositeInjectivity(h, a, b).
why(
  sameInputByCompositeInjectivity(h, a, b),
  proof(
    goal(sameInputByCompositeInjectivity(h, a, b)),
    by(rule("composition-of-injective-functions-is-injective.eye", clause(20))),
    bindings([binding("?h", h), binding("?x", a), binding("?y", b), binding("?g", g), binding("?f", f), binding("?z", e)]),
    uses([
      proof(
        goal(compositeOf(h, g, f)),
        by(fact("composition-of-injective-functions-is-injective.eye", clause(17)))
      ),
      proof(
        goal(injective(g)),
        by(fact("composition-of-injective-functions-is-injective.eye", clause(16)))
      ),
      proof(
        goal(injective(f)),
        by(fact("composition-of-injective-functions-is-injective.eye", clause(15)))
      ),
      proof(
        goal(app(h, a, e)),
        by(rule("composition-of-injective-functions-is-injective.eye", clause(18))),
        bindings([binding("?h", h), binding("?x", a), binding("?z", e), binding("?g", g), binding("?f", f), binding("?y", c)]),
        uses([
          proof(
            goal(compositeOf(h, g, f)),
            by(fact("composition-of-injective-functions-is-injective.eye", clause(17)))
          ),
          proof(
            goal(app(f, a, c)),
            by(fact("composition-of-injective-functions-is-injective.eye", clause(11)))
          ),
          proof(
            goal(app(g, c, e)),
            by(fact("composition-of-injective-functions-is-injective.eye", clause(13)))
          )
        ])
      ),
      proof(
        goal(app(h, b, e)),
        by(rule("composition-of-injective-functions-is-injective.eye", clause(18))),
        bindings([binding("?h", h), binding("?x", b), binding("?z", e), binding("?g", g), binding("?f", f), binding("?y", d)]),
        uses([
          proof(
            goal(compositeOf(h, g, f)),
            by(fact("composition-of-injective-functions-is-injective.eye", clause(17)))
          ),
          proof(
            goal(app(f, b, d)),
            by(fact("composition-of-injective-functions-is-injective.eye", clause(12)))
          ),
          proof(
            goal(app(g, d, e)),
            by(fact("composition-of-injective-functions-is-injective.eye", clause(14)))
          )
        ])
      ),
      proof(
        goal(sameTerm(a, b)),
        by(rule("composition-of-injective-functions-is-injective.eye", clause(10))),
        bindings([binding("?y", a), binding("?x", b)]),
        uses([
          proof(
            goal(sameTerm(b, a)),
            by(rule("composition-of-injective-functions-is-injective.eye", clause(19))),
            bindings([binding("?x", b), binding("?y", a), binding("?f", f), binding("?u", d), binding("?v", c)]),
            uses([
              proof(
                goal(injective(f)),
                by(fact("composition-of-injective-functions-is-injective.eye", clause(15)))
              ),
              proof(
                goal(app(f, b, d)),
                by(fact("composition-of-injective-functions-is-injective.eye", clause(12)))
              ),
              proof(
                goal(app(f, a, c)),
                by(fact("composition-of-injective-functions-is-injective.eye", clause(11)))
              ),
              proof(
                goal(sameTerm(d, c)),
                by(rule("composition-of-injective-functions-is-injective.eye", clause(10))),
                bindings([binding("?y", d), binding("?x", c)]),
                uses([
                  proof(
                    goal(sameTerm(c, d)),
                    by(rule("composition-of-injective-functions-is-injective.eye", clause(19))),
                    bindings([binding("?x", c), binding("?y", d), binding("?f", g), binding("?u", e), binding("?v", e)]),
                    uses([
                      proof(
                        goal(injective(g)),
                        by(fact("composition-of-injective-functions-is-injective.eye", clause(16)))
                      ),
                      proof(
                        goal(app(g, c, e)),
                        by(fact("composition-of-injective-functions-is-injective.eye", clause(13)))
                      ),
                      proof(
                        goal(app(g, d, e)),
                        by(fact("composition-of-injective-functions-is-injective.eye", clause(14)))
                      ),
                      proof(
                        goal(sameTerm(e, e)),
                        by(rule("composition-of-injective-functions-is-injective.eye", clause(9))),
                        bindings([binding("?x", e)]),
                        uses([
                          proof(
                            goal(inZ(e)),
                            by(fact("composition-of-injective-functions-is-injective.eye", clause(6)))
                          )
                        ])
                      )
                    ])
                  )
                ])
              )
            ])
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

sameInputByCompositeInjectivity(h, b, a).
why(
  sameInputByCompositeInjectivity(h, b, a),
  proof(
    goal(sameInputByCompositeInjectivity(h, b, a)),
    by(rule("composition-of-injective-functions-is-injective.eye", clause(20))),
    bindings([binding("?h", h), binding("?x", b), binding("?y", a), binding("?g", g), binding("?f", f), binding("?z", e)]),
    uses([
      proof(
        goal(compositeOf(h, g, f)),
        by(fact("composition-of-injective-functions-is-injective.eye", clause(17)))
      ),
      proof(
        goal(injective(g)),
        by(fact("composition-of-injective-functions-is-injective.eye", clause(16)))
      ),
      proof(
        goal(injective(f)),
        by(fact("composition-of-injective-functions-is-injective.eye", clause(15)))
      ),
      proof(
        goal(app(h, b, e)),
        by(rule("composition-of-injective-functions-is-injective.eye", clause(18))),
        bindings([binding("?h", h), binding("?x", b), binding("?z", e), binding("?g", g), binding("?f", f), binding("?y", d)]),
        uses([
          proof(
            goal(compositeOf(h, g, f)),
            by(fact("composition-of-injective-functions-is-injective.eye", clause(17)))
          ),
          proof(
            goal(app(f, b, d)),
            by(fact("composition-of-injective-functions-is-injective.eye", clause(12)))
          ),
          proof(
            goal(app(g, d, e)),
            by(fact("composition-of-injective-functions-is-injective.eye", clause(14)))
          )
        ])
      ),
      proof(
        goal(app(h, a, e)),
        by(rule("composition-of-injective-functions-is-injective.eye", clause(18))),
        bindings([binding("?h", h), binding("?x", a), binding("?z", e), binding("?g", g), binding("?f", f), binding("?y", c)]),
        uses([
          proof(
            goal(compositeOf(h, g, f)),
            by(fact("composition-of-injective-functions-is-injective.eye", clause(17)))
          ),
          proof(
            goal(app(f, a, c)),
            by(fact("composition-of-injective-functions-is-injective.eye", clause(11)))
          ),
          proof(
            goal(app(g, c, e)),
            by(fact("composition-of-injective-functions-is-injective.eye", clause(13)))
          )
        ])
      ),
      proof(
        goal(sameTerm(b, a)),
        by(rule("composition-of-injective-functions-is-injective.eye", clause(10))),
        bindings([binding("?y", b), binding("?x", a)]),
        uses([
          proof(
            goal(sameTerm(a, b)),
            by(rule("composition-of-injective-functions-is-injective.eye", clause(19))),
            bindings([binding("?x", a), binding("?y", b), binding("?f", f), binding("?u", c), binding("?v", d)]),
            uses([
              proof(
                goal(injective(f)),
                by(fact("composition-of-injective-functions-is-injective.eye", clause(15)))
              ),
              proof(
                goal(app(f, a, c)),
                by(fact("composition-of-injective-functions-is-injective.eye", clause(11)))
              ),
              proof(
                goal(app(f, b, d)),
                by(fact("composition-of-injective-functions-is-injective.eye", clause(12)))
              ),
              proof(
                goal(sameTerm(c, d)),
                by(rule("composition-of-injective-functions-is-injective.eye", clause(10))),
                bindings([binding("?y", c), binding("?x", d)]),
                uses([
                  proof(
                    goal(sameTerm(d, c)),
                    by(rule("composition-of-injective-functions-is-injective.eye", clause(19))),
                    bindings([binding("?x", d), binding("?y", c), binding("?f", g), binding("?u", e), binding("?v", e)]),
                    uses([
                      proof(
                        goal(injective(g)),
                        by(fact("composition-of-injective-functions-is-injective.eye", clause(16)))
                      ),
                      proof(
                        goal(app(g, d, e)),
                        by(fact("composition-of-injective-functions-is-injective.eye", clause(14)))
                      ),
                      proof(
                        goal(app(g, c, e)),
                        by(fact("composition-of-injective-functions-is-injective.eye", clause(13)))
                      ),
                      proof(
                        goal(sameTerm(e, e)),
                        by(rule("composition-of-injective-functions-is-injective.eye", clause(9))),
                        bindings([binding("?x", e)]),
                        uses([
                          proof(
                            goal(inZ(e)),
                            by(fact("composition-of-injective-functions-is-injective.eye", clause(6)))
                          )
                        ])
                      )
                    ])
                  )
                ])
              )
            ])
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

