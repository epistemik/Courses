% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% TAILREC.PL
% Tests of tail recursion from Chapter 4


% test1 is tail recursive; "?- test1(0)." should run forever.

test1(N) :- write(N), nl, NewN is N+1, test1(NewN).


% test2 is not tail recursive because the recursive call is not last.

test2(N) :- write(N), nl, NewN is N+1, test2(NewN), nl.


% test3 is not tail recursive because there is an untried alternative.

test3(N) :- write(N), nl, NewN is N+1, test3(NewN).
test3(N) :- N<0.


% test3a is tail recursive because the clauses have been swapped.

test3a(N) :- N<0.
test3a(N) :- write(N), nl, NewN is N+1, test3a(NewN).


% test4 is not tail recursive because of alternatives to m/2.

test4(N) :- write(N), nl, m(N,NewN), test4(NewN).

m(N,NewN) :- N>=0, NewN is N+1.
m(N,NewN) :- N<0, NewN is (-1)*N.


% test5 is tail recursive because of the cut.

test5(N) :- write(N), nl, NewN is N+1, !, test5(NewN).
test5(N) :- N<0.


% test6 is tail recursive because of the cut.

test6(N) :- write(N), nl, m(N,NewN), !, test6(NewN).


% test7 is tail recursive; 2 predicates call each other.

test7(N) :- write(N), nl, test7a(N).
test7a(N) :-  NewN is N+1, test7(NewN).


% test8 is tail recursive because of indexing.

test8(0) :- write('Still going'), nl, test8(0).
test8(-1).

