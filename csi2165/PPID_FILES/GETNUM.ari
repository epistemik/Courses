% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File GETNUM.PL
% Examples of how to validate user input

:- ensure_loaded('readstr.pl').  % or use reconsult if necessary


get_choice(C) :- repeat,
                   write('Type a, b, or c: '),
                   read_atom(C),
                   member(C,[a,b,c]),
                  !.

member(X,[X|_]).
member(X,[_|Y]) :- member(X,Y).



get_ok(C) :- repeat,
               write('Type a, b, or c: '),
               read_atom(C),
               ok(C),
             !.

ok(a).
ok(b).
ok(c).


% The following is ISO Prolog:

read_num_or_fail(N) :-  catch(read_num(N),_,fail).

