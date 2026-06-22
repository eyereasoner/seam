type(beam1, cantilever_beam).
why(
  type(beam1, cantilever_beam),
  proof(
    goal(type(beam1, cantilever_beam)),
    by(rule("beam-deflection.eye", clause(13))),
    bindings([binding("?beam", beam1), binding("?_force", 1200.0)]),
    uses([
      proof(
        goal(beam(beam1, force_N, 1200.0)),
        by(fact("beam-deflection.eye", clause(6)))
      )
    ])
  )
).

tipDeflection_m(beam1, 0.00390625).
why(
  tipDeflection_m(beam1, 0.00390625),
  proof(
    goal(tipDeflection_m(beam1, 0.00390625)),
    by(rule("beam-deflection.eye", clause(14))),
    bindings([binding("?beam", beam1), binding("?deflectionm", 0.00390625)]),
    uses([
      proof(
        goal(tip_deflection_m(beam1, 0.00390625)),
        by(rule("beam-deflection.eye", clause(11))),
        bindings([binding("?beam", beam1), binding("?deflection", 0.00390625), binding("?force", 1200.0), binding("?length", 2.5), binding("?elasticmodulus", 200000000000.0), binding("?secondmoment", 0.000008), binding("?lengthcubed", 15.625), binding("?numerator", 18750.0), binding("?threee", 600000000000.0), binding("?denominator", 4800000.0)]),
        uses([
          proof(
            goal(beam(beam1, force_N, 1200.0)),
            by(fact("beam-deflection.eye", clause(6)))
          ),
          proof(
            goal(beam(beam1, length_m, 2.5)),
            by(fact("beam-deflection.eye", clause(7)))
          ),
          proof(
            goal(beam(beam1, elasticModulus_Pa, 200000000000.0)),
            by(fact("beam-deflection.eye", clause(8)))
          ),
          proof(
            goal(beam(beam1, secondMoment_m4, 0.000008)),
            by(fact("beam-deflection.eye", clause(9)))
          ),
          proof(
            goal(pow(2.5, 3.0, 15.625)),
            by(builtin(pow, 3))
          ),
          proof(
            goal(mul(1200.0, 15.625, 18750.0)),
            by(builtin(mul, 3))
          ),
          proof(
            goal(mul(3.0, 200000000000.0, 600000000000.0)),
            by(builtin(mul, 3))
          ),
          proof(
            goal(mul(600000000000.0, 0.000008, 4800000.0)),
            by(builtin(mul, 3))
          ),
          proof(
            goal(div(18750.0, 4800000.0, 0.00390625)),
            by(builtin(div, 3))
          )
        ])
      )
    ])
  )
).

tipDeflection_mm(beam1, 3.90625).
why(
  tipDeflection_mm(beam1, 3.90625),
  proof(
    goal(tipDeflection_mm(beam1, 3.90625)),
    by(rule("beam-deflection.eye", clause(15))),
    bindings([binding("?beam", beam1), binding("?deflectionmm", 3.90625)]),
    uses([
      proof(
        goal(tip_deflection_mm(beam1, 3.90625)),
        by(rule("beam-deflection.eye", clause(12))),
        bindings([binding("?beam", beam1), binding("?deflectionmm", 3.90625), binding("?deflectionm", 0.00390625)]),
        uses([
          proof(
            goal(tip_deflection_m(beam1, 0.00390625)),
            by(rule("beam-deflection.eye", clause(11))),
            bindings([binding("?beam", beam1), binding("?deflection", 0.00390625), binding("?force", 1200.0), binding("?length", 2.5), binding("?elasticmodulus", 200000000000.0), binding("?secondmoment", 0.000008), binding("?lengthcubed", 15.625), binding("?numerator", 18750.0), binding("?threee", 600000000000.0), binding("?denominator", 4800000.0)]),
            uses([
              proof(
                goal(beam(beam1, force_N, 1200.0)),
                by(fact("beam-deflection.eye", clause(6)))
              ),
              proof(
                goal(beam(beam1, length_m, 2.5)),
                by(fact("beam-deflection.eye", clause(7)))
              ),
              proof(
                goal(beam(beam1, elasticModulus_Pa, 200000000000.0)),
                by(fact("beam-deflection.eye", clause(8)))
              ),
              proof(
                goal(beam(beam1, secondMoment_m4, 0.000008)),
                by(fact("beam-deflection.eye", clause(9)))
              ),
              proof(
                goal(pow(2.5, 3.0, 15.625)),
                by(builtin(pow, 3))
              ),
              proof(
                goal(mul(1200.0, 15.625, 18750.0)),
                by(builtin(mul, 3))
              ),
              proof(
                goal(mul(3.0, 200000000000.0, 600000000000.0)),
                by(builtin(mul, 3))
              ),
              proof(
                goal(mul(600000000000.0, 0.000008, 4800000.0)),
                by(builtin(mul, 3))
              ),
              proof(
                goal(div(18750.0, 4800000.0, 0.00390625)),
                by(builtin(div, 3))
              )
            ])
          ),
          proof(
            goal(mul(0.00390625, 1000.0, 3.90625)),
            by(builtin(mul, 3))
          )
        ])
      )
    ])
  )
).

