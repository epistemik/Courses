% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% count(X)
%   Unifies X with the number of times count/1 has been called.

count(X) :- retract(count_aux(N)),
            X is N+1,
            asserta(count_aux(X)).

:- dynamic(count_aux/1).

count_aux(0).
