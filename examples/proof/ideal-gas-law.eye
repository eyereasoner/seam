pressure_Pa(cell1, 100000.0).
why(
  pressure_Pa(cell1, 100000.0),
  proof(
    goal(pressure_Pa(cell1, 100000.0)),
    by(rule("ideal-gas-law.eye", clause(9))),
    bindings([binding("?cell", cell1), binding("?pressure", 100000.0)]),
    uses([
      proof(
        goal(pressure(cell1, 100000.0)),
        by(rule("ideal-gas-law.eye", clause(7))),
        bindings([binding("?cell", cell1), binding("?pressure", 100000.0), binding("?moles", 1.0), binding("?gasconstant", 8.0), binding("?temperature", 300.0), binding("?volume", 0.024), binding("?nr", 8.0), binding("?nrt", 2400.0)]),
        uses([
          proof(
            goal(gas_cell(cell1, 1.0, 8.0, 300.0, 0.024)),
            by(fact("ideal-gas-law.eye", clause(4)))
          ),
          proof(
            goal(mul(1.0, 8.0, 8.0)),
            by(builtin(mul, 3))
          ),
          proof(
            goal(mul(8.0, 300.0, 2400.0)),
            by(builtin(mul, 3))
          ),
          proof(
            goal(div(2400.0, 0.024, 100000.0)),
            by(builtin(div, 3))
          )
        ])
      )
    ])
  )
).

status(cell1, near_atmospheric).
why(
  status(cell1, near_atmospheric),
  proof(
    goal(status(cell1, near_atmospheric)),
    by(rule("ideal-gas-law.eye", clause(10))),
    bindings([binding("?cell", cell1)]),
    uses([
      proof(
        goal(near_atmospheric(cell1)),
        by(rule("ideal-gas-law.eye", clause(8))),
        bindings([binding("?cell", cell1), binding("?pressure", 100000.0), binding("?low", 95000.0), binding("?high", 105000.0)]),
        uses([
          proof(
            goal(pressure(cell1, 100000.0)),
            by(rule("ideal-gas-law.eye", clause(7))),
            bindings([binding("?cell", cell1), binding("?pressure", 100000.0), binding("?moles", 1.0), binding("?gasconstant", 8.0), binding("?temperature", 300.0), binding("?volume", 0.024), binding("?nr", 8.0), binding("?nrt", 2400.0)]),
            uses([
              proof(
                goal(gas_cell(cell1, 1.0, 8.0, 300.0, 0.024)),
                by(fact("ideal-gas-law.eye", clause(4)))
              ),
              proof(
                goal(mul(1.0, 8.0, 8.0)),
                by(builtin(mul, 3))
              ),
              proof(
                goal(mul(8.0, 300.0, 2400.0)),
                by(builtin(mul, 3))
              ),
              proof(
                goal(div(2400.0, 0.024, 100000.0)),
                by(builtin(div, 3))
              )
            ])
          ),
          proof(
            goal(pressure_limit(cell1, low_Pa, 95000.0)),
            by(fact("ideal-gas-law.eye", clause(5)))
          ),
          proof(
            goal(pressure_limit(cell1, high_Pa, 105000.0)),
            by(fact("ideal-gas-law.eye", clause(6)))
          ),
          proof(
            goal(gt(100000.0, 95000.0)),
            by(builtin(gt, 2))
          ),
          proof(
            goal(lt(100000.0, 105000.0)),
            by(builtin(lt, 2))
          )
        ])
      )
    ])
  )
).

reason(cell1, "pressure is inside the one-atmosphere tolerance band").
why(
  reason(cell1, "pressure is inside the one-atmosphere tolerance band"),
  proof(
    goal(reason(cell1, "pressure is inside the one-atmosphere tolerance band")),
    by(rule("ideal-gas-law.eye", clause(11))),
    bindings([binding("?cell", cell1)]),
    uses([
      proof(
        goal(near_atmospheric(cell1)),
        by(rule("ideal-gas-law.eye", clause(8))),
        bindings([binding("?cell", cell1), binding("?pressure", 100000.0), binding("?low", 95000.0), binding("?high", 105000.0)]),
        uses([
          proof(
            goal(pressure(cell1, 100000.0)),
            by(rule("ideal-gas-law.eye", clause(7))),
            bindings([binding("?cell", cell1), binding("?pressure", 100000.0), binding("?moles", 1.0), binding("?gasconstant", 8.0), binding("?temperature", 300.0), binding("?volume", 0.024), binding("?nr", 8.0), binding("?nrt", 2400.0)]),
            uses([
              proof(
                goal(gas_cell(cell1, 1.0, 8.0, 300.0, 0.024)),
                by(fact("ideal-gas-law.eye", clause(4)))
              ),
              proof(
                goal(mul(1.0, 8.0, 8.0)),
                by(builtin(mul, 3))
              ),
              proof(
                goal(mul(8.0, 300.0, 2400.0)),
                by(builtin(mul, 3))
              ),
              proof(
                goal(div(2400.0, 0.024, 100000.0)),
                by(builtin(div, 3))
              )
            ])
          ),
          proof(
            goal(pressure_limit(cell1, low_Pa, 95000.0)),
            by(fact("ideal-gas-law.eye", clause(5)))
          ),
          proof(
            goal(pressure_limit(cell1, high_Pa, 105000.0)),
            by(fact("ideal-gas-law.eye", clause(6)))
          ),
          proof(
            goal(gt(100000.0, 95000.0)),
            by(builtin(gt, 2))
          ),
          proof(
            goal(lt(100000.0, 105000.0)),
            by(builtin(lt, 2))
          )
        ])
      )
    ])
  )
).

