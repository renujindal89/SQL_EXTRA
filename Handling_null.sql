-- HANDLING NUL VALUES
use module_4;
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);
INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate)
VALUES
(101, 'Amit', 'Sharma', 'IT', 75000.00, '2020-03-15'),
(102, 'Neha', 'Verma', 'HR', 62000.00, '2019-07-01'),
(103, 'Raj', 'Singh', 'Finance', 68000.00, '2021-01-10'),
(104, 'Priya', 'Mehta', 'Marketing', 71000.00, '2022-06-25'),
(105, 'Karan', 'Patel', 'IT', 80000.00, '2018-11-30');
 select * from Employees;
 select concat(name, ' ',department) from employees;
 
 CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    WorkEmail VARCHAR(100),
    PersonalEmail VARCHAR(100),
    BackupEmail VARCHAR(100)
);
INSERT INTO Users (UserID, WorkEmail, PersonalEmail, BackupEmail) VALUES
(1, NULL, 'john@gmail.com', NULL),
(2, 'jane@company.com', NULL, NULL),
(3, NULL, NULL, 'user3@backup.com'),
(4, NULL, NULL, NULL);
select * from users;

select * from users where backupemail is null;
select sum( case when WorkEmail is null then 1 else 0 end )as null_count_workemail from users; 

SELECT CONCAT(workemail,personalemail) from users;


CREATE TABLE Emps (
    EmpID INT,
    EmpName VARCHAR(50),
    Salary DECIMAL(10, 2),
    AnnualBonus DECIMAL(10, 2)
);
 
INSERT INTO Emps(EmpID, EmpName, Salary, AnnualBonus)
VALUES 
(1, 'Raj', 60000, 6000),
(2, 'Brijesh', NULL, 8000),
(3, 'John', 75000, NULL),
(4, 'Manoj', NULL, 4500),
(5, 'Vanshil', 51000, NULL);
select * from emps;
SELECT Salary + AnnualBonus AS TotalCompensation FROM Emps;
select count(salary) as total_row from emps;
select count(empname) as total_emp from emps;
-- SELECT COUNT(*) AS TotalEmployees, COUNT(Salary) AS CountofSalary, COUNT(AnnualBonus) AS CountOfAnnualBous FROM Emps;

-- USE CASES
-- 1 IS NULL( TO FECTCH THE ROWS HAVING NULL VAUES )
-- select * from table where column is null'
-- 2 If NULL (fill null with the specified value, OR WE CAN SAY replace NULL values with a specified value)
-- 3--- COALESCE (Return the first non-null value in a list)

SELECT ifnull(NULL, 'Default Value') AS Result;
SELECT IfNULL(NULL, 20) AS Result;
SELECT IfNULL('Hello', 'Hi') AS Result;






-- to handle this we use coalesce
SELECT EmpName, Coalesce(AnnualBonus,0) FROM Emps;
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    WorkEmail VARCHAR(100),
    PersonalEmail VARCHAR(100),
    BackupEmail VARCHAR(100)
);
INSERT INTO Users (UserID, WorkEmail, PersonalEmail, BackupEmail) VALUES
(1, NULL, 'john@gmail.com', NULL),
(2, 'jane@company.com', NULL, NULL),
(3, NULL, NULL, 'user3@backup.com'),
(4, NULL, NULL, NULL);
select * from users;
SELECT WORKEMAIL + ' ' + personalemail FROM users;
SELECT CONCAT(workemail,personalemail) from users;
select concat(coalesce(workemail,personalemail,'notdefined') ,'  ','id') from users;
select workemail,ifnull(workemail,'notdefined')  from users;
SELECT 
  UserID,
  COALESCE(WorkEmail, PersonalEmail, BackupEmail, 'No Email Available') AS PreferredEmail
FROM Users;
-- If either is NULL, result is NULL


-- DIFFERENCE between if null and coalesce
-- both function is used to replace NULL with a specified replacement valu
if null takes two  argument ( checking_expression,replacement_value)
coalesce takes multiple  argument

SELECT 
  UserID,
  COALESCE(WorkEmail, PersonalEmail, BackupEmail, 'No Email Available') AS PreferredEmail
FROM Users;



⚠️ Important Notes
- NVL is Oracle-specific. For other databases:
- SQL Server: Use ISNULL()
- MySQL: Use IFNULL()
- PostgreSQL: Use COALESCE()
- 
