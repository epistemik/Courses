% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% Hacked to use user-defined append/2
% File QSORT.PL
% Several versions of Quicksort

% partition(+List,+Pivot,-Before,-After)
%  Divides List into two lists, one
%  containing elements that should
%  come before Pivot, the other containing
%  elements that should come after it.
%  Used in all versions of Quicksort.

partition([X|Tail],Pivot,[X|Before],After) :-   % X precedes Pivot
   X @< Pivot,
   !,
   partition(Tail,Pivot,Before,After).

partition([X|Tail],Pivot,Before,[X|After]) :-   % X follows Pivot
   !,
   partition(Tail,Pivot,Before,After).

partition([],_,[],[]).                          % Empty list


% Original Quicksort algorithm
% (Sterling and Shapiro, 1986:56; Clocksin and Mellish 1984:157)

quicksort([X|Tail],Result) :-
   !,
   partition(Tail,X,Before,After),
   quicksort(Before,SortedBefore),
   quicksort(After,SortedAfter),
   app(SortedBefore,[X|SortedAfter],Result).

quicksort([],[]).

app([],X,X).
app([X|Tail],Y,[X|Z]) :- app(Tail,Y,Z).
%  already built-in in Quintus 3


% Quicksort with difference lists
%  (Sterling and Shapiro 1986:244)

dlqsort(List,Result) :- quicksort_dl(List,Result/[]).

quicksort_dl([X|Tail],Result/ResultTail) :-
   !,
   partition(Tail,X,Before,After),
   quicksort_dl(Before,Result/[X|Z]),
   quicksort_dl(After,Z/ResultTail).

quicksort_dl([],X/X).


% Improved Quicksort using "stacks"
%  (separate variables for the tail of the list)
%  (Kluzniak and Szpakowicz 1985; Clocksin and Mellish 1984:157)

iqsort(List,Result) :- iqsort_aux(List,[],Result).

iqsort_aux([X|Tail],Stack,Result) :-
   !,
   partition(Tail,X,Before,After),
   iqsort_aux(After,Stack,NewStack),
   iqsort_aux(Before,[X|NewStack],Result).

iqsort_aux([],Stack,Stack).



% Demonstration predicates

test1 :- quicksort([7,0,6,5,4,9,4,6,3,3],What), write(What).
test2 :- dlqsort([7,0,6,5,4,9,4,6,3,3],What),   write(What).
test3 :- iqsort([7,0,6,5,4,9,4,6,3,3],What),    write(What).

