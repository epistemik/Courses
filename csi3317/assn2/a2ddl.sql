create table supplier (
s# CHAR(9),
sname VARCHAR2(27) NOT NULL,
status NUMBER,
city VARCHAR2(27),
PRIMARY KEY (s#));

create table part (
p# CHAR(9),
pname VARCHAR2(27) NOT NULL,
color VARCHAR2(27),
weight NUMBER,
city VARCHAR2(27),
PRIMARY KEY (p#));

create table project (
j# CHAR(9),
jname VARCHAR2(27) NOT NULL,
city VARCHAR2(27),
PRIMARY KEY (j#));

create table spj (
s# CHAR(9),
p# CHAR(9),
j# CHAR(9),
qty NUMBER CHECK (qty <= 1000),
PRIMARY KEY (s#,p#,j#),
constraint SUPPLIER#_FK FOREIGN KEY (s#) REFERENCES supplier,
constraint PART#_FK FOREIGN KEY (p#) REFERENCES part,
constraint PROJECT#_FK FOREIGN KEY (j#) REFERENCES project );
