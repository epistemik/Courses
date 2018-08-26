rem  Database Scheme Design using Entity Relationship Diagrams
rem  Mark Sattolo  428500
rem  CSI3317B - Class Project - Oracle SQL


create table Dept (
Dnumber CHAR(12),
Name VARCHAR2(50) NOT NULL,
constraint PK_DEPT_DNUMBER PRIMARY KEY (Dnumber) );

create table Employee (
Enumber CHAR(12),
Ename VARCHAR2(50) NOT NULL,
constraint PK_EMPLOYEE_ENUMBER PRIMARY KEY (Enumber) );

create table Project (
Name VARCHAR2(50),
City VARCHAR2(50) NOT NULL,
constraint PK_PROJECT_NAME PRIMARY KEY (Name));

create table Works (
Dnumber CHAR(12),
Enumber CHAR(12),
constraint PK_WORKS_DE PRIMARY KEY (Dnumber, Enumber),
constraint FK_WORKS_DNUMBER FOREIGN KEY (Dnumber) REFERENCES Dept,
constraint FK_WORKS_ENUMBER FOREIGN KEY (Enumber) REFERENCES Employee );

create table Works_On (
Enumber CHAR(12),
Name VARCHAR2(50) NOT NULL,
constraint PK_WORKS_ON_ENUMBER PRIMARY KEY (Enumber),
constraint FK_WORKS_ON_ENUMBER FOREIGN KEY (Enumber) REFERENCES Employee,
constraint FK_WORKS_ON_NAME FOREIGN KEY (Name) REFERENCES Project );

create table Dependent (
Dname VARCHAR2(50),
Enumber CHAR(12),
constraint PK_DEPENDENT_DE PRIMARY KEY (Dname, Enumber),
constraint FK_DEPENDENT_ENUMBER FOREIGN KEY (Enumber) REFERENCES Employee on delete cascade );


rem   Assumptions
rem  -------------
rem  1. Dept Number and Employee Number in the diagram are different numbers.
rem  2. Since 'Number' is a reserved word in Oracle, we can use Dnumber  
rem     and Enumber instead in Dept and Employee respectively.
rem  3. The 'Number' attributes may contain alphabetic characters but are
rem     a fixed size.
rem  4. 12 places is enough space for the Number type attributes.
rem  5. 50 places (more than half a line) is enough maximum space for 
rem     the Name and City type attributes.
rem  6. Non-PK attributes should not be null.
rem  7. No distinct instantiation of relationship set Emp_Dep is required.
rem  8. Since entity set Employee is not existence dependent on entity set Project,
rem     it is preferable to have an explicit table for relationship set Works_On. 
rem  9. Except where explicitly modified, the default foreign key operations
rem     for delete (reject) and update (cascade) are acceptable.
