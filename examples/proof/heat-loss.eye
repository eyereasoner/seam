type(wall1, conduction_heat_loss).
why(
  type(wall1, conduction_heat_loss),
  proof(
    goal(type(wall1, conduction_heat_loss)),
    by(rule("heat-loss.eye", clause(14))),
    bindings([binding("?wall", wall1), binding("?_thickness", 0.2)]),
    uses([
      proof(
        goal(wall(wall1, thickness_m, 0.2)),
        by(fact("heat-loss.eye", clause(8)))
      )
    ])
  )
).

temperatureDifference_K(wall1, 25.0).
why(
  temperatureDifference_K(wall1, 25.0),
  proof(
    goal(temperatureDifference_K(wall1, 25.0)),
    by(rule("heat-loss.eye", clause(15))),
    bindings([binding("?wall", wall1), binding("?deltat", 25.0)]),
    uses([
      proof(
        goal(temperature_difference(wall1, 25.0)),
        by(rule("heat-loss.eye", clause(11))),
        bindings([binding("?wall", wall1), binding("?deltat", 25.0), binding("?indoor", 21.0), binding("?outdoor", -4.0)]),
        uses([
          proof(
            goal(wall(wall1, indoor_C, 21.0)),
            by(fact("heat-loss.eye", clause(9)))
          ),
          proof(
            goal(wall(wall1, outdoor_C, -4.0)),
            by(fact("heat-loss.eye", clause(10)))
          ),
          proof(
            goal(sub(21.0, -4.0, 25.0)),
            by(builtin(sub, 3))
          )
        ])
      )
    ])
  )
).

thermalResistance_K_W(wall1, 0.020833333333333332).
why(
  thermalResistance_K_W(wall1, 0.020833333333333332),
  proof(
    goal(thermalResistance_K_W(wall1, 0.020833333333333332)),
    by(rule("heat-loss.eye", clause(16))),
    bindings([binding("?wall", wall1), binding("?resistance", 0.020833333333333332)]),
    uses([
      proof(
        goal(thermal_resistance(wall1, 0.020833333333333332)),
        by(rule("heat-loss.eye", clause(12))),
        bindings([binding("?wall", wall1), binding("?resistance", 0.020833333333333332), binding("?thickness", 0.2), binding("?conductivity", 0.8), binding("?area", 12.0), binding("?conductance", 9.6000000000000014)]),
        uses([
          proof(
            goal(wall(wall1, thickness_m, 0.2)),
            by(fact("heat-loss.eye", clause(8)))
          ),
          proof(
            goal(wall(wall1, conductivity_W_mK, 0.8)),
            by(fact("heat-loss.eye", clause(6)))
          ),
          proof(
            goal(wall(wall1, area_m2, 12.0)),
            by(fact("heat-loss.eye", clause(7)))
          ),
          proof(
            goal(mul(0.8, 12.0, 9.6000000000000014)),
            by(builtin(mul, 3))
          ),
          proof(
            goal(div(0.2, 9.6000000000000014, 0.020833333333333332)),
            by(builtin(div, 3))
          )
        ])
      )
    ])
  )
).

