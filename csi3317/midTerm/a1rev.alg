% Mark Sattolo 428500
% a1rev.alg / WinRDBI
% RA answers to assn1 & assn2 for csi3317

% Provide complete details of all suppliers in London.
q1 := project snum, sname, status, city (select city = 'London' (supplier))  ;

% Provide project names and cities.
q2 := project jname, city (projet) ;

% Provide all cities in which a supplier or project (or both) are located.
q3 := (project city (supplier)) union (project city (projet)) ;

% Provide supplier numbers for suppliers who supply part P1.
q4 := project snum (select pnum = 'p1' (spj)) ;

% Provide project names which use red or green parts.
q5s1 := (project pnum ( (select color='Red' (part)) union (select color='Green' (part)) )) ;
q5s2 := (project pnum, jnum (spj)) njoin (q5s1) ;
q5s3 := (project jnum, jname (projet)) njoin (q5s2) ;
q5 := project jname (q5s3) ;

% Provide the part names used in a project with quantity equal to 500.
q6s1 := project pnum (select qty = 500 (spj)) ;
q6s2 := (project pnum, pname (part)) njoin (q6s1) ;
q6 := project pname(q6s2) ;

% Provide all the cities in which suppliers are located, but no parts are located.
q7 := (project city (supplier)) difference (project city (part)) ;

% Provide the supplier name/project name pairs for which the indicated supplier supplies parts to the indicated project.
q8s1 := project snum, jnum (spj) ;
q8s2 := (project snum, sname (supplier)) njoin (q8s1) ;
q8s3 := (project jnum, jname (projet)) njoin (q8s2) ;
q8 := project sname, jname (q8s3) ;

% Provide the supplier name/part name pairs for which the indicated supplier does NOT supply the indicated part.
q9s1rev := (project sname (supplier)) product (project pname (part)) ;
q9s2 := project snum, pnum (spj) ;
q9s3 := (project snum, sname (supplier)) njoin (q9s2) ;
q9s4 := (project pnum, pname (part)) njoin (q9s3) ;
q9 := (project sname, pname (q9s1rev)) difference (project sname, pname (q9s4) ) ;

% Provide the supplier names which supply part p3 to project j4. 
q2_4s1 := project snum ( (select pnum = 'p3' (spj)) intersect (select jnum = 'j4' (spj)) ) ;
q2_4 := project sname ( q2_4s1 njoin (project snum, sname (supplier)) ) ;

% Provide the supplier names for suppliers who do NOT supply a red part. 
q2_6s1 := project pnum (select color = 'Red' (part) ) ;
q2_6s2 := q2_6s1 njoin ( project snum, pnum (spj) ) ;
q2_6s3 := q2_6s2 njoin ( project snum, sname (supplier) ) ;
q2_6 := ( project sname (supplier) ) difference ( project sname (q2_6s3) ) ;

% Provide project names which use all parts. 
q2_9s1 := project jnum, pnum (spj) ;
q2_9s2 := project pnum (part) ;

% Division NOT provided: q2_9s3 := q2_9s1 division q2_9s2 ;
% Equivalent of division:
% project jnum (q2_9s1) difference (project jnum ( ( (project jnum (q2_9s1)) product q2_9s2) difference (project jnum, pnum (q2_9s1)) ) ) ;
q2_9d1 := project jnum (q2_9s1) ;
q2_9d2 := project jnum, pnum (q2_9s1) ;
q2_9d3 := q2_9d1 product q2_9s2 ;
q2_9d4 := q2_9d3 difference q2_9d2 ;
q2_9s3 := q2_9d1 difference ( project jnum (q2_9d4) ) ;

q2_9 := project jname (q2_9s3 njoin ( project jnum, jname (projet) ) ) ;


