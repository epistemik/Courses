% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File SOLVER2.PL -- EXPERIMENTAL
% Numerical equation solver (Covington 1989)

% solve(+(Left=Right))
%  Left=Right is an arithmetic equation containing an uninstantiated
%  variable.  On exit, that variable is instantiated to a solution.

solve(Left=Right) :-
   free_in(Left=Right,X),
   !,                         % accept only one answer from free_in
   define_dif(X,Left=Right),
   solve_for(X).


% free_in(+Term,-Variable)
%  Variable occurs in Term and is uninstantiated.

free_in(X,X) :-			% An atomic term
    var(X).

free_in(Term,X) :-		% A complex term
    Term \== [[]],
    Term =.. [_,Arg|Args],
    (free_in(Arg,X) ; free_in(Args,X)).


% define_dif(-X,+(Left=Right))
%  Defines a predicate to compute Left-Right given X.
%  Here X is uninstantiated but occurs in Left=Right.

define_dif(X,Left=Right) :-
   abolish(dif,2),
   assert((dif(X,Dif) :- Dif is Left-Right)).


% solve_for(-Variable)
%  Sets up arguments and calls solve_aux (below).

solve_for(Variable) :-
   dif(1,Dif1),
   solve_aux(Variable,1,Dif1,2,1).


% solve_aux(-Variable,+Guess1,+Dif1,+Guess2,+Iteration)
%  Uses the secant method to solve for Variable (see text).
%  Other arguments:
%	 Guess1    -- Previous estimated value.
%	 Dif1	   -- What 'dif' gave with Guess1.
%	 Guess2    -- A better estimate.
%	 Iteration -- Count of tries taken.

solve_aux(_,_,_,_,100) :-
   !,
   write('[Gave up at 100th iteration]'),nl,
   fail.

solve_aux(Guess2,Guess1,_,Guess2,_) :-
   close_enough(Guess1,Guess2),
   !,
   write('[Found a satisfactory solution]'),nl.

solve_aux(Variable,Guess1,Dif1,Guess2,Iteration) :-
   write([Guess2]),nl,
   dif(Guess2,Dif2),
   Slope is (Dif2-Dif1) / (Guess2-Guess1),
   write(slope(Slope)),nl,
   adjust(Slope,NewSlope),     % *** NEW ***
   Guess3 is Guess2 - (Dif2/NewSlope),
   NewIteration is Iteration + 1,
   solve_aux(Variable,Guess2,Dif2,Guess3,NewIteration).


adjust(Slope,10) :- Slope > 1E6, !.

adjust(Slope,-10) :- Slope < -1E6, !.

adjust(Slope,0.1) :- 0 < Slope, Slope < 0.0001.

adjust(Slope,-0.1) :- 0 > Slope, Slope > -0.0001.

adjust(Slope,Slope).





% close_enough(+X,+Y)
%  True if X and Y are the same number to within a factor of 1.000001.

close_enough(X,Y) :-  Quot is X/Y, Quot > 0.999999, Quot < 1.000001.
