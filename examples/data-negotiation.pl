% Data negotiation with policies, adapted from Eyelet input/data-negotiation.pl.
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

policy(agent1, [request, Data]) :-
  member(Data, [data4, data6]).
policy(agent2, [accept, Data]) :-
  neq(Data, data5).

% A request is possible only if A lacks the data and A's policy allows asking for it.
request_data(AgentA, AgentB, Data) :-
  hasData(AgentA, DataListA),
  hasData(AgentB, DataListB),
  member(Data, DataListB),
  not_member(Data, DataListA),
  policy(AgentA, [request, Data]).

% B accepts only requests for data it has and its own policy permits sharing.
accept_request(AgentB, _AgentA, Data) :-
  hasData(AgentB, DataListB),
  member(Data, DataListB),
  policy(AgentB, [accept, Data]).

negotiate(AgentA, [AgentB, Data]) :-
  want_negotiate(AgentA, [AgentB, Data]),
  request_data(AgentA, AgentB, Data),
  accept_request(AgentB, AgentA, Data).