limit_mm(beam1, 5.0).
why(
  limit_mm(beam1, 5.0),
  proof(
    goal(limit_mm(beam1, 5.0)),
    by(rule("beam-deflection.eye", clause(16))),
    bindings([binding("?beam", beam1), binding("?limit", 5.0)]),
    uses([
      proof(
        goal(limit(beam1, maxDeflection_mm, 5.0)),
        by(fact("beam-deflection.eye", clause(10)))
      )
    ])
  )
).

status(beam1, within_deflection_limit).
why(
  status(beam1, within_deflection_limit),
  proof(
    goal(status(beam1, within_deflection_limit)),
    by(rule("beam-deflection.eye", clause(17))),
    bindings([binding("?beam", beam1), binding("?deflectionmm", 3.90625), binding("?limit", 5.0)]),
    uses([
      proof(
        goal(tip_deflection_mm(beam1, 3.90625)),
        by(rule("beam-deflection.eye", clause(12))),
        bindings([binding("?beam", beam1), binding("?deflectionmm", 3.90625), binding("?deflectionm", 0.00390625)]),
        uses([
          proof(
            goal(tip_deflection_m(beam1, 0.00390625)),
            by(rule("beam-deflection.eye", clause(11))),
            bindings([binding("?beam", beam1), binding("?deflection", 0.00390625), binding("?force", 1200.0), binding("?length", 2.5), binding("?elasticmodulus", 200000000000.0), binding("?secondmoment", 0.000008), binding("?lengthcubed", 15.625), binding("?numerator", 18750.0), binding("?threee", 600000000000.0), binding("?denominator", 4800000.0)]),
            uses([
              proof(
                goal(beam(beam1, force_N, 1200.0)),
                by(fact("beam-deflection.eye", clause(6)))
              ),
              proof(
                goal(beam(beam1, length_m, 2.5)),
                by(fact("beam-deflection.eye", clause(7)))
              ),
              proof(
                goal(beam(beam1, elasticModulus_Pa, 200000000000.0)),
                by(fact("beam-deflection.eye", clause(8)))
              ),
              proof(
                goal(beam(beam1, secondMoment_m4, 0.000008)),
                by(fact("beam-deflection.eye", clause(9)))
              ),
              proof(
                goal(pow(2.5, 3.0, 15.625)),
                by(builtin(pow, 3))
              ),
              proof(
                goal(mul(1200.0, 15.625, 18750.0)),
                by(builtin(mul, 3))
              ),
              proof(
                goal(mul(3.0, 200000000000.0, 600000000000.0)),
                by(builtin(mul, 3))
              ),
              proof(
                goal(mul(600000000000.0, 0.000008, 4800000.0)),
                by(builtin(mul, 3))
              ),
              proof(
                goal(div(18750.0, 4800000.0, 0.00390625)),
                by(builtin(div, 3))
              )
            ])
          ),
          proof(
            goal(mul(0.00390625, 1000.0, 3.90625)),
            by(builtin(mul, 3))
          )
        ])
      ),
      proof(
        goal(limit(beam1, maxDeflection_mm, 5.0)),
        by(fact("beam-deflection.eye", clause(10)))
      ),
      proof(
        goal(le(3.90625, 5.0)),
        by(builtin(le, 2))
      )
    ])
  )
).

