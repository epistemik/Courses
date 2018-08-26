% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File MSORT.PL
% Mergesort


% msort(+List1,-List2)
%  Sorts List1 giving List2 using mergesort.

msort([First,Second|Rest],Result) :-   % list has at least 2 elements
  !,
  partition([First,Second|Rest],L1,L2),
  msort(L1,SL1),
  msort(L2,SL2),
  merge(SL1,SL2,Result).

msort(List,List).                      % list has 0 or 1 element



% merge(+List1,+List2,-Result)
%  Combines two sorted lists into a sorted list.

merge([First1|Rest1],[First2|Rest2],[First1|Rest]) :-
  First1 @< First2,
  !,
  merge(Rest1,[First2|Rest2],Rest).

merge([First1|Rest1],[First2|Rest2],[First2|Rest]) :-
  \+ First1 @< First2,
  !,
  merge([First1|Rest1],Rest2,Rest).

merge(X,[],X).

merge([],X,X).



% partition(+List,-List1,-List2)
%  splits List in two the simplest way,
%  by putting alternate members in different lists

partition([First,Second|Rest],[First|F],[Second|S]) :-  % 2 or more elements
   !,
   partition(Rest,F,S).

partition(List,List,[]).                                % 0 or 1 element



% Demonstration predicate

test :- treesort([7,0,6,5,4,9,4,6,3,3],What), write(What).
