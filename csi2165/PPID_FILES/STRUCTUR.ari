% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File STRUCTUR.PL
% Parser like PARSER2.PL, but building a
% parse tree while parsing

sentence(sentence(X,Y)) -->
   noun_phrase(X), verb_phrase(Y).

noun_phrase(noun_phrase(X,Y)) -->
   determiner(X), noun(Y).

verb_phrase(verb_phrase(X,Y)) -->
   verb(X), noun_phrase(Y).
verb_phrase(verb_phrase(X,Y)) -->
   verb(X), sentence(Y).

determiner(determiner(the)) --> [the].
determiner(determiner(a)) --> [a].

noun(noun(dog)) --> [dog].
noun(noun(cat)) --> [cat].
noun(noun(boy)) --> [boy].
noun(noun(girl)) --> [girl].

verb(verb(chased)) --> [chased].
verb(verb(saw)) --> [saw].
verb(verb(said)) --> [said].
verb(verb(believed)) --> [believed].
