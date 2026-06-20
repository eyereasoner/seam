% Compact web-style names without full URIs or global prefix tables.
%
% RDF-style URIs are globally meaningful but long, while QNames such as
% schema:Person depend on an external prefix declaration.  This example uses an
% eyelang-native alternative: web(Space, Local).  The first argument is a dotted
% atom that names a vocabulary, organization, or authority; the second argument
% is the local name inside that space.
%
% The important property is that the complete term is self-contained.  The local
% name jos can safely occur in two spaces: web(be.ugent, jos) and
% web(com.example, jos) are different Herbrand terms, so there is no hidden
% prefix context and no accidental collision.  Tooling can still expand selected
% web/2 terms to full URI strings when a base is known.

materialize(web_uri, 2).
materialize(affiliated_with, 2).
materialize(project_contact, 3).
materialize(same_local_name, 3).

% Optional URI bases for spaces that we want to publish or display.
space_base(be.ugent, "https://data.ugent.be/id/").
space_base(com.example, "https://example.com/id/").
space_base(eyereasoner.github, "https://github.com/eyereasoner/").
space_base(org.schema, "https://schema.org/").

% A tiny graph using globally scoped web names as ordinary eyelang terms.
triple(web(be.ugent, jos), web(org.schema, name), "Jos De Roo").
triple(web(be.ugent, jos), web(org.schema, email), "josderoo@gmail.com").
triple(web(be.ugent, jos), web(org.schema, affiliation), web(be.ugent, idlab)).
triple(web(be.ugent, idlab), web(org.schema, parentOrganization), web(be.ugent, ugent)).

triple(web(eyereasoner.github, eyelang), web(org.schema, name), "eyelang").
triple(web(eyereasoner.github, eyelang), web(org.schema, codeRepository), "https://github.com/eyereasoner/eyelang").
triple(web(eyereasoner.github, eyelang), web(org.schema, maintainer), web(be.ugent, jos)).

% Same local spelling, different global identity.
triple(web(com.example, jos), web(org.schema, name), "Another Jos in another space").

% Keep URI expansion explicit and optional: reasoning uses web/2 terms, while
% web_uri/2 is only a presentation bridge for selected names.
published_name(web(be.ugent, jos)).
published_name(web(com.example, jos)).
published_name(web(be.ugent, idlab)).
published_name(web(be.ugent, ugent)).
published_name(web(eyereasoner.github, eyelang)).
published_name(web(org.schema, maintainer)).

web_uri(web(Space, Local), URI) :-
    published_name(web(Space, Local)),
    space_base(Space, Base),
    atom_string(Local, LocalText),
    str_concat(Base, LocalText, URI).

% Organization membership follows parentOrganization links transitively.
parent_organization(Unit, Org) :-
    triple(Unit, web(org.schema, parentOrganization), Org).
parent_organization(Unit, Org) :-
    triple(Unit, web(org.schema, parentOrganization), Mid),
    parent_organization(Mid, Org).

affiliated_with(Person, Org) :-
    triple(Person, web(org.schema, affiliation), Org).
affiliated_with(Person, Org) :-
    triple(Person, web(org.schema, affiliation), Unit),
    parent_organization(Unit, Org).

% A project contact is derived by joining the project's maintainer with the
% maintainer's email.  The join works because both facts use the same complete
% web(be.ugent, jos) term.
project_contact(Project, Person, Email) :-
    triple(Project, web(org.schema, maintainer), Person),
    triple(Person, web(org.schema, email), Email).

% Demonstrate that local names are not global names.  This reports the deliberate
% local-name collision without treating the two people as equal.
local_name(Entity, Local) :-
    triple(Entity, web(org.schema, name), _),
    eq(Entity, web(_, Local)).

same_local_name(A, B, Local) :-
    local_name(A, Local),
    local_name(B, Local),
    lt(A, B).
