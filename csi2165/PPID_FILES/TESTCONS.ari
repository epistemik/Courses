% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File TESTCONS.PL
% Michael A. Covington
% Natural Language Processing for Prolog Programmers
% (Prentice-Hall)
% Appendix A, section A.5.1

% This file can be used to test consult/1 and reconsult/1.

% Consult this file and run test/0 to see if clauses must be contiguous.
% Consult it again and see if clauses for f1/1 are duplicated.
% Then reconsult it and see if the duplicates are removed.
% Finally, run test/1 to see if reconsult/1 requires clauses to be contiguous.

f1('The first clause was preserved even though discontiguous.').

f2(x).

f1('The first clause was discarded when a new block of clauses was found.').
f1(x).

test :- f1(Message), !, write(Message), nl.

