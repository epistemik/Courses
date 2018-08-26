% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File TESTMISC.PL
% Michael A. Covington
% Natural Language Processing for Prolog Programmers
% (Prentice-Hall)
% Appendix A, passim

% Miscellaneous tests of the syntax and
%  semantics of your Prolog implementation.

% Parts of this file may be syntax errors under
%  any particular implementation; just delete them.

test1 :- (write(yes) -> write(' got it ') ; true).
  % If this writes "yes got it", then "if-then-else" is supported.
  % Draft ISO standard says it should be.

test2 :- Goal = write(yes), Goal.
  % If this succeeds, variable goals are supported.
  % Draft ISO standard says Goal is identical to call(Goal) (7.6.2).

test3 :- assert(yes(yes)), retractall(yes(_)).
  % If this succeeds, retractall is supported.
  % Draft ISO standard does not call for it to be.

test4 :- assert(yes(yes)), abolish(yes/1).
  % If this succeeds, abolish is supported.
  % Draft ISO standard says it should be.

test5 :- writeq('hello there').
  % Tests whether writeq is supported.
  % Draft ISO standard says it should be.

test6 :- test6(0).
  % Runs endlessly if a cut can make a clause tail recursive.

test6(N) :- write(N), nl, !, NewN is N+1, test6(NewN).
test6(_).

test7 :- test7(0).
  % Runs endlessly if indexing can make a clause tail recursive.

test7(N) :- write(N), nl, !, NewN is N+1, test7(NewN).
test7(-1).

test8  :- \+ \+ write('Negation can be written \+').
test9  :- not not write('Negation can be written not').
test10 :- fail_if( fail_if( write('Negation can be written fail_if'))).
  % One or more of these will probably be a syntax error.
  % Draft ISO standard says only test10 should succeed.

test11 :- retract((test7 :- Body)).
  % If this does not cause an error message,
  % then :- dynamic is not required in order to retract a clause.

% Test the syntax for goals embedded in a Prolog file.
% Most Prologs execute both of the goals below at consult time.
% Draft ISO standard does not say how to pass a goal to Prolog.
  :- write('This goal is marked with :-'),nl.
  ?- write('This goal is marked with ?-'),nl.

% See if dynamic declarations are permitted (even if ignored).
  :- dynamic test12/0.
  test12.

test13 :- name(X,"23"), X == 23, write('name/2 processes numbers').
  % Succeeds if name/2 can convert strings into numbers.

test14 :- 1+1 < 1+2.
  % Succeeds if '<' evaluates arithmetic expressions.

test15 :- 1+1 =:= 2+0.
  % Succeeds if '=:=' compares arithmetic expressions.

test16 :- abc @< abd.
  % Succeeds if '@<' compares atoms.

test17 :- abc(a) @< abc(b).
  % Succeeds if '@<' compares structures.

test18 :- functor(What,2.3,0), write(What).

test18a:- current_op(A,B,C), write([A,B,C]), nl, fail.

test19 :- a \= b, write('has \=').

test20 :- a \== b, write('has \==').


