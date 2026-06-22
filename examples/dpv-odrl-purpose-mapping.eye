% Translate a DPV-style personal-data processing description into an ODRL-style policy view.
% The source facts describe one care/research process: controller, recipient, data, action, purpose, and legal basis.
% The derived predicates materialize the corresponding ODRL policy, permission, target, party, action, and constraints.

materialize(type, 2).
materialize(odrl_permission, 2).
materialize(odrl_assigner, 2).
materialize(odrl_assignee, 2).
materialize(odrl_target, 2).
materialize(odrl_action, 2).
materialize(odrl_constraint, 2).
materialize(odrl_leftOperand, 2).
materialize(odrl_operator, 2).
materialize(odrl_rightOperand, 2).
materialize(derived_from_process, 2).

process(alpha_care_process).
data_controller(alpha_care_process, hospital_a).
recipient(alpha_care_process, research_partner).
personal_data(alpha_care_process, lab_result).
processing(alpha_care_process, dpv_use).
purpose(alpha_care_process, dpv_healthcare).
legal_basis(alpha_care_process, dpv_consent).

represents_process(alpha_policy, alpha_care_process).
permission_node(alpha_policy, alpha_permission).
purpose_constraint(alpha_policy, alpha_purpose_constraint).
basis_constraint(alpha_policy, alpha_basis_constraint).

type(?policy, odrl_policy) :- represents_process(?policy, ?_process).
odrl_permission(?policy, ?permission) :- permission_node(?policy, ?permission).
type(?permission, odrl_permission) :- permission_node(?_policy, ?permission).
derived_from_process(?permission, ?process) :- represents_process(?policy, ?process), permission_node(?policy, ?permission).
odrl_assigner(?permission, ?controller) :- represents_process(?policy, ?process), permission_node(?policy, ?permission), data_controller(?process, ?controller).
odrl_assignee(?permission, ?recipient) :- represents_process(?policy, ?process), permission_node(?policy, ?permission), recipient(?process, ?recipient).
odrl_target(?permission, ?data) :- represents_process(?policy, ?process), permission_node(?policy, ?permission), personal_data(?process, ?data).
odrl_action(?permission, ?action) :- represents_process(?policy, ?process), permission_node(?policy, ?permission), processing(?process, ?action).

odrl_constraint(?permission, ?constraint) :- permission_node(?policy, ?permission), purpose_constraint(?policy, ?constraint).
odrl_constraint(?permission, ?constraint) :- permission_node(?policy, ?permission), basis_constraint(?policy, ?constraint).
type(?constraint, odrl_constraint) :- purpose_constraint(?_policy, ?constraint).
type(?constraint, odrl_constraint) :- basis_constraint(?_policy, ?constraint).
odrl_leftOperand(?constraint, dpv_odrl_purpose) :- purpose_constraint(?_policy, ?constraint).
odrl_leftOperand(?constraint, dpv_odrl_legal_basis) :- basis_constraint(?_policy, ?constraint).
odrl_operator(?constraint, odrl_isA) :- purpose_constraint(?_policy, ?constraint).
odrl_operator(?constraint, odrl_isA) :- basis_constraint(?_policy, ?constraint).
odrl_rightOperand(?constraint, ?purpose) :- represents_process(?policy, ?process), purpose_constraint(?policy, ?constraint), purpose(?process, ?purpose).
odrl_rightOperand(?constraint, ?basis) :- represents_process(?policy, ?process), basis_constraint(?policy, ?constraint), legal_basis(?process, ?basis).
