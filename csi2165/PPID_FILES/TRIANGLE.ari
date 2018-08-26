% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% TRIANGLE.PL
% This program solves the triangle puzzle.

%
% triangle(+N)
%   Finds and displays a solution to the triangle problem
%   where the Nth peg is removed first.
%

triangle(N) :-
     remove_peg(N,StartingTriangle),
     solve_triangle(14,[StartingTriangle],Solution),
     reverse(Solution,[],OrderedSolution),
     nl,nl,
     show_triangles(OrderedSolution).

%
% solve_triangle(+N,+Sofar,-Solution)
%   Searches for a solution to the triangle problem from a
%   position with N pegs arranged in the pattern Sofar.
%

solve_triangle(1,Solution,Solution).
solve_triangle(Count,[CurrentTriangle|PriorTriangles],Solution):-
     jump(CurrentTriangle,NextTriangle),
     NewCount is Count - 1,
     write(NewCount), nl,
     solve_triangle(NewCount,
                    [NextTriangle,CurrentTriangle|PriorTriangles],
                    Solution).

%
% remove_peg(+N,-Triangle)
%   Produces a Triangle with an empty Nth hole and pegs
%   in all other holes.
%

remove_peg(1,triangle(0,1,1,1,1,1,1,1,1,1,1,1,1,1,1)).
remove_peg(2,triangle(1,0,1,1,1,1,1,1,1,1,1,1,1,1,1)).
remove_peg(3,triangle(1,1,0,1,1,1,1,1,1,1,1,1,1,1,1)).
remove_peg(4,triangle(1,1,1,0,1,1,1,1,1,1,1,1,1,1,1)).
remove_peg(5,triangle(1,1,1,1,0,1,1,1,1,1,1,1,1,1,1)).
remove_peg(6,triangle(1,1,1,1,1,0,1,1,1,1,1,1,1,1,1)).
remove_peg(7,triangle(1,1,1,1,1,1,0,1,1,1,1,1,1,1,1)).
remove_peg(8,triangle(1,1,1,1,1,1,1,0,1,1,1,1,1,1,1)).
remove_peg(9,triangle(1,1,1,1,1,1,1,1,0,1,1,1,1,1,1)).
remove_peg(10,triangle(1,1,1,1,1,1,1,1,1,0,1,1,1,1,1)).
remove_peg(11,triangle(1,1,1,1,1,1,1,1,1,1,0,1,1,1,1)).
remove_peg(12,triangle(1,1,1,1,1,1,1,1,1,1,1,0,1,1,1)).
remove_peg(13,triangle(1,1,1,1,1,1,1,1,1,1,1,1,0,1,1)).
remove_peg(14,triangle(1,1,1,1,1,1,1,1,1,1,1,1,1,0,1)).
remove_peg(15,triangle(1,1,1,1,1,1,1,1,1,1,1,1,1,1,0)).

%
% jump(+CurrentTriangle,-NextTriangle)
%   Finds a NextTriangle that can be produced from
%   CurrentTriangle by a legal jump. To save space,
%   all but the first clause are displayed in linear
%   format.
%

jump(triangle(1,
             1,C,
            0,E,F,
           G,H,I,J,
          K,L,M,N,P),
     triangle(0,
             0,C,
            1,E,F,
           G,H,I,J,
          K,L,M,N,P)).
jump(triangle(1,B,1,D,E,0,G,H,I,J,K,L,M,N,P),
     triangle(0,B,0,D,E,1,G,H,I,J,K,L,M,N,P)).
jump(triangle(A,1,C,1,E,F,0,H,I,J,K,L,M,N,P),
     triangle(A,0,C,0,E,F,1,H,I,J,K,L,M,N,P)).
jump(triangle(A,1,C,D,1,F,G,H,0,J,K,L,M,N,P),
     triangle(A,0,C,D,0,F,G,H,1,J,K,L,M,N,P)).
jump(triangle(A,B,1,D,1,F,G,0,I,J,K,L,M,N,P),
     triangle(A,B,0,D,0,F,G,1,I,J,K,L,M,N,P)).
jump(triangle(A,B,1,D,E,1,G,H,I,0,K,L,M,N,P),
     triangle(A,B,0,D,E,0,G,H,I,1,K,L,M,N,P)).
jump(triangle(0,1,C,1,E,F,G,H,I,J,K,L,M,N,P),
     triangle(1,0,C,0,E,F,G,H,I,J,K,L,M,N,P)).
jump(triangle(A,B,C,1,1,0,G,H,I,J,K,L,M,N,P),
     triangle(A,B,C,0,0,1,G,H,I,J,K,L,M,N,P)).
jump(triangle(A,B,C,1,E,F,G,1,I,J,K,L,0,N,P),
     triangle(A,B,C,0,E,F,G,0,I,J,K,L,1,N,P)).
jump(triangle(A,B,C,1,E,F,1,H,I,J,0,L,M,N,P),
     triangle(A,B,C,0,E,F,0,H,I,J,1,L,M,N,P)).
jump(triangle(A,B,C,D,1,F,G,1,I,J,K,0,M,N,P),
     triangle(A,B,C,D,0,F,G,0,I,J,K,1,M,N,P)).
jump(triangle(A,B,C,D,1,F,G,H,1,J,K,L,M,0,P),
     triangle(A,B,C,D,0,F,G,H,0,J,K,L,M,1,P)).
