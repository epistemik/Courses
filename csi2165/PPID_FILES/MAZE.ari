% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% MAZE.PL
% A program that finds a path through a maze.

solve_maze :- path([start],Solution), write(Solution).

path([finish|RestOfPath],[finish|RestOfPath]).
path([CurrentLocation|RestOfPath],Solution) :-
        connected_to(CurrentLocation,NextLocation),
        \+ member(NextLocation,RestOfPath),
        path([NextLocation,CurrentLocation|RestOfPath],Solution).

connected_to(Location1,Location2) :- connect(Location1,Location2).
connected_to(Location1,Location2) :- connect(Location2,Location1).

member(X,[X|_]).
member(X,[_|Y]) :-
	member(X,Y).
