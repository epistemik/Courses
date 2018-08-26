% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File LISTPROC.PL
% Basic list processing predicates from Chapter 3

% NOTE: member, append, and reverse are built--in predicates
%   in some Prologs.


member(X,[X|_]).                                    % Clause 1

member(X,[_|Ytail]) :- member(X,Ytail).             % Clause 2



list_length([],0).

list_length([_|Tail],K) :- list_length(Tail,J),
                           K is J+1.



append([],X,X).                                     % Clause 1

append([X1|X2],Y,[X1|Z]) :- append(X2,Y,Z).         % Clause 2




reverse([],[]).                                     % Clause 1

reverse([Head|Tail],Result) :-                      % Clause 2
               reverse(Tail,ReversedTail),
               append(ReversedTail,[Head],Result).



fast_reverse(Original,Result) :-
   nonvar(Original),
   fast_reverse_aux(Original,[],Result).

fast_reverse_aux([Head|Tail],Stack,Result) :-
   fast_reverse_aux(Tail,[Head|Stack],Result).

fast_reverse_aux([],Result,Result).
