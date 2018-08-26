% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File BEST.PL
% Techniques for finding the "best" solution
% (in this case, identifying the youngest child)

age(cathy,8).
age(sharon,4).
age(aaron,3).
age(stephanie,7).
age(danielle,4).


test1 :- setof(A,N^age(N,A),[Youngest|_]),
         write(Youngest), nl.

test2 :- setof([A,N],N^age(N,A),[[_,Youngest]|_]),
         write(Youngest), nl.

test3 :- age(Youngest,Age),
         \+ (age(_,Age2), Age2 < Age),
         write(Youngest), nl.
