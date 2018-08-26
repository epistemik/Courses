% Mark Sattolo 428500
% RA answers to assn1 for csi3317

% Provide complete details of all suppliers in London.
q1 := project snum, sname, status, city (select city = 'London' (supplier))  ;

% Provide project names and cities.
q2 := project jname, city (projet) ;

% Provide all cities in which a supplier or project (or both) are located.
q3 := (project city (supplier)) union (project city (projet)) ;

% Provide supplier numbers for suppliers who supply part P1.
q4 := project snum (select pnum = 'p1' (supplier_part_projet)) ;

% Provide project names which use red or green parts.
q5s1 := (project pnum ( (select color='Red' (part)) union (select color='Green' (part)) )) ;
q5s2 := (project pnum, jnum (supplier_part_projet)) njoin (q5s1) ;
q5s3 := (project jnum, jname (projet)) njoin (q5s2) ;
q5 := project jname (q5s3) ;

% Provide the part names used in a project with quantity equal to 500.
q6s1 := project pnum (select qty = 500 (supplier_part_projet)) ;
q6s2 := (project pnum, pname (part)) njoin (q6s1) ;
q6 := project pname(q6s2) ;

% Provide all the cities in which suppliers are located, but no parts are located.
q7 := (project city (supplier)) difference (project city (part)) ;

% Provide the supplier name/project name pairs for which the indicated supplier supplies parts to the indicated project.
q8s1 := project snum, jnum (supplier_part_projet) ;
q8s2 := (project snum, sname (supplier)) njoin (q8s1) ;
q8s3 := (project jnum, jname (projet)) njoin (q8s2) ;
q8 := project sname, jname (q8s3) ;

% Provide the supplier name/part name pairs for which the indicated supplier does not supply the indicated part.
q9s1 := (project snum, sname (supplier)) product (project pnum, pname (part)) ;
q9s2 := project snum, pnum (supplier_part_projet) ;
q9s3 := (project snum, sname (supplier)) njoin (q9s2) ;
q9s4 := (project pnum, pname (part)) njoin (q9s3) ;
q9 := (project sname, pname (q9s1)) difference (project sname, pname (q9s4) ) ;


% RELATIONAL ALGEBRA
%-----------------------------------

% ----- query 1 -----
% Retrieve the name and address of all employees who work for the 'Research' department.

%  research_dept := select dname='Research' (department);
%  research_dept_emps := select dnumber=dno (research_dept product employee);
%  alg1 := project fname, lname, address (research_dept_emps);

% ----- query 2 -----
% For every project located in 'Stafford', list the project number, the controlling department number,
% and the department manager's last name, address, and birthdate.

%  stafford_projs := select plocation='Stafford' (projects);
%  contr_dept := select dnum=dnumber (stafford_projs product department);
%  proj_dept_mgr := select mgrssn=ssn (contr_dept product employee);
%  alg2 := project pnumber, dnum, lname, address, bdate (proj_dept_mgr);

% ----- query 3 -----
% Find the names of employees who work on all the projects controlled by department number 5.

%  dept5_projs(pno) := project pnumber (select dnum=5 (projects));
%  emp_proj(ssn, pno) := project essn, pno (works_on);
%  emp_proj_ssns := project ssn (emp_proj);

% All possibilities of employees working on dept5 projects.
%  poss_emps_dept5 := (dept5_projs product emp_proj_ssns);

% Employees that don't work on all dept5 projects..
%  emps_not_dept5 := project ssn (poss_emps_dept5 difference emp_proj);
%  result_emp_ssns := emp_proj_ssns difference emps_not_dept5;
%  alg3 := project lname, fname (result_emp_ssns njoin employee);

% ----- query 4 -----
% Make a list of project numbers for projects that involve an employee whose last name is 'Smith', 
% either as a worker or as a manager of the department that controls the project.

%  smiths(essn) := project ssn (select lname='Smith' (employee));
%  smith_worker_projs := project pno (works_on njoin smiths);
%  mgrs := project lname, dnumber (select ssn=mgrssn (employee product department));
%  smith_mgrs := select lname='Smith' (mgrs);
%  smith_managed_depts(dnum) := project dnumber (smith_mgrs);
%  smith_mgr_projs(pno) := project pnumber (smith_managed_depts njoin projects);
%  alg4 := smith_worker_projs union smith_mgr_projs;
