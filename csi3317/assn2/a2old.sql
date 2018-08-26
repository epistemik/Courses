% Mark Sattolo 428500
% SQL answers to assn2 for csi3317

% Provide supplier details of all suppliers in London. 
q1 := select * from supplier where city = 'London'  ;

% Provide project names and cities. 
q2 := select jname, city from project ;

% Provide supplier numbers for suppliers who supply part P1. 
q3 := select distinct snum from supplier_part_project where pnum = 'p1' ;

% Provide the supplier names which supply part p3 to project j4. 
q4 := select sname from supplier where snum in (select snum from supplier_part_project where pnum = 'p3' and jnum = 'j4' ) ;

% Provide the part names used in a project with quantity equal to 500. 
q5 := select distinct pname from part where pnum in (select pnum from supplier_part_project where qty = 500) ;

% Provide the supplier names for suppliers who do not supply a red part. 
% select s.sname from supplier s where forall r.s#, r.p# in spp r ( r.p# not in select p# from part where p.color = Red)
% select s.sname from supplier s where forall (select r.s#, r.p# from spp r where exists (select p.p# from part p where not exists (select p.p# where p.color = Red) ) )
q6a := select s.sname from supplier s where s.snum in (select r.snum from supplier_part_project r where r.pnum not in (select p.pnum from part p where p.color = 'Red' )) ;
q6b := select s.sname from supplier s where not exists (select * from supplier_part_project r where not exists (select * from part p where p.color = 'Red' and r.snum = s.snum and r.pnum = p.pnum)) ;
q6c := select s.sname from supplier s where not exists (select * from supplier_part_project r where r.snum = s.snum and exists (select * from part p where p.pnum = r.pnum and p.color = 'Red' )) ;
q6d1 := select p.pnum from part p where p.color = 'Red' ;
q6d2 := select distinct r.snum from supplier_part_project r where r.pnum in (q6d1) ;
q6d := select s.sname from supplier s where s.snum not in (q6d2) ;

% Provide the supplier name/project name pairs for which the indicated supplier supplies parts to the indicated project. 
q7 := select distinct s.sname, j.jname from supplier s, project j, supplier_part_project k where s.snum = k.snum and j.jnum = k.jnum ;

% Provide the supplier name/part name pairs for which the indicated supplier does not supply the indicated part. 
q8a := select sname, pname from supplier, part ;
q8b := select distinct sname, pname from supplier s, part p, supplier_part_project k where s.snum = k.snum and p.pnum = k.pnum ;
%q8c := (q8a) EXCEPT (q8b) ;
q8 := select sname, pname from supplier, part EXCEPT select distinct s.sname, p.pname from supplier s, part p, supplier_part_project k where s.snum = k.snum and p.pnum = k.pnum ;

% Provide project names which use all parts. 
% select jname from project j where forall (p.p# in part and exists (r.j# in spp r  = j.j#)
q9 := select jname from project j where not exists (select * from part p where not exists (select * from supplier_part_project r where j.jnum = r.jnum and p.pnum = r.pnum)) ;

% Provide the average quantity supplied by supplier s2. 
q10 := select AVG(qty) from supplier_part_project r where r.snum = 's2' ;