jump(triangle(0,B,1,D,E,1,G,H,I,J,K,L,M,N,P),
     triangle(1,B,0,D,E,0,G,H,I,J,K,L,M,N,P)).
jump(triangle(A,B,C,0,1,1,G,H,I,J,K,L,M,N,P),
     triangle(A,B,C,1,0,0,G,H,I,J,K,L,M,N,P)).
jump(triangle(A,B,C,D,E,1,G,H,1,J,K,L,0,N,P),
     triangle(A,B,C,D,E,0,G,H,0,J,K,L,1,N,P)).
jump(triangle(A,B,C,D,E,1,G,H,I,1,K,L,M,N,0),
     triangle(A,B,C,D,E,0,G,H,I,0,K,L,M,N,1)).
jump(triangle(A,0,C,1,E,F,1,H,I,J,K,L,M,N,P),
     triangle(A,1,C,0,E,F,0,H,I,J,K,L,M,N,P)).
jump(triangle(A,B,C,D,E,F,1,1,0,J,K,L,M,N,P),
     triangle(A,B,C,D,E,F,0,0,1,J,K,L,M,N,P)).
jump(triangle(A,B,0,D,1,F,G,1,I,J,K,L,M,N,P),
     triangle(A,B,1,D,0,F,G,0,I,J,K,L,M,N,P)).
jump(triangle(A,B,C,D,E,F,G,1,1,0,K,L,M,N,P),
     triangle(A,B,C,D,E,F,G,0,0,1,K,L,M,N,P)).
jump(triangle(A,0,C,D,1,F,G,H,1,J,K,L,M,N,P),
     triangle(A,1,C,D,0,F,G,H,0,J,K,L,M,N,P)).
jump(triangle(A,B,C,D,E,F,0,1,1,J,K,L,M,N,P),
     triangle(A,B,C,D,E,F,1,0,0,J,K,L,M,N,P)).
jump(triangle(A,B,0,D,E,1,G,H,I,1,K,L,M,N,P),
     triangle(A,B,1,D,E,0,G,H,I,0,K,L,M,N,P)).
jump(triangle(A,B,C,D,E,F,G,0,1,1,K,L,M,N,P),
     triangle(A,B,C,D,E,F,G,1,0,0,K,L,M,N,P)).
jump(triangle(A,B,C,0,E,F,1,H,I,J,1,L,M,N,P),
     triangle(A,B,C,1,E,F,0,H,I,J,0,L,M,N,P)).
jump(triangle(A,B,C,D,E,F,G,H,I,J,1,1,0,N,P),
     triangle(A,B,C,D,E,F,G,H,I,J,0,0,1,N,P)).
jump(triangle(A,B,C,D,0,F,G,1,I,J,K,1,M,N,P),
     triangle(A,B,C,D,1,F,G,0,I,J,K,0,M,N,P)).
jump(triangle(A,B,C,D,E,F,G,H,I,J,K,1,1,0,P),
     triangle(A,B,C,D,E,F,G,H,I,J,K,0,0,1,P)).
jump(triangle(A,B,C,D,E,F,G,H,I,J,0,1,1,N,P),
     triangle(A,B,C,D,E,F,G,H,I,J,1,0,0,N,P)).
jump(triangle(A,B,C,0,E,F,G,1,I,J,K,L,1,N,P),
     triangle(A,B,C,1,E,F,G,0,I,J,K,L,0,N,P)).
jump(triangle(A,B,C,D,E,0,G,H,1,J,K,L,1,N,P),
     triangle(A,B,C,D,E,1,G,H,0,J,K,L,0,N,P)).
jump(triangle(A,B,C,D,E,F,G,H,I,J,K,L,1,1,0),
     triangle(A,B,C,D,E,F,G,H,I,J,K,L,0,0,1)).
jump(triangle(A,B,C,D,E,F,G,H,I,J,K,0,1,1,P),
     triangle(A,B,C,D,E,F,G,H,I,J,K,1,0,0,P)).
jump(triangle(A,B,C,D,0,F,G,H,1,J,K,L,M,1,P),
     triangle(A,B,C,D,1,F,G,H,0,J,K,L,M,0,P)).
jump(triangle(A,B,C,D,E,F,G,H,I,J,K,L,0,1,1),
     triangle(A,B,C,D,E,F,G,H,I,J,K,L,1,0,0)).
jump(triangle(A,B,C,D,E,0,G,H,I,1,K,L,M,N,1),
     triangle(A,B,C,D,E,1,G,H,I,0,K,L,M,N,0)).

%
% Procedure to display a solution.
%

show_triangles([]) :- !.
show_triangles([
     triangle(A,
             B,C,
            D,E,F,
           G,H,I,J,
          K,L,M,N,P)|LaterTriangles]) :-
     sp(4),write(A),nl,
     sp(3),write(B),sp(1),write(C),nl,
     sp(2),write(D),sp(1),write(E),sp(1),write(F),nl,
     sp(1),write(G),sp(1),write(H),sp(1),write(I),sp(1),write(J),nl,
     write(K),sp(1),write(L),sp(1),write(M),sp(1),
          write(N),sp(1),write(P),nl,
     write('Press any key to continue. '),
     get0(_),
     nl,nl,
     show_triangles(LaterTriangles).

sp(0).
sp(N) :- write(' '),
         M is N - 1,
         sp(M).
