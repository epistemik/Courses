% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File REWRITET.PL
% Michael A. Covington
% Natural Language Processing for Prolog Programmers
% (Prentice-Hall)
% Appendix A, section A.7.4

% rewrite_term(+Term1,?Term2)
%  Copies Term1 changing every atom or functor 'a' to 'b'

rewrite_term(X,X) :-
   var(X),          % don't alter uninstantiated variables
   !.

rewrite_term(X,Y) :-
   atomic(X),       % 'atomic' means atom or number
   !,
   rewrite(X,Y).

rewrite_term(X,Y) :-
   X =.. XList,                % convert structures to lists
   rewrite_aux(XList,YList),   % process them
   Y =.. YList.                % convert back to structures

rewrite_aux([],[]).

rewrite_aux([First|Rest],[NewFirst|NewRest]) :-
   rewrite_term(First,NewFirst),   % note recursion here
   rewrite_aux(Rest,NewRest).


rewrite(a,b) :- !.
rewrite(X,X).

