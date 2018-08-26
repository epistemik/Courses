% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File PRINTSQ.PL
% Prints squares of integers up to 5.
% Start with: ?- print_squares(1).

print_squares(I) :- I > 5, !.

print_squares(I) :-
  S is I*I,
  write(I), write('  '), write(S), nl,
  NewI is I+1,
  print_squares(NewI).

