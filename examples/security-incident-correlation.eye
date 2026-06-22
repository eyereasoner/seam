% Representative example: security incident correlation.
%
% The rules correlate endpoint, identity, vulnerability, and threat-intelligence
% signals into an escalation decision with concise reason relations.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
materialize(type, 2).
materialize(status, 2).
materialize(reason, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
incident(inc42).
incident(inc43).

asset(endpoint23, criticality, high).
asset(endpoint77, criticality, low).

assigned_user(endpoint23, user_alice).
assigned_user(endpoint77, user_bob).

privileged_user(user_alice).

alert(inc42, endpoint, endpoint23).
alert(inc42, suspicious_login, user_alice).
alert(inc42, malware_hash, hash_redline).
alert(inc42, outbound_ip, ip_203_0_113_17).

alert(inc43, endpoint, endpoint77).
alert(inc43, suspicious_login, user_bob).
alert(inc43, outbound_ip, ip_198_51_100_42).

vulnerability(endpoint23, cve_critical_rce).
threat_intel(ip_203_0_113_17, command_and_control).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
critical_asset(?endpoint) :-
  asset(?endpoint, criticality, high).

credential_abuse(?incident) :-
  alert(?incident, suspicious_login, ?user),
  privileged_user(?user).

malware_on_critical_asset(?incident) :-
  alert(?incident, endpoint, ?endpoint),
  alert(?incident, malware_hash, ?_hash),
  critical_asset(?endpoint).

c2_contact(?incident) :-
  alert(?incident, outbound_ip, ?ip),
  threat_intel(?ip, command_and_control).

exploitable_endpoint(?incident) :-
  alert(?incident, endpoint, ?endpoint),
  vulnerability(?endpoint, cve_critical_rce).

confirmed_compromise(?incident) :-
  credential_abuse(?incident),
  malware_on_critical_asset(?incident),
  c2_contact(?incident),
  exploitable_endpoint(?incident).

type(?incident, confirmed_compromise) :-
  confirmed_compromise(?incident).

status(?incident, escalate_to_incident_response) :-
  confirmed_compromise(?incident).

reason(?incident, "privileged credential abuse, malware on a critical endpoint, C2 contact, and exploitable RCE are correlated") :-
  confirmed_compromise(?incident).
