% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File VARGOALS.PL
% Predicates involving variable goals, from Chapter 3

:- reconsult('family.pl').     % use ensure_loaded if available
:- reconsult('readstr.pl').  

answer_question :-
       write('Mother or father? '),
       read_atom(X),
       write('Of whom? '),
       read_atom(Y),
       Q =.. [X,Who,Y],
       call(Q),
       write(Who),
       nl.


% apply(Functor,Arglist)
%   Constructs and executes a query.

apply(Functor,Arglist) :-
        Query =.. [Functor|Arglist],
        call(Query).
