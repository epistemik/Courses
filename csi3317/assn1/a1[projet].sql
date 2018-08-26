% Mark Sattolo 428500
% SQL answers to assn1 for csi3317

q1 := select * from supplier where city = 'London'  ;

q2 := select jname, city from projet ;

q3 := select city from supplier UNION select city from projet ;

q4 := select distinct snum from supplier_part_projet where pnum = 'p1' ;

q5 := select distinct jname from projet where jnum in ( select jnum from supplier_part_projet where pnum in (select pnum from part where color = 'Red' or color = 'Green' ));

q6 := select distinct pname from part where pnum in (select pnum from supplier_part_projet where qty = 500) ;

% WinRDBI calls the MINUS operator 'EXCEPT'
% Both q7a and q7b give the same result
q7a := select city from supplier EXCEPT select city from part ;
q7b := select city from supplier where city not in (select city from part) ;

q8 := select distinct sname, jname from supplier s, projet j, supplier_part_projet k where s.snum = k.snum and j.jnum = k.jnum ;

q9s1 := select sname, pname from supplier, part ;
q9s2 := select distinct sname, pname from supplier s, part p, supplier_part_projet k where s.snum = k.snum and p.pnum = k.pnum ;
q9 := select sname, pname from supplier, part EXCEPT select distinct sname, pname from supplier s, part p, supplier_part_projet k where s.snum = k.snum and p.pnum = k.pnum ;
