type(alpha_policy, odrl_policy).
why(
  type(alpha_policy, odrl_policy),
  proof(
    goal(type(alpha_policy, odrl_policy)),
    by(rule("dpv-odrl-purpose-mapping.eye", clause(23))),
    bindings([binding("?policy", alpha_policy), binding("?_process", alpha_care_process)]),
    uses([
      proof(
        goal(represents_process(alpha_policy, alpha_care_process)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(19)))
      )
    ])
  )
).

type(alpha_permission, odrl_permission).
why(
  type(alpha_permission, odrl_permission),
  proof(
    goal(type(alpha_permission, odrl_permission)),
    by(rule("dpv-odrl-purpose-mapping.eye", clause(25))),
    bindings([binding("?permission", alpha_permission), binding("?_policy", alpha_policy)]),
    uses([
      proof(
        goal(permission_node(alpha_policy, alpha_permission)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(20)))
      )
    ])
  )
).

type(alpha_purpose_constraint, odrl_constraint).
why(
  type(alpha_purpose_constraint, odrl_constraint),
  proof(
    goal(type(alpha_purpose_constraint, odrl_constraint)),
    by(rule("dpv-odrl-purpose-mapping.eye", clause(33))),
    bindings([binding("?constraint", alpha_purpose_constraint), binding("?_policy", alpha_policy)]),
    uses([
      proof(
        goal(purpose_constraint(alpha_policy, alpha_purpose_constraint)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(21)))
      )
    ])
  )
).

type(alpha_basis_constraint, odrl_constraint).
why(
  type(alpha_basis_constraint, odrl_constraint),
  proof(
    goal(type(alpha_basis_constraint, odrl_constraint)),
    by(rule("dpv-odrl-purpose-mapping.eye", clause(34))),
    bindings([binding("?constraint", alpha_basis_constraint), binding("?_policy", alpha_policy)]),
    uses([
      proof(
        goal(basis_constraint(alpha_policy, alpha_basis_constraint)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(22)))
      )
    ])
  )
).

odrl_permission(alpha_policy, alpha_permission).
why(
  odrl_permission(alpha_policy, alpha_permission),
  proof(
    goal(odrl_permission(alpha_policy, alpha_permission)),
    by(rule("dpv-odrl-purpose-mapping.eye", clause(24))),
    bindings([binding("?policy", alpha_policy), binding("?permission", alpha_permission)]),
    uses([
      proof(
        goal(permission_node(alpha_policy, alpha_permission)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(20)))
      )
    ])
  )
).

derived_from_process(alpha_permission, alpha_care_process).
why(
  derived_from_process(alpha_permission, alpha_care_process),
  proof(
    goal(derived_from_process(alpha_permission, alpha_care_process)),
    by(rule("dpv-odrl-purpose-mapping.eye", clause(26))),
    bindings([binding("?permission", alpha_permission), binding("?process", alpha_care_process), binding("?policy", alpha_policy)]),
    uses([
      proof(
        goal(represents_process(alpha_policy, alpha_care_process)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(19)))
      ),
      proof(
        goal(permission_node(alpha_policy, alpha_permission)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(20)))
      )
    ])
  )
).

odrl_assigner(alpha_permission, hospital_a).
why(
  odrl_assigner(alpha_permission, hospital_a),
  proof(
    goal(odrl_assigner(alpha_permission, hospital_a)),
    by(rule("dpv-odrl-purpose-mapping.eye", clause(27))),
    bindings([binding("?permission", alpha_permission), binding("?controller", hospital_a), binding("?policy", alpha_policy), binding("?process", alpha_care_process)]),
    uses([
      proof(
        goal(represents_process(alpha_policy, alpha_care_process)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(19)))
      ),
      proof(
        goal(permission_node(alpha_policy, alpha_permission)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(20)))
      ),
      proof(
        goal(data_controller(alpha_care_process, hospital_a)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(13)))
      )
    ])
  )
).

