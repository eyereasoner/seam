% Compact web-style terms without full URIs or global prefix tables.
%
% RDF-style URIs are globally meaningful but long, while QNames such as
% schema:Person depend on an external prefix declaration.  This example uses an
% eyelang-native alternative: web(Space, Local).  The first argument is an
% ISO-compatible quoted atom naming a vocabulary, organization, or authority;
% the second argument is the local name inside that space.
%
% The important property is that the complete term is self-contained.  The local
% name josd can safely occur in two spaces: web('be.ugent', josd) and
% web('com.example', josd) are different Herbrand terms, so there is no hidden
% prefix context and no accidental collision.  Tooling can still expand selected
% web/2 terms to full URI strings when a base is known.

materialize(web_uri, 2).
materialize(affiliated_with, 2).
materialize(project_contact, 3).
materialize(same_local_name, 3).

% Optional URI bases for spaces that we want to publish or display.
space_base('be.ugent', "https://data.ugent.be/id/").
space_base('com.example', "https://example.com/id/").
space_base('eyereasoner.github', "https://github.com/eyereasoner/").
space_base('org.schema', "https://schema.org/").

% A tiny graph using globally scoped web terms as ordinary eyelang terms.
triple(web('be.ugent', josd), web('org.schema', name), "Jos De Roo").
triple(web('be.ugent', josd), web('org.schema', email), "josderoo@gmail.com").
triple(web('be.ugent', josd), web('org.schema', affiliation), web('be.ugent', idlab)).
triple(web('be.ugent', idlab), web('org.schema', parentOrganization), web('be.ugent', ugent)).

triple(web('eyereasoner.github', eyelang), web('org.schema', name), "eyelang").
triple(web('eyereasoner.github', eyelang), web('org.schema', codeRepository), "https://github.com/eyereasoner/eyelang").
triple(web('eyereasoner.github', eyelang), web('org.schema', maintainer), web('be.ugent', josd)).

% Same local spelling, different global identity.
triple(web('com.example', josd), web('org.schema', name), "Another JosD in another space").

% Keep URI expansion explicit and optional: reasoning uses web/2 terms, while
% web_uri/2 is only a presentation bridge for selected names.
published_name(web('be.ugent', josd)).
published_name(web('com.example', josd)).
published_name(web('be.ugent', idlab)).
published_name(web('be.ugent', ugent)).
published_name(web('eyereasoner.github', eyelang)).
published_name(web('org.schema', maintainer)).

web_uri(web(?space, ?local), ?uri) :-
    published_name(web(?space, ?local)),
    space_base(?space, ?base),
    atom_string(?local, ?localtext),
    str_concat(?base, ?localtext, ?uri).

% Organization membership follows parentOrganization links transitively.
parent_organization(?unit, ?org) :-
    triple(?unit, web('org.schema', parentOrganization), ?org).
parent_organization(?unit, ?org) :-
    triple(?unit, web('org.schema', parentOrganization), ?mid),
    parent_organization(?mid, ?org).

affiliated_with(?person, ?org) :-
    triple(?person, web('org.schema', affiliation), ?org).
affiliated_with(?person, ?org) :-
    triple(?person, web('org.schema', affiliation), ?unit),
    parent_organization(?unit, ?org).

% A project contact is derived by joining the project's maintainer with the
% maintainer's email.  The join works because both facts use the same complete
% web('be.ugent', josd) term.
project_contact(?project, ?person, ?email) :-
    triple(?project, web('org.schema', maintainer), ?person),
    triple(?person, web('org.schema', email), ?email).

% Demonstrate that local names are not global names.  This reports the deliberate
% local-name collision without treating the two people as equal.
local_name(?entity, ?local) :-
    triple(?entity, web('org.schema', name), ?_),
    eq(?entity, web(?_, ?local)).

same_local_name(?a, ?b, ?local) :-
    local_name(?a, ?local),
    local_name(?b, ?local),
    lt(?a, ?b).
