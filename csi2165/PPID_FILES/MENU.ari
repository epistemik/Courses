% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% File MENU.PL
% A menu generator in Prolog

% menu(+Menu,-Result)
%  Displays a menu of up to 9 items and returns the user's choice.
%  Menu is a list of the form [item(Message,Value),item(Message,Value)...]
%  where each Message is to be displayed and Value is to be returned
%  as Result if the user chooses that item.

menu(Menu,Result) :- menu_display(Menu,49,Last),
                     menu_choose(Menu,49,Last,Result),
                     nl.

% Display all the messages and simultaneously count them.
% The count starts at 49 (ASCII code for '1').

menu_display([],SoFar,Last) :-
   !,
   % not an item, so don't use this number
   Last is SoFar - 1.

menu_display([item(Message,_)|Tail],SoFar,Last) :-
   put(32),
   put(32),
   put(SoFar),       % appropriate digit
   put(32),          % blank
   write(Message),
   nl,
   Next is SoFar + 1,
   menu_display(Tail,Next,Last).

% Get the user's choice. If invalid, make him/her try again.

menu_choose(Menu,First,Last,Result) :-
   write('Your choice ('),
   put(First),
   write(' to '),
   put(Last),
   write('):  '),
   get(Char),
   menu_choose_aux(Menu,First,Last,Result,Char).


menu_choose_aux(Menu,First,Last,Result,Char) :-
      Char >= First,
      Char =< Last,
      !,
      menu_select(Menu,First,Char,Result).

menu_choose_aux(Menu,First,Last,Result,_) :-
      put(7),           % beep
      put(13),          % return to beginning of line
      menu_choose(Menu,First,Last,Result).

% Find the appropriate item to return for Char

menu_select([item(_,Result)|_],First,First,Result) :- !.

menu_select([_|Tail],First,Char,Result) :-
     NewFirst is First+1,
     menu_select(Tail,NewFirst,Char,Result).


% Demonstrate the whole thing

demo :- menu([item('Georgia',ga),
              item('Florida',fl),
              item('Hawaii',hi)],Which),
        write('You chose: '),
        write(Which), 
        nl.


% End of MENU.PL

