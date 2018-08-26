% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File TOPLEVEL.PL
% A customized user interface for Prolog

% top_level
%  Starts the user interface.

top_level :-   repeat,
               nl,
               write('Type a query:            '),
               read(Goal),
               find_solutions(Goal),
               fail.


% find_solutions(+Goal)
%  Satisfies Goal, displays it with instantiations,
%  and optionally backtracks to find another solution.

find_solutions(Goal) :-
   call(Goal),
   write('Solution found:          '),
   write(Goal),
   nl,
   write('Look for another? (Y/N): '),
   get(Char), nl,
   (Char = 78 ; Char = 110),   % N or n
   !.

find_solutions(_) :-
   write('No (more) solutions'),
   nl.


% Demonstration knowledge base

father(michael,cathy).
mother(melody,cathy).
parent(X,Y) :- father(X,Y).
parent(X,Y) :- mother(X,Y).
