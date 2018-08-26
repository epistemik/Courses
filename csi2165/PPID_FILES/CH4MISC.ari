% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File CH4MISC.PL
% Miscellaneous predicates from Chapter 4


% writename(+Number)
%  Writes "One", "Two", or "Three" to describe Number.
%  Fails if Number is not 1, 2, or 3.

writename(1) :- write('One').
writename(2) :- write('Two').
writename(3) :- write('Three').


% write_string(+String)
%  Given a list of ASCII codes, writes the
%  corresponding characters in quotes.

write_string(String) :-
   write('"'), write_string_aux(String), write('"').

write_string_aux([First|Rest]) :-
   put(First), write_string_aux(Rest).

write_string_aux([]).



% square_root(+X,-SqrtX)
%  Given X, computes square root of X.

square_root(X,SqrtX) :-
   SqrtX is sqrt(X).



% append(?List1,?List2,?List3)
%  Succeeds if List1 and List2, concatenated, make List3.

append([Head|Tail],X,[Head|Y]) :- append(Tail,X,Y).

append([],X,X).
