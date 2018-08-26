% Mark Sattolo 428500
% SQL answers to assn1 for csi3317

q1 := select * from supplier where city = 'London'  ;

q2 := select jname, city from project ;

q3 := select city from supplier union select city from project ;

q4 := select distinct snum from supplier_part_project where pnum = 'p1' ;

q5 := select distinct jname from project where jnum in ( select jnum from supplier_part_project where pnum in (select pnum from part where color = 'Red' or color = 'Green' ));

q6 := select distinct pname from part where pnum in (select pnum from supplier_part_project where qty = 500) ;

% WinRDBI calls the MINUS operator 'EXCEPT'
q7a := select city from supplier except select city from part ;
q7b := select city from supplier where city not in (select city from part) ;

q8 := select distinct sname, jname from supplier s, project j, supplier_part_project k where s.snum = k.snum and j.jnum = k.jnum ;

q9 := select distinct sname, pname from supplier a, part b where b.pname not in (select * from supplier s, part p, supplier_part_project k where s.snum = k.snum and p.pnum = k.pnum) ;
