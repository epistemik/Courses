% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% WRITELN.PL

writeln([]) :- !.

writeln([First|Rest]) :-
	!,
	write(First),
	nl,
	writeln(Rest).

writeln(String) :-
	write(String),
	nl.
