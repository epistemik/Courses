% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

:- ensure_loaded(library(benchmark)).

:- ensure_loaded('testdata.pl').


:- ensure_loaded('myqsort.pl').

testq1 :- write('quicksort, 10, random'), nl,
              testlist(random,10,L),time(quicksort(L,_),1000).
testq2 :- write('quicksort, 100, random'), nl,
              testlist(random,100,L),time(quicksort(L,_),100).
testq3 :- write('quicksort, 1000, random'), nl,
              testlist(random,1000,L),time(quicksort(L,_),10).

testq4 :- write('quicksort, 10, almost sorted'), nl,
              testlist(almost_sorted,10,L),time(quicksort(L,_),1000).
testq5 :- write('quicksort, 100, almost sorted'), nl,
              testlist(almost_sorted,100,L),time(quicksort(L,_),100).
testq6 :- write('quicksort, 1000, almost sorted'), nl,
              testlist(almost_sorted,1000,L),time(quicksort(L,_),10).

testq7 :- write('quicksort, 10, almost backward'), nl,
              testlist(almost_backward,10,L),time(quicksort(L,_),1000).
testq8 :- write('quicksort, 100, almost backward'), nl,
              testlist(almost_backward,100,L),time(quicksort(L,_),100).
testq9 :- write('quicksort, 1000, almost backward'), nl,
              testlist(almost_backward,1000,L),time(quicksort(L,_),10).



all :- 
%  tests1, tests2, tests3, tests4, tests5, tests6, tests7, tests8, tests9,
%  testm1, testm2, testm3, testm4, testm5, testm6, testm7, testm8, testm9,
  testq1, testq2, testq3, testq4, testq5, testq6, testq7, testq8, testq9,
%  testdlq1, testdlq2, testdlq3, testdlq4, testdlq5, testdlq6, testdlq7, testdlq8, testdlq9,
%  testiq1, testiq2, testiq3, testiq4, testiq5, testiq6, testiq7, testiq8, testiq9,
%  testt1, testt2, testt3, testt4, testt5, testt6, testt7, testt8, testt9,
   true.








