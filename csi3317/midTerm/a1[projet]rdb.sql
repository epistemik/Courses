% Mark Sattolo 428500
% a1[projet]rdb.sql / WinRDBI
% SQL answers to assn1 & assn2 for csi3317

% Provide complete details of all suppliers in London.
q1 := select * from supplier where city = 'London'  ;

% Provide project names and cities.
q2 := select jname, city from projet ;

% Provide all cities in which a supplier or project (or both) are located.
q3 := select city from supplier UNION select city from projet ;

% Provide supplier numbers for suppliers who supply part P1.
q4 := select distinct snum from spj where pnum = 'p1' ;

% Provide project names which use red or green parts.
q5 := select distinct jname from projet where jnum in ( select jnum from spj where pnum in (select pnum from part where color = 'Red' or color = 'Green' ));
q5alt := select distinct jname from projet j, part p, spj r where (p.color = 'Red' or p.color = 'Green' ) and p.pnum = r.pnum and r.jnum = j.jnum ;

% Provide the part names used in a project with quantity equal to 500.
q6 := select distinct pname from part where pnum in (select pnum from spj where qty = 500) ;
q6alt := select distinct pname from part p, spj r where p.pnum = r.pnum and r.qty = 500 ;

% Provide all the cities in which suppliers are located, but no parts are located.
q7 := select city from supplier EXCEPT select city from part ;
q7alt := select city from supplier where city not in (select city from part) ;

% Provide the supplier name/project name pairs for which the indicated supplier supplies parts to the indicated project.
q8 := select distinct sname, jname from supplier s, projet j, spj k where s.snum = k.snum and j.jnum = k.jnum ;

% Provide the supplier name/part name pairs for which the indicated supplier does NOT supply the indicated part.
q9s1 := select sname, pname from supplier, part ;
q9s2 := select distinct sname, pname from supplier s, part p, spj k where s.snum = k.snum and p.pnum = k.pnum ;
q9 := select sname, pname from supplier, part EXCEPT select distinct sname, pname from supplier s, part p, spj k where s.snum = k.snum and p.pnum = k.pnum ;

% Provide the supplier names which supply part p3 to project j4. 
q2_4 := select distinct sname from supplier s, spj r where s.snum = r.snum and r.pnum = 'p3' and r.jnum = 'j4' ;

% Provide the supplier names for suppliers who do NOT supply a red part. 
%q2_6 := select distinct s.sname from supplier s where s.snum not in (select distinct r.snum from spj r where r.pnum in (select p.pnum from part p where p.color = 'Red')) ;
% Preceding query works in Oracle but is NOT allowed by WinRDBI
q2_6alt := select distinct sname from supplier EXCEPT select distinct sname from supplier s, part p, spj r where s.snum = r.snum and r.pnum = p.pnum and p.color = 'Red' ;

% Provide project names which use all parts. 
q2_9 := select jname from projet j where not exists (select * from part p where not exists (select * from spj r where j.jnum = r.jnum and p.pnum = r.pnum) ) ;
q2_9alt := select jname from projet j where not exists (select p.pnum from part p where not exists (select r.pnum from spj r where j.jnum = r.jnum and p.pnum = r.pnum)) ;

% Provide the average quantity supplied by supplier s2.
q2_10 := select AVG(qty) from spj where snum = 's2' ;
% Variation1: provide the average quantity supplied by supplier Jones.
q2_10var1 := select AVG(qty) from spj where snum in (select snum from supplier where sname = 'Jones' ) ;
% Variation2: provide the average quantity supplied by supplier Jones to project Display.
q2_10var2a := select AVG(qty) from spj where snum in (select snum from supplier where sname = 'Jones' ) and jnum in (select jnum from projet where jname = 'Display' ) ;
q2_10var2b := select AVG(qty) from spj k, supplier s, projet j where k.snum = s.snum and k.jnum = j.jnum and s.sname = 'Jones' and j.jname = 'Display' ;
