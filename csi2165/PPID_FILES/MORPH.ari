% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File MORPH.PL
% Parser with morphological analysis

sentence --> noun_phrase(N), verb_phrase(N).

noun_phrase(N) --> determiner(N), noun(N).

verb_phrase(N) --> verb(N), noun_phrase(_).
verb_phrase(N) --> verb(N), sentence.

determiner(singular) --> [a].
determiner(_)        --> [the].
determiner(plural)   --> [].

noun(N) --> [X], { morph(noun(N),X) }.
verb(N) --> [X], { morph(verb(N),X) }.


% morph(-Type,+Word)
%  succeeds if Word is a word-form
%  of the specified type.

morph(noun(singular),dog).       % Singular nouns
morph(noun(singular),cat).
morph(noun(singular),boy).
morph(noun(singular),girl).
morph(noun(singular),child).

morph(noun(plural),children).    % Irregular plural nouns

morph(noun(plural),X) :-         % Rule for regular plural nouns
     remove_s(X,Y),
     morph(noun(singular),Y).

morph(verb(plural),chase).       % Plural verbs
morph(verb(plural),see).
morph(verb(plural),say).
morph(verb(plural),believe).

morph(verb(singular),X) :-       % Rule for singular verbs
     remove_s(X,Y),
     morph(verb(plural),Y).


% remove_s(+X,-X1) [lifted from TEMPLATE.PL]
%  removes final S from X giving X1,
%  or fails if X does not end in S.

remove_s(X,X1) :-
     name(X,XList),
     remove_s_list(XList,X1List),
     name(X1,X1List).

remove_s_list("s",[]).

remove_s_list([Head|Tail],[Head|NewTail]) :-
     remove_s_list(Tail,NewTail).
