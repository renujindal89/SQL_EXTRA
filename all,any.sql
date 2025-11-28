create table sub1(id int,name varchar(30),goal int);
insert into sub1 values(1,'renu',12),(2,'ritu',20),(3,'payal',30);
create table sub2(sid int,sname varchar(20),sgoal int);
insert into sub2 values(101,'a',15),(102,'b',20);
select * from sub1;
select * from sub2;

SELECT Name
FROM sub1
WHERE Goal >all (
    SELECT sGoal
    FROM sub2
);
