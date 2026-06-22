% Deontic logic: obligations, prohibitions, compensations, and violations.
% The example separates normative facts from observed actions.  Missing an
% obligation and performing a prohibited action are violations, but a prohibited
% action can be marked compensated when the configured repair action occurred.

materialize(violation, 2).
materialize(compensation, 2).
materialize(status, 2).

% Facts state what the actor was obliged/prohibited to do and what happened.
actor(alice).
action(share_record).
action(delete_unneeded_copy).

obliged(alice, obtain_consent).
prohibited(alice, share_record).
compensates(share_record, notify_dpo).

performed(alice, share_record).
performed(alice, notify_dpo).
not_performed(alice, obtain_consent).
not_performed(alice, delete_unneeded_copy).

% Missing an obligation and performing a prohibited action are both violations.
violation(?actor, missed_obligation(?action)) :-
  obliged(?actor, ?action),
  not_performed(?actor, ?action).

violation(?actor, prohibited_action(?action)) :-
  prohibited(?actor, ?action),
  performed(?actor, ?action).

% Some prohibited actions can be repaired by a configured compensation action.
compensated_violation(?actor, ?action, ?compensation) :-
  prohibited(?actor, ?action),
  performed(?actor, ?action),
  compensates(?action, ?compensation),
  performed(?actor, ?compensation).

uncompensated_violation(?actor, missed_obligation(?action)) :-
  violation(?actor, missed_obligation(?action)).

uncompensated_violation(?actor, prohibited_action(?action)) :-
  violation(?actor, prohibited_action(?action)),
  not(compensated_violation(?actor, ?action, ?_compensation)).


compensation(?actor, compensation(?action, ?compensation)) :-
  compensated_violation(?actor, ?action, ?compensation).

status(?actor, requires_review) :-
  uncompensated_violation(?actor, ?_violation).
