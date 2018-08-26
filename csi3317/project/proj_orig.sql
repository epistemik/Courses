
create table Dept (
Number CHAR(12),
Name VARCHAR2(40) NOT NULL,
constraint PK_DEPTNUMBER PRIMARY KEY (Number) );

create table Employee (
Number CHAR(12),
Ename VARCHAR2(40) NOT NULL,
constraint PK_EMPLOYEENUMBER PRIMARY KEY (Number) );

create table Project (
Name VARCHAR2(40),
City VARCHAR2(40) NOT NULL,
constraint PK_PROJECTNAME PRIMARY KEY (Name));

create table Works (
Dnumber CHAR(12),
Enumber CHAR(12),
constraint PK_WORKSNUMBERS PRIMARY KEY (Dnumber, Enumber),
constraint FK_DNUMBER FOREIGN KEY (Dnumber) REFERENCES Dept.Number,
constraint FK_ENUMBER FOREIGN KEY (Enumber) REFERENCES Employee.Number );

create table Works_On (
Number CHAR(12),
Name VARCHAR2(40),
constraint PK_WORKS_ONNUMBER PRIMARY KEY (Number),
constraint FK_NUMBER FOREIGN KEY (Number) REFERENCES Employee,
constraint FK_NAME FOREIGN KEY (Name) REFERENCES Project );

create table Dependent (
Dname VARCHAR2(40),
Number CHAR(12),
constraint PK_DEPENDENTKEYS PRIMARY KEY (Dname, Number),
constraint FK_EMPNUMBER FOREIGN KEY (Number) REFERENCES Employee );

rem   Assumptions
rem  -------------
rem  1. Dept.Number and Employee.Number are different numbers.
rem  2. Numbers may have alphabetic characters.
rem  3. 12 places is enough space for a number.
rem  4. 40 places (half a line) is enough space for a name.
rem  5. No distinct instantiation of table Emp_Dep is required.
