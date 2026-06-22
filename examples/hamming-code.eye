% Technology example: Hamming(7,4) single-bit error correction.
%
% The received word has one corrupted bit. Syndrome bits identify the bad
% position, then the corrected codeword and decoded payload are derived.

% Output declarations: materialize/2 selects the relations written to this example's golden output.
%
% Positions are one-based to match the textbook parity-check layout. The
% syndrome value is both the error certificate and the index of the bit to fix.
materialize(syndrome, 2).
materialize(errorBit, 2).
materialize(correctedCodeword, 2).
materialize(decodedPayload, 2).
materialize(status, 2).
materialize(reason, 2).

% Program structure: facts set up the scenario, and rules derive the materialized conclusions.
received_bit(packet1, 1, 1).
received_bit(packet1, 2, 0).
received_bit(packet1, 3, 1).
received_bit(packet1, 4, 1).
received_bit(packet1, 5, 1).
received_bit(packet1, 6, 1).
received_bit(packet1, 7, 0).

flip(0, 1).
flip(1, 0).

% Derivation rules: each rule below contributes one logical step toward the displayed results.
parity4(?a, ?b, ?c, ?d, ?parity) :-
  add(?a, ?b, ?ab),
  add(?ab, ?c, ?abc),
  add(?abc, ?d, ?sum),
  mod(?sum, 2, ?parity).

syndrome_bit1(?code, ?s1) :-
  received_bit(?code, 1, ?b1),
  received_bit(?code, 3, ?b3),
  received_bit(?code, 5, ?b5),
  received_bit(?code, 7, ?b7),
  parity4(?b1, ?b3, ?b5, ?b7, ?s1).

syndrome_bit2(?code, ?s2) :-
  received_bit(?code, 2, ?b2),
  received_bit(?code, 3, ?b3),
  received_bit(?code, 6, ?b6),
  received_bit(?code, 7, ?b7),
  parity4(?b2, ?b3, ?b6, ?b7, ?s2).

syndrome_bit4(?code, ?s4) :-
  received_bit(?code, 4, ?b4),
  received_bit(?code, 5, ?b5),
  received_bit(?code, 6, ?b6),
  received_bit(?code, 7, ?b7),
  parity4(?b4, ?b5, ?b6, ?b7, ?s4).

% syndrome/2 combines parity checks as S1 + 2*S2 + 4*S4.
syndrome(?code, ?syndrome) :-
  syndrome_bit1(?code, ?s1),
  syndrome_bit2(?code, ?s2),
  syndrome_bit4(?code, ?s4),
  mul(?s2, 2, ?weighteds2),
  mul(?s4, 4, ?weighteds4),
  add(?s1, ?weighteds2, ?partial),
  add(?partial, ?weighteds4, ?syndrome).

corrected_bit(?code, ?position, ?corrected) :-
  syndrome(?code, ?position),
  received_bit(?code, ?position, ?bit),
  flip(?bit, ?corrected).

corrected_bit(?code, ?position, ?bit) :-
  syndrome(?code, ?errorposition),
  neq(?position, ?errorposition),
  received_bit(?code, ?position, ?bit).

corrected_codeword(?code, [?b1, ?b2, ?b3, ?b4, ?b5, ?b6, ?b7]) :-
  corrected_bit(?code, 1, ?b1),
  corrected_bit(?code, 2, ?b2),
  corrected_bit(?code, 3, ?b3),
  corrected_bit(?code, 4, ?b4),
  corrected_bit(?code, 5, ?b5),
  corrected_bit(?code, 6, ?b6),
  corrected_bit(?code, 7, ?b7).

decoded_payload(?code, [?d1, ?d2, ?d3, ?d4]) :-
  corrected_bit(?code, 3, ?d1),
  corrected_bit(?code, 5, ?d2),
  corrected_bit(?code, 6, ?d3),
  corrected_bit(?code, 7, ?d4).


errorBit(?code, ?position) :-
  syndrome(?code, ?position),
  gt(?position, 0).

correctedCodeword(?code, ?codeword) :-
  corrected_codeword(?code, ?codeword).

decodedPayload(?code, ?payload) :-
  decoded_payload(?code, ?payload).

status(?code, single_bit_corrected) :-
  syndrome(?code, ?position),
  gt(?position, 0).

reason(?code, "Hamming syndrome identifies the flipped bit position") :-
  syndrome(?code, ?position),
  gt(?position, 0).
