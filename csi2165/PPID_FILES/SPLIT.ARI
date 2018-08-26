
split(Vname, List):- assert(varname(Vname)),
                     ((not(atom(Vname)), !, stop);
                      (!, process(Vname, List))),
                     (retract(varname(Vname)); true).  %'; true' needed here?

process(Vname, Chars):- name(Vname, List),
                              List=[H|T],!,
                              (starter(H); !, stop),
%                              ((H=95, List
%                              ((upper(H), List2=T); List2=List),
                              word(List, WordL, NewList),!,
%                              ((upper(H), WordL2=[H|WordL]); WordL2=WordL),
                              name(Word, WordL),
                              ((NewList=[], Rest=[]);
                              (name(NewName, NewList),
                              process(NewName, Rest))),
                              ((Word='', Chars=Rest); Chars=[Word|Rest]).


% word/3
% Splits List into the characters constituting one valid name and the remainder.

word([95|T], [], T):- !.            % stop upon hitting an underscore

word([], [], []).                   % stop at end of list

word([Char|T], C, Rest):- nonvalid(Char), !, stop.

% word([Char1,U|T], Char1, [U|T]):- upper(Char1).

word([Char|T], [], [Char|T]):- upper(Char).
/*,
                           word(T1, T2, Rest),
                           T2=[H3|T3],
                           ((upper(H3), U=[Char]);
                            (U=[Char|T2])). 
*/            

word([Char|T1], [Char|T2], Rest):- (lower(Char); digit(Char); !, stop),
                                   word(T1, T2, Rest).           


stop:- retract(varname(Vname)),
       write(Vname),
       write(' is not a valid variable name'),
       !, fail.


upper(Char):- Char>=65, Char=<90.
lower(Char):- Char>=97, Char=<122.
digit(Char):- Char>=48, Char=<57.
starter(Char):- Char=95; upper(Char); lower(Char).
nonvalid(Char):- Char<48; Char>122; (Char>57, Char<65); (Char>90, Char<97).

