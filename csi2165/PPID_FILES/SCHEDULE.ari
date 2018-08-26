% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% SCHEDULE.PL
% An example of a scheduling program.

schedule :- 
        findall(slots(Day,Time,Job,Number),
                slots(Day,Time,Job,Number),Slots),
        schedule_aux(Slots,[],IntermediateSchedule),
        improve_schedule(IntermediateSchedule,Schedule),
        write_report(Schedule).

%
% Procedure to extend a partial schedule until it is complete.
%

schedule_aux([],Schedule,Schedule).
schedule_aux([slots(_,_,_,0)|RestOfSlots],Partial,Schedule) :-
        schedule_aux(RestOfSlots,Partial,Schedule).
schedule_aux([slots(Day,Time,Job,Number)|RestOfSlots],
             Partial,Schedule) :-
        Number > 0,
        available(Day,Time,Job,Person,Partial),
        write('Trying: '),
        report(Day,Time,Job,Person),
        NewNumber is Number - 1,
        schedule_aux([slots(Day,Time,Job,NewNumber)|RestOfSlots],
                [sched(Day,Time,Job,Person)|Partial],Schedule).

%
% available(+Day,+Time,+Job,-Person,+Partial)
%   finds a Person whom the Partial schedule leaves available
%   to perform Job at Time on Day.
%
 
available(Day,Time,Job,Person,Partial) :-
        job(Job,JobList),
        member(Person,JobList),
        \+ member(sched(Day,Time,_,Person),Partial),
        personnel(Person,MinWeekly,_,Daily,Days),
        member(Day,Days),
        findall(T,member(sched(Day,T,J,Person),Partial),DList),
        length(DList,D),
        D < Daily,
        findall(T,member(sched(D,T,J,Person),Partial),WList),
        length(WList,W),
        W < MinWeekly.
available(Day,Time,Job,Person,Partial) :-
        job(Job,JobList),
        member(Person,JobList),
        \+ member(sched(Day,Time,_,Person),Partial),
        personnel(Person,_,MaxWeekly,Daily,Days),
        member(Day,Days),
        findall(T,member(sched(Day,T,J,Person),Partial),DList),
        length(DList,D),
        D < Daily,
        findall(T,member(sched(D,T,J,Person),Partial),WList),
        length(WList,W),
        W < MaxWeekly.

%
% improve(+Current,-Better)
%   replaces the Current schedule with a Better schedule
%   by reassigning job slots occupied by persons with extra
%   shifts to persons who need additional shifts.
%

improve_schedule(Schedule,Schedule) :-
        \+ needs_shifts(_,Schedule).
improve_schedule(Current,Schedule) :-
        needs_shifts(Person1,Current),
        has_extra_shift(Person2,Current),
        personnel(Person1,_,_,Daily,Days),
        member(sched(Day,Time,Job,Person2),Current),
        member(Day,Days),
        \+ member(sched(Day,Time,_,Person1),Current),
        job(Job,JobList),
        member(Person1,JobList),
        findall(T,member(sched(Day,T,J,Person1),Current),DList),
        length(DList,D),
        D < Daily,
        !,
        write('Rescheduling: '),
        report(Day,Time,Job,Person2),
        remove(sched(Day,Time,Job,Person2),Current,Partial),
        improve_schedule([sched(Day,Time,Job,Person1)|Partial],Schedule).
improve_schedule(Schedule,Schedule).

%
% Procedures for finding persons who have fewer or more shifts
% than requested in a schedule.
%

needs_shift(Person,Schedule) :-
        personnel(Person,MinWeekly,_,_,_),
        findall(T,member(sched(D,T,J,Person),Schedule),Shifts),
        length(Shifts,S),
        S < MinWeekly.

has_extra_shift(Person,Schedule) :-
        personnel(Person,MinWeekly,_,_,_),
        findall(T,member(sched(D,T,J,Person),Schedule),Shifts),
        length(Shifts,S),
        S > MinWeekly.

remove(X,[X|Y],Y) :- !.
remove(X,[Y|Z],[Y|W]) :- remove(X,Z,W).

member(X,[X|_]).
member(X,[_|Y]) :- member(X,Y).

%
% Procedures for displaying schedules.
%

write_report(Schedule) :- 
        nl, nl,
        write('Schedule for the Week: '), nl, nl,
        member(Day,[mon,tue,wed,thu,fri]),
        findall(sched(Day,Time,Job,Person),
                member(sched(Day,Time,Job,Person),Schedule),
                       DaySchedule),
        report_list1(DaySchedule), nl,
        write('Press key to continue. '), get0(_), nl, nl,
        Day = fri,
        findall(person(Person,Min,Max),
              personnel(Person,Min,Max,_,_),PersonList),
        report_list2(PersonList,Schedule),
        !.

report_list1([]).
report_list1([sched(Day,Time,Job,Person)|RestOfSchedule]) :-
        report(Day,Time,Job,Person),
        report_list1(RestOfSchedule).

report(Day,Time,Job,Person) :- 
	write(Day), write(' '), write(Time),   write(' '),
        write(Job), write(' '), write(Person), nl.

report_list2([],_) :- write('Report finished.'), nl, nl.
report_list2([person(Person,Min,Max)|Rest],Schedule) :-
        write(Person), write('''s schedule ('),
        write(Min),    write(' to '),
        write(Max),    write(' shifts per week):'), nl, nl,
        member(Day,[mon,tue,wed,thu,fri]),
        findall(sched(Day,Time,Job,Person),
                member(sched(Day,Time,Job,Person),Schedule),DaySchedule),
        report_list2_aux(DaySchedule),
        Day = fri, nl,
        write('Press key to continue. '), get0(_), nl, nl,
        report_list2(Rest,Schedule).

report_list2_aux([]).
report_list2_aux([sched(Day,Time,Job,_)|Rest]) :-
        report(Day,Time,Job,''),
        report_list2_aux(Rest).

%
% Sample scheduling data.
%

slots(mon,am,cataloger,1).
slots(mon,am,deskclerk,1).
slots(mon,pm,deskclerk,1).
slots(mon,am,shelver,2).
slots(mon,pm,shelver,2).
slots(tue,am,cataloger,1).
slots(tue,am,deskclerk,1).
slots(tue,pm,deskclerk,1).
slots(tue,am,shelver,2).
slots(tue,pm,shelver,2).
slots(wed,am,cataloger,1).
slots(wed,am,deskclerk,1).
slots(wed,pm,deskclerk,1).
slots(wed,am,shelver,2).
slots(wed,pm,shelver,2).
slots(thu,am,cataloger,1).
slots(thu,am,deskclerk,1).
slots(thu,pm,deskclerk,1).
slots(thu,am,shelver,2).
slots(thu,pm,shelver,2).
slots(fri,am,cataloger,1).
slots(fri,am,deskclerk,1).
slots(fri,pm,deskclerk,1).
slots(fri,am,shelver,2).
slots(fri,pm,shelver,2).

personnel(alice,6,8,2,[mon,tue,thu,fri]).
personnel(bob,7,10,2,[mon,tue,wed,thu,fri]).
personnel(carol,3,5,1,[mon,tue,wed,thu,fri]).
personnel(don,6,8,2,[mon,tue,wed]).
personnel(ellen,0,2,1,[thu,fri]).
personnel(fred,7,10,2,[mon,tue,wed,thu,fri]).

job(cataloger,[alice,fred]).
job(deskclerk,[bob,carol,fred]).
job(shelver,[alice,bob,carol,don,ellen,fred]).
