% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File ARITH.PL
% A homemade substitute for 'is'

% Result := Expression
%  Evaluates expressions in much the same way as 'is'.
%  Evaluable functors are + - * / and rec() (reciprocal).


:- op(700,xfx,:=).

Result := X + Y   :-   !,
                       Xvalue := X,
                       Yvalue := Y,
                       Result is Xvalue + Yvalue.

Result := X - Y   :-   !,
                       Xvalue := X,
                       Yvalue := Y,
                       Result is Xvalue - Yvalue.

Result := X * Y   :-   !,
                       Xvalue := X,
                       Yvalue := Y,
                       Result is Xvalue * Yvalue.

Result := X / Y   :-   !,
                       Xvalue := X,
                       Yvalue := Y,
                       Result is Xvalue / Yvalue.

Result := rec(X)  :-   !,
                       Xvalue := X,
                       Result is 1 / Xvalue.

Term   := Term    :-   !,
                       number(Term).

_ := Term         :-   write('Error, can''t evaluate '), write(Term), nl,
                       !, fail.

