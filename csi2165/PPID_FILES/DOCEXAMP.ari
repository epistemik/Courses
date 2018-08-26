% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File DOCEXAMP.PL
% Examples of how to document Prolog predicates


% writename(+Number)
%  Writes "One", "Two", or "Three" to describe Number.
%  Fails if Number is not 1, 2, or 3.

writename(1) :- write('One').
writename(2) :- write('Two').
writename(3) :- write('Three').


% writeq_string(+String)
%  Given a list of ASCII codes, writes the
%  corresponding characters in quotes.

writeq_string(String) :-
   write('"'), write_string_aux(String), write('"').

writeq_string_aux([First|Rest]) :-
   put(First), write_string_aux(Rest).

writeq_string_aux([]).

  
% square(+X,-S)
%  Given X, computes X squared.

square(X,S) :-
   S is X*X.
     

% append(?List1,?List2,?List3)
%  Succeeds if List1 and List2, concatenated, make List3.

append([Head|Tail],X,[Head|Y]) :- append(Tail,X,Y).

append([],X,X).

