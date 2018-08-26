rem  Mark Sattolo 428500
rem  a2.sql / Oracle
rem  SQL answers to assn2 for csi3317

rem 1. Provide supplier details of all suppliers in London. 
select * from supplier where city = 'London' ;

rem 2. Provide project names and cities. 
select jname, city from project ;

rem 3. Provide supplier numbers for suppliers who supply part P1. 
select distinct s# from spj where p# = 'P1' ;

rem 4. Provide the supplier names which supply part p3 to project j4. 
select distinct sname from supplier where s# in (select s# from spj where p# = 'P3' and j# = 'J4' ) ;

rem 5. Provide the part names used in a project with quantity equal to 500. 
select distinct pname from part where p# in (select p# from spj where qty = 500) ;

rem 6. Provide the supplier names for suppliers who do not supply a red part. 
select distinct s.sname from supplier s where s.s# not in (select distinct r.s# from spj r where r.p# in (select p.p# from part p where p.color = 'red')) ;

rem 7. Provide the supplier name/project name pairs for which the indicated supplier supplies parts to the indicated project. 
select distinct s.sname, j.jname from supplier s, project j, spj k where s.s# = k.s# and j.j# = k.j# ;

rem 8. Provide the supplier name/part name pairs for which the indicated supplier does not supply the indicated part. 
select sname, pname from supplier, part MINUS select distinct s.sname, p.pname from supplier s, part p, spj k where s.s# = k.s# and p.p# = k.p# ;

rem 9. Provide project names which use all parts. 
select jname from project j where not exists (select * from part p where not exists (select * from spj r where j.j# = r.j# and p.p# = r.p#)) ;

rem 10. Provide the average quantity supplied by supplier s2. 
select AVG(qty) from spj r where r.s# = 'S2' ;
