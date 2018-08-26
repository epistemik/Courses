% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File TREE.PL
% Miscellaneous predicates dealing with binary trees
% (see also TREESORT.PL)



% insert(+NewItem,-Tree,+NewTree)
%  Inserts an item into a binary tree.

insert(NewItem,empty,tree(NewItem,empty,empty)) :- !.

insert(NewItem,tree(Element,Left,Right),tree(Element,NewLeft,Right)) :-
   NewItem @< Element,
   !,
   insert(NewItem,Left,NewLeft).

insert(NewItem,tree(Element,Left,Right),tree(Element,Left,NewRight)) :-
   insert(NewItem,Right,NewRight).



% write_sorted(+Tree)
%  Prints out the elements of Tree in sorted order

write_sorted(empty) :- !.

write_sorted(tree(Element,Left,Right)) :-
     write_sorted(Left),
     write(Element), write(' '),
     write_sorted(Right).


% Demonstration predicate

test :- insert(nute,empty,Tree1),
        insert(covington,Tree1,Tree2),
        insert(vellino,Tree2,Tree3),
        insert(donald,Tree3,Tree4),
        insert(michael,Tree4,Tree5),
        insert(andre,Tree5,Tree6),
        write(Tree6), nl,
        write_sorted(Tree6).

