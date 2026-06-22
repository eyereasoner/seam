% Eyelang language-identity example.
%
% This file intentionally uses the modern Eyelang surface syntax:
%   - `.eye` source files instead of Prolog `.pl` files
%   - `?` variables instead of Prolog-style uppercase variables
%   - `table/2` for tabled recursive predicates
%   - advisory `mode/3` and `semidet/2` declarations
%   - angle-bracket IRI atoms for web-shaped identifiers
%
% The declarations below are ordinary facts as well as metadata for tooling.
% They do not change the answers of the program.

materialize(path, 2).

table(path, 2).
mode(edge, 2, [in, out]).
mode(path, 2, [in, out]).
semidet(edge, 2).

edge(<urn:example:a>, <urn:example:b>).
edge(<urn:example:b>, <urn:example:c>).
edge(<urn:example:c>, <urn:example:d>).

path(?x, ?y) :- edge(?x, ?y).
path(?x, ?z) :- edge(?x, ?y), path(?y, ?z).
