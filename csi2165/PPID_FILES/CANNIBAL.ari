% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% CANNIBAL.PL
% This program solves the cannibals and missionaries puzzle.

cannibal :-
        solve_cannibal([state(3,3,l)],Solution),
        reverse(Solution,[],OrderedSolution),
        show_states(OrderedSolution).

%
% solve_cannibal(+Sofar,-Solution)
%   searches for a Solution to the cannibals and missionaries
%   puzzle that extends the sequence of states in Sofar.
%

solve_cannibal([state(0,0,r)|PriorStates],
               [state(0,0,r)|PriorStates]).
solve_cannibal([state(M1,C1,l)|PriorStates],Solution) :-
        member([M,C],[[0,1],[1,0],[1,1],[0,2],[2,0]]),
          % One or two persons cross the river.
        M1 >= M,C1 >= C,
          % The number of persons crossing the river is
          % limited to the number on the left bank.
        M2 is M1 - M, C2 is C1 - C,
          % The number of persons remaining on the left bank
          % is decreased by the number that cross the river.
        member([M2,C2],[[3,_],[0,_],[N,N]]),
          % The missionaries are not outnumbered on either 
          % bank after the crossing.
        \+ member(state(M2,C2,r),PriorStates),
          % No earlier state is repeated.
        solve_cannibal([state(M2,C2,r),state(M1,C1,l)|PriorStates],Solution).
solve_cannibal([state(M1,C1,r)|PriorStates],Solution) :-
        member([M,C],[[0,1],[1,0],[1,1],[0,2],[2,0]]),
          % One or two persons cross the river.
        3 - M1 >= M, 3 - C1 >= C,
          % The number of persons crossing the river is
          % limited to the number on the right bank.
        M2 is M1 + M, C2 is C1 + C,
          % The number of persons remaining on the right bank
          % is decreased by the number that cross the river.
        member([M2,C2],[[3,_],[0,_],[N,N]]),
          % The missionaries are not outnumbered on either 
          % bank after the crossing.
        \+ member(state(M2,C2,l),PriorStates),
          % No earlier state is repeated.
        solve_cannibal([state(M2,C2,l),state(M1,C1,r)
                |PriorStates],Solution).

show_states([]).
show_states([state(M,C,Location)|LaterStates]) :-
        write_n_times('M',M),
        write_n_times('C',C),
        N is 6 - M - C,
        write_n_times(' ',N),
        draw_boat(Location),
        MM is 3 - M,
        CC is 3 - C,
        write_n_times('M',MM),
        write_n_times('C',CC),
        nl,
        show_states(LaterStates).

write_n_times(_,0) :- !.
write_n_times(Item,N) :-
        write(Item),
        M is N - 1,
        write_n_times(Item,M).

draw_boat(l) :- write(' (____)     ').
draw_boat(r) :- write('     (____) ').

member(X,[X|_]).
member(X,[_|Y]) :-
	member(X,Y).

reverse([],List,List).
reverse([X|Tail],SoFar,List) :-
	reverse(Tail,[X|SoFar],List).
