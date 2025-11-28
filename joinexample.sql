CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    age INT,
    city VARCHAR(50),
    group_id INT
);
INSERT INTO students (student_id, student_name, age, city, group_id) VALUES
(101, 'Aanya', 19, 'Delhi', 103),
(102, 'Rohan', 20, 'Mumbai', 103),
(103, 'Mehak', 18, 'Chandigarh',104),
(104, 'Arjun', 21, 'Pune', 104),
(105, 'Simran', 22, 'Pune', NULL),
(106, 'Kabir', 20, 'Chandigarh',102),
(107, 'Tanya', 19, 'Bhopal', 102),
(108, 'Devansh', 23, 'Pune', 101),
(109, 'Ishita', 21, 'Pune', 101),
(110, 'Yuvraj', 22, 'Hyderabad', NULL);

CREATE TABLE courses (
student_id int,
    course_id VARCHAR(10) ,
    course_name VARCHAR(100),
    duration_months INT,
    instructor_name VARCHAR(100)
);
INSERT INTO courses (student_id,course_id, course_name, duration_months, instructor_name) VALUES
(101,'C01', 'Mathematics', 6, 'Dr. Verma'),
(102,'C02', 'Physics', 5, 'Prof. Iyer'),
(null,'C03', 'Chemistry', 6, 'Dr. Kapoor'),
(104,'C04', 'Computer Science', 4, 'Ms. Sharma'),
(105,'C05', 'English Literature', 3, 'Mr. D\'Souza'),
(null,'C06', 'Economics', 5, 'Dr. Mehta'),
(107,'C05', 'English Literature', 6, 'Dr. Rao'),
(108,'C08', 'History', 4, 'Prof. Singh'),
(null,'C09', 'Psychology', 5, 'Ms. Thomas'),
(110,'C05', 'English Literature', 6, 'Mr. Chatterjee');

drop database db1;
create database db1;		
use db1;
SELECT * FROM students;
SELECT * FROM courses;
-- Q1 Find students and the courses they’re enrolled
SELECT s.student_id,s.student_name, c.course_name
FROM students s
INNER JOIN courses c ON s.student_id=c.student_id;

-- Q2- Find students who are not enrolled in any course
SELECT s.student_id,s.student_name,c.course_id
FROM students s
LEFT JOIN courses c ON s.student_id = c.student_id
WHERE c.course_id IS NULL;

-- Q3Count how many students are enrolled in each course:
select  s.student_id,s.student_name,c.course_id,count(*)
FROM students s
LEFT JOIN courses c ON s.student_id = c.student_id
group by course_id,student_name,student_id;

-- Q4Identify which courses have the highest enrollment
select course_name,count(*) from courses group by course_name;

-- Q5 Understand the age profile of students in each course
select c.course_id,avg(s.age)  from students s left join courses c on s.student_id=c.student_id
group by c.course_id;

-- See which cities have the most active student
select s.city,count(*) from students s join courses c on s.student_id=c.student_id
group by s.city;

-- matching customer by city (This returns only pairs of customers who share the same city.)

SELECT 
    A.cust_name AS Customer1, 
    B.cust_name AS Customer2, 
    A.city
FROM 
    Customers A
JOIN 
    Customers B ON A.city = B.city AND A.customer_id <> B.customer_id;

-- SELF JOIN 

select s.student_name,s1.student_name as partner_name,s.student_id,s1.group_id as partner_id from students s
join students s1 on s.group_id=s1.student_id;

-- SELF JOIN 
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    manager_id INT
);
INSERT INTO Employees VALUES
(1, 'Zaid', 3),
(2, 'Rahul', 3),
(3, 'Raman', 4),
(4, 'Kamran', NULL),
(5, 'Farhan', 4);
SELECT 
    e.employee_name AS Employee,
    m.employee_name AS Manager
FROM 
    Employees e
JOIN 
    Employees m ON e.manager_id = m.employee_id;
    
    -- matching customer by city (This returns only pairs of customers who share the same city.)

SELECT  s.student_name,s1.student_name as partner_name ,s.city
FROM 
    students s
JOIN 
    students s1 ON s.city = s1.city AND s.student_id < s1.student_id;
-- <>
-- CROSS JOIN 

CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100)
);
CREATE TABLE regions (
    region_id VARCHAR(10) PRIMARY KEY,
    region_name VARCHAR(50)
);
INSERT INTO products (product_id, product_name) VALUES
('P01', 'Running Shoes'),
('P02', 'Leather Jacket'),
('P03', 'Sunglasses'),
('P04', 'Backpack'),
('P05', 'Smartwatch');

INSERT INTO regions (region_id, region_name) VALUES
('R01', 'North'),
('R02', 'South'),
('R03', 'East'),
('R04', 'West');
SELECT 
    p.product_id, 
    p.product_name, 
    r.region_id, 
    r.region_name
FROM products p
CROSS JOIN regions r;







