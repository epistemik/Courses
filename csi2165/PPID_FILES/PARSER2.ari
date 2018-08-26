% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File PARSER2.PL
% A parser using grammar rule notation

sentence --> noun_phrase, verb_phrase.

noun_phrase --> determiner, noun.

verb_phrase --> verb, noun_phrase.
verb_phrase --> verb, sentence.

determiner --> [the].
determiner --> [a].

noun --> [dog].
noun --> [cat].
noun --> [boy].
noun --> [girl].

verb --> [chased].
verb --> [saw].
verb --> [said].
verb --> [believed].
