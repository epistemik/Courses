% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% Utility predicates

member(X,[X|_]).
member(X,[_|Y]) :- member(X,Y).

reverse([],X,X).
reverse([X|Y],Z,W) :- reverse(Y,[X|Z],W).

one(Goal) :-
	Goal,
	!.

city(X) :- data(X,_,_,_).
city(X) :- data(_,X,_,_).

