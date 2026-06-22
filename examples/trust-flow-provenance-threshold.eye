% Provenance-derived trust-flow thresholding in Eyelang.
%
% Each message combines publisher trust, signature strength, and transform quality
% into one confidence score.  Receiver-specific thresholds then classify messages
% as accepted or quarantined and derive status/risk facts.
%
% The multiplication chain is intentionally explicit so proof output shows how a
% provenance trail becomes a single trust decision.

materialize(confidence, 2).
materialize(trust_flow_state, 2).
materialize(status, 2).
materialize(risk, 2).

message(message_a, publisher_a, transform_a, signature_a, receiver_app).
message(message_b, publisher_b, transform_b, signature_b, receiver_app).

publisher_trust(publisher_a, 0.95).
publisher_trust(publisher_b, 0.70).
signature_strength(signature_a, 0.98).
signature_strength(signature_b, 0.75).
quality_score(transform_a, 0.96).
quality_score(transform_b, 0.80).
acceptance_threshold(receiver_app, 0.85).

confidence(?message, ?confidence) :-
  message(?message, ?publisher, ?transform, ?signature, ?_receiver),
  publisher_trust(?publisher, ?publishertrust),
  signature_strength(?signature, ?signaturetrust),
  quality_score(?transform, ?quality),
  mul(?publishertrust, ?signaturetrust, ?a),
  mul(?a, ?quality, ?confidence).

trust_flow_state(?message, fpv_accepted) :-
  message(?message, ?_publisher, ?_transform, ?_signature, ?receiver),
  confidence(?message, ?confidence),
  acceptance_threshold(?receiver, ?threshold),
  ge(?confidence, ?threshold).

trust_flow_state(?message, fpv_quarantine) :-
  message(?message, ?_publisher, ?_transform, ?_signature, ?receiver),
  confidence(?message, ?confidence),
  acceptance_threshold(?receiver, ?threshold),
  lt(?confidence, ?threshold).

status(?message, fpv_high_trust_flow) :- trust_flow_state(?message, fpv_accepted).
risk(?message, risk_low_trust_data_source) :- trust_flow_state(?message, fpv_quarantine).
