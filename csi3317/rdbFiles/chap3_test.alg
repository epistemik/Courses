% Mark Sattolo 428500

perry_branch := select bname = 'Perryridge' (loan);

loan1200 := select amount > 1200 (loan) ;

branch_loan := select (bname = 'Perryridge') and (amount > 1300) (loan) ;

show_loan := project lnumber ( select bname = 'Perryridge' (loan) ) ;

show_loan2 := project lnumber, amount ( perry_branch ) ;

name_city := project cname, cstreet ( select ccity = 'Harrison' (customer) ) ;



% RELATIONAL ALGEBRA
%------------------------------


% ----- query 1 -----

% Retrieve the name and address of all employees who work for the 'Research' department.


% research_dept:=select dname='Research' (department);

% research_dept_emps:=select dnumber=dno (research_dept product employee);

% alg1:=project fname, lname, address (research_dept_emps);

