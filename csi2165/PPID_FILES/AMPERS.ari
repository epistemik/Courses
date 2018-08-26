% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File AMPERS.PL
% How to make the ampersand mean "and" in Prolog

% Syntax of &

:- op(950,xfy,&).


% Semantics of &

GoalA & GoalB :- call(GoalA), call(GoalB).

% Demonstration knowledge base

parent(michael,cathy).
parent(melody,cathy).
parent(charles_gordon,michael).
parent(hazel,michael).
parent(jim,melody).
parent(eleanor,melody).

grandparent(X,Y) :- parent(Z,Y) & parent(X,Z).

only_child(X) :- parent(P,X) & \+ (parent(P,Z) & Z\==X).

test :- only_child(C), write(C), write(' is an only child'), nl.
