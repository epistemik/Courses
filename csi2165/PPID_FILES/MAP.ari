% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% MAP.PL
%   A program for coloring maps.

%
% map
%   Finds and displays an assignment of colors to the regions
%   on a map so no adjacent regions are the same color.
%

map :- color_map([],Solution), writeln(Solution).

%
% color_map(+Sofar,-Solution)
%   Searches for a legitimate assignment Solution of colors for
%   regions on a map that includes the partial assignment Sofar.
%

color_map(Sofar,Solution) :-
     country(Country),
     \+ member([Country,_],Sofar),
     color(Hue),
     \+ prohibited(Country,Hue,Sofar),
     write(Country),nl,
     color_map([[Country,Hue]|Sofar],Solution).
color_map(Solution,Solution).


%
% prohibited(+Country,-Hue,+Sofar)
%   Country cannot be colored Hue if any region adjacent to
%   Country is already assigned Hue in Sofar.
%

prohibited(Country,Hue,Sofar) :-
     borders(Country,Neighbor),
     member([Neighbor,Hue],Sofar).

%
% borders(+Country,-Neighbor)
%   Succeeds if Country and Neighbor share a border.
%

borders(Country,Neighbor) :- beside(Country,Neighbor).
borders(Country,Neighbor) :- beside(Neighbor,Country).

writeln([]).
writeln([X|Y]) :-
     write(X), nl,
     writeln(Y).

% Only four colors are ever needed

color(red).
color(blue).
color(green).
color(yellow).

member(X,[X|_]).
member(X,[_|Y]) :-
	member(X,Y).
