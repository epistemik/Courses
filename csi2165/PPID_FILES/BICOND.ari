% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File BICOND.PL
% Inference engine for biconditionals in Prolog

% The -:- operator joins the two sides of a biconditional rule.

:- op(950,xfx,'-:-').


% Inference engine for biconditionals

prove(Goal)  :-  call(Goal).

prove(GoalA) :-  (GoalA -:- GoalB),
                 call(GoalB).

prove(GoalB) :-  (GoalA -:- GoalB),
                 call(GoalA).


% Sample knowledge base

dog(fido).
canine(rolf).
dog(X) -:- canine(X).

test :- prove(dog(X)), write(X), nl, fail.
                          % prints all solutions
