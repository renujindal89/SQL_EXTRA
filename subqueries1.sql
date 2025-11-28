CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id VARCHAR(10),
    salary DECIMAL(10,2),
    manager_id INT,
    department_id INT
);
Single-Row Subquery
Scalar Subqueries
When a subquery returns a single value, or exactly one row and exactly one column, we call it a scalar subquery
Definition: Returns a single row with a single value.
Use Case: Typically used with comparison operators like =, <, >, etc.

SELECT name
FROM employees
WHERE department_id = (SELECT department_id FROM departments WHERE department_name = 'HR');

2. Multi-Row Subquery
Definition: Returns multiple rows.
Use Case: Used with operators like IN, ANY, or ALL.
Example:
Sql

Copy code
SELECT name
FROM employees
WHERE department_id IN (SELECT department_id FROM departments WHERE location = 'New York');

-- Retrieve employees working in departments located in 'New York' or 'Chicago'
SELECT emp_name, department_id
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE location IN ('New York', 'Chicago')
);

-- Find employees whose salary is greater than any employee in department 10
SELECT emp_name, salary
FROM employees
WHERE salary > ANY (
    SELECT salary
    FROM employees
    WHERE department_id = 10
);




3. Multi-Column Subquery
Definition: Returns multiple columns (a set of rows with multiple values).
Use Case: Often used in WHERE or FROM clauses.
Example:
Sql

Copy code
SELECT name
FROM employees
WHERE (department_id, job_id) IN (SELECT department_id, job_id FROM jobs WHERE salary > 50000);

4. Correlated Subquery
Definition: A subquery that references columns from the outer query.
Use Case: Executes once for every row in the outer query.
Example:
Sql

Copy code
SELECT name
FROM employees e
WHERE salary > (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id);
5. Nested Subquery
Definition: A subquery within another subquery.
Use Case: Used for deeply complex queries.
Example:
Sql

Copy code
SELECT name
FROM employees
WHERE department_id = (SELECT department_id FROM departments WHERE location_id = (SELECT location_id FROM locations WHERE city = 'London'));
These subqueries enhance SQL's flexibility, allowing for efficient data retrieval and manipulation.














The following statement uses a subquery to find the employees who have the highest salary:
SELECT
  first_name,
  salary
FROM
  employees
WHERE
  salary = (
    SELECT
      MAX(salary)
    FROM
      employees
  );
  The following example uses a subquery to find employees with a salary greater than the average salary:
  SELECT
  first_name,
  salary
FROM
  employees
WHERE
  salary > (
    SELECT
      AVG(salary)
    FROM
      employees
  )
ORDER BY
  salary;
  the following query uses a subquery with the IN operator to find all employees with the job titles related to Sales:
  SELECT
  first_name,
  last_name
FROM
  employees
WHERE
  job_id IN (
    SELECT
      job_id
    FROM
      jobs
    WHERE
      job_title LIKE '%Sales%'
  );
  
  The following example uses a subquery in the SELECT clause to retrieve the first name, salary, and average salary of all employees:
  
  SELECT
  first_name,
  salary,
  (
    SELECT
      ROUND(AVG(salary),2) average_salary
    FROM
      employees
  )
FROM
  employees
ORDER BY
  salary;
  
  The following example shows how to use a subquery in the FROM clause:

SELECT
  ROUND(AVG(department_salary), 0) average_department_salary
FROM
  (
    SELECT
      department_id,
      SUM(salary) department_salary
    FROM
      employees
    GROUP BY
      department_id
  );
  
  The following example uses a subquery in the INNER JOIN clause of the outer query to 
  retrieve employees who earn above the company’s average salary:
  SELECT
  first_name,
  last_name,
  salary,
  s.avg_salary
FROM
  employees e
  INNER JOIN (
    SELECT
      ROUND(AVG(salary), 0) AS avg_salary
    FROM
      employees
  ) s ON e.salary > s.avg_salary
ORDER BY
  salary;