odrl_assignee(alpha_permission, research_partner).
why(
  odrl_assignee(alpha_permission, research_partner),
  proof(
    goal(odrl_assignee(alpha_permission, research_partner)),
    by(rule("dpv-odrl-purpose-mapping.eye", clause(28))),
    bindings([binding("?permission", alpha_permission), binding("?recipient", research_partner), binding("?policy", alpha_policy), binding("?process", alpha_care_process)]),
    uses([
      proof(
        goal(represents_process(alpha_policy, alpha_care_process)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(19)))
      ),
      proof(
        goal(permission_node(alpha_policy, alpha_permission)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(20)))
      ),
      proof(
        goal(recipient(alpha_care_process, research_partner)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(14)))
      )
    ])
  )
).

odrl_target(alpha_permission, lab_result).
why(
  odrl_target(alpha_permission, lab_result),
  proof(
    goal(odrl_target(alpha_permission, lab_result)),
    by(rule("dpv-odrl-purpose-mapping.eye", clause(29))),
    bindings([binding("?permission", alpha_permission), binding("?data", lab_result), binding("?policy", alpha_policy), binding("?process", alpha_care_process)]),
    uses([
      proof(
        goal(represents_process(alpha_policy, alpha_care_process)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(19)))
      ),
      proof(
        goal(permission_node(alpha_policy, alpha_permission)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(20)))
      ),
      proof(
        goal(personal_data(alpha_care_process, lab_result)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(15)))
      )
    ])
  )
).

odrl_action(alpha_permission, dpv_use).
why(
  odrl_action(alpha_permission, dpv_use),
  proof(
    goal(odrl_action(alpha_permission, dpv_use)),
    by(rule("dpv-odrl-purpose-mapping.eye", clause(30))),
    bindings([binding("?permission", alpha_permission), binding("?action", dpv_use), binding("?policy", alpha_policy), binding("?process", alpha_care_process)]),
    uses([
      proof(
        goal(represents_process(alpha_policy, alpha_care_process)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(19)))
      ),
      proof(
        goal(permission_node(alpha_policy, alpha_permission)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(20)))
      ),
      proof(
        goal(processing(alpha_care_process, dpv_use)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(16)))
      )
    ])
  )
).

odrl_constraint(alpha_permission, alpha_purpose_constraint).
why(
  odrl_constraint(alpha_permission, alpha_purpose_constraint),
  proof(
    goal(odrl_constraint(alpha_permission, alpha_purpose_constraint)),
    by(rule("dpv-odrl-purpose-mapping.eye", clause(31))),
    bindings([binding("?permission", alpha_permission), binding("?constraint", alpha_purpose_constraint), binding("?policy", alpha_policy)]),
    uses([
      proof(
        goal(permission_node(alpha_policy, alpha_permission)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(20)))
      ),
      proof(
        goal(purpose_constraint(alpha_policy, alpha_purpose_constraint)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(21)))
      )
    ])
  )
).

odrl_constraint(alpha_permission, alpha_basis_constraint).
why(
  odrl_constraint(alpha_permission, alpha_basis_constraint),
  proof(
    goal(odrl_constraint(alpha_permission, alpha_basis_constraint)),
    by(rule("dpv-odrl-purpose-mapping.eye", clause(32))),
    bindings([binding("?permission", alpha_permission), binding("?constraint", alpha_basis_constraint), binding("?policy", alpha_policy)]),
    uses([
      proof(
        goal(permission_node(alpha_policy, alpha_permission)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(20)))
      ),
      proof(
        goal(basis_constraint(alpha_policy, alpha_basis_constraint)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(22)))
      )
    ])
  )
).

