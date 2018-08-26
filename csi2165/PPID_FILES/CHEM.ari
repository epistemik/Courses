% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% CHEM.PL 
%   Molecular query predicates.

% Procedures to find bonds and identify elements.

bonded(A1,A2) :-
     atom_specs(A1,_,Neighbors),
     member(A2,Neighbors).

member(X,[X|_]).
member(X,[_|Y]) :- member(X,Y).

element(A1,Element) :- atom_specs(A1,Element,_).

% Procedures to identify molecular substructures.

methyl(C) :-
     element(C,carbon),
     bonded(C,H1), element(H1,hydrogen),
     bonded(C,H2), element(H2,hydrogen), H1 \== H2,
     bonded(C,H3), element(H3,hydrogen), H3 \== H1,
          H3 \== H2.

six_membered_carbon_ring([A1,A2,A3,A4,A5,A6]) :-
     element(A1,carbon), bonded(A1,A2),
     element(A2,carbon), bonded(A2,A3), A1 \== A3,
     element(A3,carbon), bonded(A3,A4),
          \+ member(A4,[A1,A2,A3]),
     element(A4,carbon), bonded(A4,A5),
          \+ member(A5,[A1,A2,A3,A4]),
     element(A5,carbon), bonded(A5,A6),
     element(A6,carbon), bonded(A6,A1),
          \+ member(A6,[A1,A2,A3,A4,A5]).

meth_carbon_ring([C|Ring]) :-
     six_membered_carbon_ring(Ring),
     member(A,Ring), bonded(A,C), methyl(C).

hydroxide(O) :- element(O,oxygen),
                     bonded(O,H),
                element(H,hydrogen).

%
% Demonstrations
%   A Prolog representation of a molecule such at the one in
%   3CTOLUEN.PL must be in memory before these demonstrations
%   are used.
%

demo1 :-    write('Searching for a methyl group...'), nl,
            methyl(X),
            write('Found one centered on atom: '),
            write(X), nl.
demo1 :-    write('No (more) methyl groups found.'), nl.

demo2 :-    write('Searching for a six-membered carbon ring...'),
            nl,
            six_membered_carbon_ring(List),
            write('Found one containing atoms: '),
            write(List), nl.
demo2 :-    write('No (more) six-membered carbon rings found.'),
	    nl.
