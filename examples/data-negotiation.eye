% Data negotiation with policies, adapted from Eyelet input/data-negotiation.eye.
% Two agents own different datasets.  A negotiation succeeds only when the
% requester lacks the data, the provider has it, the requester policy allows
% asking for it, and the provider policy allows sharing it.

materialize(negotiate, 2).

% Each agent has local data, desired remote data, and a simple policy.
hasData(agent1, [data1, data2, data3]).
hasData(agent2, [data4, data5, data6]).

want_negotiate(agent1, [agent2, data4]).
want_negotiate(agent1, [agent2, data5]).
want_negotiate(agent1, [agent2, data7]).

policy(agent1, [request, ?data]) :-
  member(?data, [data4, data6]).
policy(agent2, [accept, ?data]) :-
  neq(?data, data5).

% A request is possible only if A lacks the data and A's policy allows asking for it.
request_data(?agenta, ?agentb, ?data) :-
  hasData(?agenta, ?datalista),
  hasData(?agentb, ?datalistb),
  member(?data, ?datalistb),
  not_member(?data, ?datalista),
  policy(?agenta, [request, ?data]).

% B accepts only requests for data it has and its own policy permits sharing.
accept_request(?agentb, ?_agenta, ?data) :-
  hasData(?agentb, ?datalistb),
  member(?data, ?datalistb),
  policy(?agentb, [accept, ?data]).

negotiate(?agenta, [?agentb, ?data]) :-
  want_negotiate(?agenta, [?agentb, ?data]),
  request_data(?agenta, ?agentb, ?data),
  accept_request(?agentb, ?agenta, ?data).