odrl_leftOperand(alpha_purpose_constraint, dpv_odrl_purpose).
why(
  odrl_leftOperand(alpha_purpose_constraint, dpv_odrl_purpose),
  proof(
    goal(odrl_leftOperand(alpha_purpose_constraint, dpv_odrl_purpose)),
    by(rule("dpv-odrl-purpose-mapping.eye", clause(35))),
    bindings([binding("?constraint", alpha_purpose_constraint), binding("?_policy", alpha_policy)]),
    uses([
      proof(
        goal(purpose_constraint(alpha_policy, alpha_purpose_constraint)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(21)))
      )
    ])
  )
).

odrl_leftOperand(alpha_basis_constraint, dpv_odrl_legal_basis).
why(
  odrl_leftOperand(alpha_basis_constraint, dpv_odrl_legal_basis),
  proof(
    goal(odrl_leftOperand(alpha_basis_constraint, dpv_odrl_legal_basis)),
    by(rule("dpv-odrl-purpose-mapping.eye", clause(36))),
    bindings([binding("?constraint", alpha_basis_constraint), binding("?_policy", alpha_policy)]),
    uses([
      proof(
        goal(basis_constraint(alpha_policy, alpha_basis_constraint)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(22)))
      )
    ])
  )
).

odrl_operator(alpha_purpose_constraint, odrl_isA).
why(
  odrl_operator(alpha_purpose_constraint, odrl_isA),
  proof(
    goal(odrl_operator(alpha_purpose_constraint, odrl_isA)),
    by(rule("dpv-odrl-purpose-mapping.eye", clause(37))),
    bindings([binding("?constraint", alpha_purpose_constraint), binding("?_policy", alpha_policy)]),
    uses([
      proof(
        goal(purpose_constraint(alpha_policy, alpha_purpose_constraint)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(21)))
      )
    ])
  )
).

odrl_operator(alpha_basis_constraint, odrl_isA).
why(
  odrl_operator(alpha_basis_constraint, odrl_isA),
  proof(
    goal(odrl_operator(alpha_basis_constraint, odrl_isA)),
    by(rule("dpv-odrl-purpose-mapping.eye", clause(38))),
    bindings([binding("?constraint", alpha_basis_constraint), binding("?_policy", alpha_policy)]),
    uses([
      proof(
        goal(basis_constraint(alpha_policy, alpha_basis_constraint)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(22)))
      )
    ])
  )
).

odrl_rightOperand(alpha_purpose_constraint, dpv_healthcare).
why(
  odrl_rightOperand(alpha_purpose_constraint, dpv_healthcare),
  proof(
    goal(odrl_rightOperand(alpha_purpose_constraint, dpv_healthcare)),
    by(rule("dpv-odrl-purpose-mapping.eye", clause(39))),
    bindings([binding("?constraint", alpha_purpose_constraint), binding("?purpose", dpv_healthcare), binding("?policy", alpha_policy), binding("?process", alpha_care_process)]),
    uses([
      proof(
        goal(represents_process(alpha_policy, alpha_care_process)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(19)))
      ),
      proof(
        goal(purpose_constraint(alpha_policy, alpha_purpose_constraint)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(21)))
      ),
      proof(
        goal(purpose(alpha_care_process, dpv_healthcare)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(17)))
      )
    ])
  )
).

odrl_rightOperand(alpha_basis_constraint, dpv_consent).
why(
  odrl_rightOperand(alpha_basis_constraint, dpv_consent),
  proof(
    goal(odrl_rightOperand(alpha_basis_constraint, dpv_consent)),
    by(rule("dpv-odrl-purpose-mapping.eye", clause(40))),
    bindings([binding("?constraint", alpha_basis_constraint), binding("?basis", dpv_consent), binding("?policy", alpha_policy), binding("?process", alpha_care_process)]),
    uses([
      proof(
        goal(represents_process(alpha_policy, alpha_care_process)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(19)))
      ),
      proof(
        goal(basis_constraint(alpha_policy, alpha_basis_constraint)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(22)))
      ),
      proof(
        goal(legal_basis(alpha_care_process, dpv_consent)),
        by(fact("dpv-odrl-purpose-mapping.eye", clause(18)))
      )
    ])
  )
).

