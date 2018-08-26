% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% Some tests of the scope of cuts

test1 :-  test1a, fail.
test1.

test1a :- ( f(a) -> ! ; f(b) ).
test1a :- write('Ifthenelse is NOT transparent to cut'),nl.
test1a :- write('This clause should NOT execute'),nl.

test2 :-  test2a, fail.
test2.

test2a :- \+ (f(a), !).
test2a :- write('\+ is NOT transparent to cut'),nl.
test2a :- write('This clause should NOT execute'),nl.

test3 :-  test3a, fail.
test3.

test3a :- f(a), ! ; f(b).
test3a :- write('Disjunction is NOT transparent to cut'),nl.
test3a :- write('This clause should NOT execute'),nl.

test4 :- test4a, fail.
test4.

test4a :- call((f(What),write(What),!)).
test4a :- write('call is opaque to cuts').

test5  :- test5a, fail.
test5a :- (f(What), write(What), !) -> true.
test5a :- write('Left arg of -> is opaque as it should be'),nl.

test6 :- test6a, fail.
test6a :- G = ((f(What),write(What),!)), G.
test6a :- write('variable goal is opaque to cuts').


% Grist for the mill

f(a).
f(b).
