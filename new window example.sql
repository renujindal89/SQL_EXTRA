create database demo1;
use demo1;
drop table student;
create table student (student_id int,stu_name varchar(20),subject varchar(20),grade decimal(10,2));
insert into student values (1,'alice','math',85);
insert into student values (1,'alice','science',92);
insert into student values (1,'alice','eng',88);
insert into student values (2,'bob','math',90);
insert into student values (2,'bob','science',78);
insert into student values (2,'bob','eng',85);
insert into student values (3,'charlie','math',75);
insert into student values (3,'charlie','science',80);
insert into student values (3,'charlie','eng',95);
insert into student values (4,'david','math',85);
insert into student values (4,'david','science',88);
insert into student values (4,'david','eng',88);
 select * from student;
 
 -- assign a rank to each student based on their grade in each subject
 -- calculate the average grade for each student across all subject
 -- see the diff between each student's grade and the highest grade in the same subject
 select student_id,stu_name,subject,grade,avg(grade) over (partition by subject ) as avg_grade from student;
 
 select *,rank() over (partition by stu_name order by grade desc ) as rnk from student;
 select *,(max(grade) over (partition by subject )-grade) from student;
 
  select *,row_number() over (partition by stu_name order by grade desc ) as row_no,
  rank() over (partition by stu_name order by grade desc ) as rnk,
  dense_rank() over (partition by stu_name order by grade desc ) as drnk from student;
  
  

  
  -- FIRST_VALUE 
  First and last subject per student (alphabetically).

First and last marks per student (by subject order).

ROWS	Operate on physical rows (not logical ranks or values).
UNBOUNDED PRECEDING	Start from the first row in the partition.
UNBOUNDED FOLLOWING	Go up to the last row in the partition.
default frame is
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW


SELECT 
    student_id,
    stu_name,
    subject,
    grade,
    FIRST_VALUE(grade) OVER (
        PARTITION BY student_id 
        ORDER BY subject desc
    ) AS first_subject from student;


SELECT 
    student_id,
    stu_name,
    subject,
    grade,
    FIRST_VALUE(grade) OVER (
        PARTITION BY student_id 
        ORDER BY subject
    ) AS first_subject,
    LAST_VALUE(grade) OVER (
        PARTITION BY student_id 
        ORDER BY subject
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS last_subject
FROM student;

-- other method
-- NTH 
SELECT 
    student_id,
    stu_name,
    subject,
    GRADE,
    NTH_VALUE(grade, 4) OVER (
        PARTITION BY student_id 
        ORDER BY grade DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS second_highest_mark
FROM student;