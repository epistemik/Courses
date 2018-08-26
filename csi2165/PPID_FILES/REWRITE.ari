% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File REWRITE.PL
% Example of searching an arbitrary term using =..

% rewrite(X,Y)
%  Tells rewrite_term what to rewrite.

rewrite(a,b) :- !.   % change all a to b
rewrite(X,X).        % leave everything else alone


% rewrite_term(+Term1,-Term2)
%  Copies Term1 changing every atom or functor 'a' to 'b'
%  (using rewrite/2 above).

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
