% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File INTERP.PL
% Meta-interpreter for Prolog

% interpret(+Goal)
%  Executes Goal.

interpret(true) :- !.

interpret((GoalA,GoalB)) :- !,
                            interpret(GoalA),
                            interpret(GoalB).

interpret(Goal) :-  clause(Goal,Body),
                    interpret(Body).


% Test knowledge base  (note the dynamic declarations!)

:- dynamic(parent/2).
parent(michael,cathy).
parent(melody,cathy).
parent(charles_gordon,michael).
parent(hazel,michael).
parent(jim,melody).
parent(eleanor,melody).

:- dynamic(grandparent/2).
grandparent(X,Y) :- parent(Z,Y), parent(X,Z).

test :- interpret(grandparent(A,B)), write([A,B]), nl, fail.
                                   % prints out all solutions
