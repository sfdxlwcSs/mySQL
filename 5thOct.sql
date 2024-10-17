create database mtechbsec;
# use database mtechbsec

drop database mtechbsec;

CREATE TABLE student (
    sid INTEGER,
    sname VARCHAR(20),
    email VARCHAR(20),
    aadharno VARCHAR(25),
    phoneno INT,
    sex CHAR(1)
);

Alter table student 
modify column sid INTEGER AUTO_INCREMENT,
ADD PRIMARY KEY (sid);

CREATE TABLE studentClone (
    sid INTEGER AUTO_INCREMENT,
    sname VARCHAR(20),
    email VARCHAR(20),
    aadharno VARCHAR(25),
    phoneno INT(11),
    sex CHAR(1),
    primary key(sid) 
);



ALTER TABLE student
MODIFY COLUMN phoneno int;

ALTER TABLE student
MODIFY COLUMN phoneno varchar(12);
ALTER TABLE student
CHANGE COLUMN phoneno contact_no integer; #CHANGE column name

describe  student;

insert into student (sname,email,aadharno,contact_no,sex) values('Employee1','emp12@dovercorp.com','S123fjhgk7',741186086,'M');
insert into student (sname,email,aadharno,contact_no,sex) values('Employee11','emp11@dovercorp.com','S12dfjhgk7',941186086,'M');

 
UPDATE student 
SET 
    phoneno = '7411860065'
WHERE
    (sid = 1);
    
SELECT 
    contact_no, marks
FROM
    student
WHERE
    sid = 1;
    
ALTER TABLE student
CHANGE COLUMN phoneno contact_no varchar(12);

ALTER TABLE student
ADD COLUMN marks  integer;

ALTER TABLE student
ADD COLUMN enrollmentdate datetime DEFAULT CURRENT_TIMESTAMP  ;

UPDATE student 
SET 
    email = 'emp5@dovercorp.com'
WHERE
    (sid = 5);
    
insert into student (sid,sname,email,aadharno,contact_no,sex,marks) values(2,'Employee2','emp2@dovercorp.com','S143fjhgk7',441186006,'F',91);
insert into student (sid,sname,email,aadharno,contact_no,sex,marks) values(3,'Employee3','emp3@dovercorp.com','S14bfjhgk7',641186006,'F',91);
insert into student (sid,sname,email,aadharno,contact_no,sex,marks) values(4,'Employee4','emp4@dovercorp.com','Sg43fjhgk7',641186006,'F',91);
insert into student (sid,sname,email,aadharno,contact_no,sex,marks) values(7,'Employee7','emp7@dovercorp.com','Sg43fjhgk7',641186005,'F',91);
#if u no the order of columns then use below syntax
insert into student  values(5,'Employee5','emp2@dovercorp.com','S143fjhgk7',441186006,'F',91);
insert into student  values(6,'Employee7','emp7@dovercorp.com','S143vjhgk7',441126006,'M',94);
insert into student  values(7,'Em##ployee6','emp6@dovercorp.com','S1g3vjhgk7',441126606,'M',64,NULL);
insert into student  values(8,'Employee8','emp8@dovercorp.com','S143vvhgk7',445126006,'F',74,null);
insert into studentclone  (sname,email,aadharno,phoneno,sex) values('Employee1','emp8@dovercorp.com','S143vvhgk7',445126006,'F');
insert into studentclone  (sname,email,aadharno,phoneno,sex) values('Employee7','emp7@dovercorp.com','S143vjhgk7',441126006,'M');

SELECT 
    COUNT(*)
FROM
    student;
    
SELECT 
    COUNT(email)
FROM
    student;
#aliasing
SELECT 
    sid Id
FROM
    student;
    
SELECT 
    sid, sname AS student_name
FROM
    student;
SELECT 
    sid, sname
FROM
    student;
ALTER TABLE student
MODIFY COLUMN contact_no varchar(12) UNIQUE;
 select sid from student;
 

