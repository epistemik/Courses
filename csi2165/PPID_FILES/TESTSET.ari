% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

f(a,x).
f(a,y).
f(b,z).
f(b,zed).

test1 :- findall(X,f(_,X),L), write(L), nl.

test2 :- findall(X,(f(_,X),!),L), write(L), nl, fail.
test2 :- write('findall is opaque to cuts as it should be'), nl.

test3 :- write('Bagof, plain:'), bagof(X,f(_,X),L), write(L), nl, fail.

test4 :- write('Bagof, Y^ :'), bagof(X,Y^f(Y,X),L), write(L), nl, fail.

test5 :- write('Bagof, Term^Term :'),bagof(X,f(Y,X)^f(Y,X),L), write(L), 
nl, fail.

test6 :- bagof(X,(f(_,X),!),L), write(L), nl, fail.
test6 :- write('bagof is opaque to cuts as it should be'), nl.

test7 :- write('setof, plain:'), setof(X,f(_,X),L), write(L), nl, fail.

test8 :- write('setof, Y^ :'), setof(X,Y^f(Y,X),L), write(L), nl, fail.

test9 :- write('setof, Term^Term :'),setof(X,f(Y,X)^f(Y,X),L), write(L),
nl, fail.

test10 :- setof(X,(f(_,X),!),L), write(L), nl, fail.
test10 :- write('setof is opaque to cuts as it should be'), nl.


