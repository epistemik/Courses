% Mark Sattolo 428500
% Oracle SQL answers to assn2 for csi3317

% Provide supplier details of all suppliers in London. 
q1 := select * from supplier where city = 'London' ;

% Provide project names and cities. 
q2 := select jname, city from project ;

% Provide supplier numbers for suppliers who supply part P1. 
q3 := select distinct s# from spj where p# = 'P1' ;

% Provide the supplier names which supply part p3 to project j4. 
q4 := select sname from supplier where s# in (select s# from spj where p# = 'P3' and j# = 'J4' ) ;

% Provide the part names used in a project with quantity equal to 500. 
q5 := select distinct pname from parts where p# in (select p# from spj where qty = 500) ;

% Provide the supplier names for suppliers who do not supply a red part. 
% select s.sname from supplier s where forall r.s#, r.p# in spp r ( r.p# not in select p# from part where p.color = red)
q6d := select s.sname from supplier s where s.s# not in (select distinct r.s# from spj r where r.p# in (select p.p# from parts p where p.color = 'red')) ;

% Provide the supplier name/project name pairs for which the indicated supplier supplies parts to the indicated project. 
q7 := select distinct s.sname, j.jname from supplier s, project j, spj k where s.s# = k.s# and j.j# = k.j# ;

% Provide the supplier name/part name pairs for which the indicated supplier does not supply the indicated part. 
q8a := select sname, pname from supplier, parts ;
q8b := select distinct sname, pname from supplier s, parts p, spj k where s.s# = k.s# and p.p# = k.p# ;
%q8c := (q8a) MINUS (q8b) ;
q8 := select sname, pname from supplier, parts MINUS select distinct s.sname, p.pname from supplier s, parts p, spj k where s.s# = k.s# and p.p# = k.p# ;

% Provide project names which use all parts. 
% select jname from project j where forall (p.p# in part and exists (r.j# in spp r  = j.j#)
q9 := select jname from project j where not exists (select * from parts p where not exists (select * from spj r where j.j# = r.j# and p.p# = r.p#)) ;

% Provide the average quantity supplied by supplier s2. 
q10 := select AVG(qty) from spj r where r.s# = 'S2' ;