heatLoss_W(wall1, 1200.0).
why(
  heatLoss_W(wall1, 1200.0),
  proof(
    goal(heatLoss_W(wall1, 1200.0)),
    by(rule("heat-loss.eye", clause(17))),
    bindings([binding("?wall", wall1), binding("?heatloss", 1200.0)]),
    uses([
      proof(
        goal(heat_loss(wall1, 1200.0)),
        by(rule("heat-loss.eye", clause(13))),
        bindings([binding("?wall", wall1), binding("?heatloss", 1200.0), binding("?deltat", 25.0), binding("?resistance", 0.020833333333333332)]),
        uses([
          proof(
            goal(temperature_difference(wall1, 25.0)),
            by(rule("heat-loss.eye", clause(11))),
            bindings([binding("?wall", wall1), binding("?deltat", 25.0), binding("?indoor", 21.0), binding("?outdoor", -4.0)]),
            uses([
              proof(
                goal(wall(wall1, indoor_C, 21.0)),
                by(fact("heat-loss.eye", clause(9)))
              ),
              proof(
                goal(wall(wall1, outdoor_C, -4.0)),
                by(fact("heat-loss.eye", clause(10)))
              ),
              proof(
                goal(sub(21.0, -4.0, 25.0)),
                by(builtin(sub, 3))
              )
            ])
          ),
          proof(
            goal(thermal_resistance(wall1, 0.020833333333333332)),
            by(rule("heat-loss.eye", clause(12))),
            bindings([binding("?wall", wall1), binding("?resistance", 0.020833333333333332), binding("?thickness", 0.2), binding("?conductivity", 0.8), binding("?area", 12.0), binding("?conductance", 9.6000000000000014)]),
            uses([
              proof(
                goal(wall(wall1, thickness_m, 0.2)),
                by(fact("heat-loss.eye", clause(8)))
              ),
              proof(
                goal(wall(wall1, conductivity_W_mK, 0.8)),
                by(fact("heat-loss.eye", clause(6)))
              ),
              proof(
                goal(wall(wall1, area_m2, 12.0)),
                by(fact("heat-loss.eye", clause(7)))
              ),
              proof(
                goal(mul(0.8, 12.0, 9.6000000000000014)),
                by(builtin(mul, 3))
              ),
              proof(
                goal(div(0.2, 9.6000000000000014, 0.020833333333333332)),
                by(builtin(div, 3))
              )
            ])
          ),
          proof(
            goal(div(25.0, 0.020833333333333332, 1200.0)),
            by(builtin(div, 3))
          )
        ])
      )
    ])
  )
).

status(wall1, high_heat_loss).
why(
  status(wall1, high_heat_loss),
  proof(
    goal(status(wall1, high_heat_loss)),
    by(rule("heat-loss.eye", clause(18))),
    bindings([binding("?wall", wall1), binding("?heatloss", 1200.0)]),
    uses([
      proof(
        goal(heat_loss(wall1, 1200.0)),
        by(rule("heat-loss.eye", clause(13))),
        bindings([binding("?wall", wall1), binding("?heatloss", 1200.0), binding("?deltat", 25.0), binding("?resistance", 0.020833333333333332)]),
        uses([
          proof(
            goal(temperature_difference(wall1, 25.0)),
            by(rule("heat-loss.eye", clause(11))),
            bindings([binding("?wall", wall1), binding("?deltat", 25.0), binding("?indoor", 21.0), binding("?outdoor", -4.0)]),
            uses([
              proof(
                goal(wall(wall1, indoor_C, 21.0)),
                by(fact("heat-loss.eye", clause(9)))
              ),
              proof(
                goal(wall(wall1, outdoor_C, -4.0)),
                by(fact("heat-loss.eye", clause(10)))
              ),
              proof(
                goal(sub(21.0, -4.0, 25.0)),
                by(builtin(sub, 3))
              )
            ])
          ),
          proof(
            goal(thermal_resistance(wall1, 0.020833333333333332)),
            by(rule("heat-loss.eye", clause(12))),
            bindings([binding("?wall", wall1), binding("?resistance", 0.020833333333333332), binding("?thickness", 0.2), binding("?conductivity", 0.8), binding("?area", 12.0), binding("?conductance", 9.6000000000000014)]),
            uses([
              proof(
                goal(wall(wall1, thickness_m, 0.2)),
                by(fact("heat-loss.eye", clause(8)))
              ),
              proof(
                goal(wall(wall1, conductivity_W_mK, 0.8)),
                by(fact("heat-loss.eye", clause(6)))
              ),
              proof(
                goal(wall(wall1, area_m2, 12.0)),
                by(fact("heat-loss.eye", clause(7)))
              ),
              proof(
                goal(mul(0.8, 12.0, 9.6000000000000014)),
                by(builtin(mul, 3))
              ),
              proof(
                goal(div(0.2, 9.6000000000000014, 0.020833333333333332)),
                by(builtin(div, 3))
              )
            ])
          ),
          proof(
            goal(div(25.0, 0.020833333333333332, 1200.0)),
            by(builtin(div, 3))
          )
        ])
      ),
      proof(
        goal(gt(1200.0, 1000.0)),
        by(builtin(gt, 2))
      )
    ])
  )
).

