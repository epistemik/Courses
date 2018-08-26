% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File PARSER1.PL
% Simple parser using Prolog rules

sentence(X,Z) :- noun_phrase(X,Y),
                 verb_phrase(Y,Z).

noun_phrase(X,Z) :- determiner(X,Y),
                    noun(Y,Z).

verb_phrase(X,Z) :- verb(X,Y),
                    noun_phrase(Y,Z).

verb_phrase(X,Z) :- verb(X,Y),
                    sentence(Y,Z).

determiner([the|Z],Z).
determiner([a|Z],Z).

noun([dog|Z],Z).
noun([cat|Z],Z).
noun([boy|Z],Z).
noun([girl|Z],Z).

verb([chased|Z],Z).
verb([saw|Z],Z).
verb([said|Z],Z).
verb([believed|Z],Z).
