-- FINAL---
USE MODULE9WINDOW;
drop table sales;
CREATE TABLE sales (
    store_id INT AUTO_INCREMENT PRIMARY KEY,
    state_name VARCHAR(100) NOT NULL,
    city_name VARCHAR(100) NOT NULL,
    store_name VARCHAR(100) NOT NULL,
    sales DECIMAL(10,2) NOT NULL
);



ALTER TABLE sales ADD COLUMN sale_date DATE;

INSERT INTO sales (state_name, city_name, store_name, sales, sale_date) VALUES
('Haryana', 'Karnal', 'Karnal Store 1', 1500.00, '2025-10-01'),
('Haryana', 'Karnal', 'Karnal Store 2', 1300.00, '2025-10-02'),
('Haryana', 'Panipat', 'Panipat Store 1', 1750.00, '2025-10-03'),
('Haryana', 'Panipat', 'Panipat Store 2', 1600.00, '2025-10-04'),
('Haryana', 'Panipat', 'Panipat Store 3', 1550.00, '2025-10-01'),
('Haryana', 'Sonipat', 'Sonipat Store 1', 980.00, '2025-10-02'),
('Haryana', 'KUK', 'KUK Store', 870.00, '2025-10-03'),
('Haryana', 'Karnal', 'Karnal Store 1', 1500.00, '2025-10-04'),
('Haryana', 'Karnal', 'Karnal Store 2', 1300.00, '2025-10-03'),
('Haryana', 'Panipat', 'Panipat Store 1', 1730.00, '2025-10-05');

-- Punjab
INSERT INTO sales (state_name, city_name, store_name, sales, sale_date) VALUES
('Punjab', 'Patiala', 'Patiala Store', 1200.00, '2025-10-01'),
('Punjab', 'Jalandhar', 'Jalandhar Store', 1300.00, '2025-10-02'),
('Punjab', 'Bathinda', 'Bathinda Store 1', 1100.00, '2025-10-01'),
('Punjab', 'Patiala', 'Patiala Store', 1200.00, '2025-10-02'),
('Punjab', 'Jalandhar', 'Jalandhar Store', 1300.00, '2025-10-03'),
('Punjab', 'Bathinda', 'Bathinda Store 2', 1100.00, '2025-10-02');

-- Himachal
INSERT INTO sales (state_name, city_name, store_name, sales, sale_date) VALUES
('Himachal', 'solan', 'solan store', 900.00, '2025-10-01'),
('Himachal', 'mandi', 'mandi store', 850.00, '2025-10-01'),
('Himachal', 'dharamshala', 'dharamshalaStore', 900.00, '2025-10-01'),
('Himachal', 'mandi', 'mandi Store', 800.00, '2025-10-02'),
('Himachal', 'dharamshala', 'dharamshala Store', 900.00, '2025-10-02');

-- Jammu
INSERT INTO sales (state_name, city_name, store_name, sales, sale_date) VALUES
('Jammu', 'Shimla', 'Shimla Store ', 1000.00, '2025-10-01'),
('Jammu', 'Jawalaji', 'Jawalaji Store ', 900.00, '2025-10-01'),
('Jammu', 'Rohtang', 'Rohtang Store ', 900.00, '2025-10-01'),
('Jammu', 'Shimla', 'Shimla Store ', 2000.00, '2025-10-02'),
('Jammu', 'Shimla', 'Shimla Store ', 2000.00, '2025-10-03'),
('Jammu', 'Shimla', 'Shimla Store ', 1000.00, '2025-10-04'),
('Jammu', 'Shimla', 'Shimla Store ', 1000.00, '2025-10-05'),
('Jammu', 'Jawalaji', 'Jawalaji Store', 500.00, '2025-10-02');


SELECT * FROM SALES;

-- COUNT---

-- i wan to count no of stores present in per state 
select state_name,count(*) from sales group by state_name; 

select state_name,count(*)  over (partition by state_name) as state_wise_count from sales; 
select count(*) from sales;

-- count no of stores present citywise and state wise

select state_name,city_name,store_name,count(*) over (partition by state_name) as state_wise_count ,
 count(*) over (partition by city_name) as city_wise_count from sales order by city_wise_count desc; 
 

-- SUM---
-- total sales by city
-- USING GROUPBY

SELECT city_name,SUM(SALES) as city_wise_sale FROM sales group by city_name order by city_wise_sale desc;
-- if i want to see which perticular store  belongs to which city ? (check the bathinda entry)
SELECT city_name ,store_name ,SUM(SALES) as city_wise_sale FROM sales group by city_name,store_name
 order by city_wise_sale desc;
 
-- USING WINDOW FUNCTION
select state_name,sales as sale_per_store,
sum(sales) over (partition by state_name) as state_wise_total
from sales order by STATE_name;

-- USING GROUP BY 

SELECT STATE_name,SUM(SALES) as state_wise_sale FROM sales group by state_name ;

-- you can also calculate citywise store wise in singe sheet
select state_name,city_name,store_name,sales as sale_per_store,
sum(sales) over (partition by state_name) as state_wise_total,
sum(sales) over (partition by city_name) as city_wise_total,
sum(sales) over (partition by store_name) as store_wise_total
from sales order by city_name;


-- jump to 















-- GROUP BY
-- Shows which state generates the most revenue.

SELECT 
    state_name, 
    SUM(sales) AS total_sales
FROM 
    sales
GROUP BY 
    state_name
ORDER BY 
    total_sales DESC;
    
    
    -- Shows which state generates the second highest and third highest revenue.
    
    SELECT state_name, SUM(SALES) over (partition by state_name) as total_sales,

    
    rank() over (partition by state_name order by sales desc) as rank_no,
    dense_rank() over (partition by state_name order by sales desc) as denserank_no
    from  sales order by state_name ASC, 
    sales DESC;
    
    -- Shows which city  generates the most revenue.
    -- Useful for ranking stores within each city
    
    SELECT * , SUM(SALES) over (partition by city_name) as total_sales,
    row_number() over (partition by city_name  order by sales desc) as row_no,
    rank() over (partition by city_name  order by sales desc) as rank_no,
    dense_rank() over (partition by city_name  order by sales desc) as dense_no
    from  sales order by state_name ASC, 
    sales DESC;
    
    select * from (SELECT * , SUM(SALES) over (partition by city_name) as total_sales,
    row_number() over (partition by city_name  order by sales desc) as row_no,
    rank() over (partition by city_name  order by sales desc) as rank_no,
    dense_rank() over (partition by city_name  order by sales desc) as dense_no
    from  sales order by state_name ASC, 
    sales DESC)tb1 where dense_no=1;
    
    SELECT * , SUM(SALES) over (partition by state_name) as total_sales,
    rank() over (partition by city_name  order by sales desc) as rank_
    from  sales order by state_name ASC, 
    sales DESC;
    
    select *,rank() over (partition by state_name order by sales desc) as rank_no 
    from (SELECT * , SUM(SALES) over (partition by state_name) as total_sales from sales)tb1 order by state_name;

    
    Helps identify top-performing cities.
    
    SELECT state_name,
    city_name, 
    SUM(sales) AS total_sales
FROM 
    sales
GROUP BY 
    state_name,city_name
ORDER BY 
    total_sales DESC;
    
    select state_name,city_name ,sum(sales) over (partition by state_name,city_name ) as total_sales from sales;
    
    
    Top 5 overall Highest Earning Stores(See which stores contribute the most to revenue)
    
    SELECT 
    store_name, 
    city_name, 
    state_name, 
    sales
FROM 
    sales
ORDER BY 
    sales DESC
LIMIT 5;


-- city wise highest earning store 
-- but i want second highest earning or third highest earning city wise 
-- row_num(),
select * from (select *,row_number() over (partition by city_name ) as rownum from sales) as tb1 where rownum=2;

select *,rank() over (partition by city_name order by sales desc) as toprank from sales order by toprank asc ;




Average Sales per Store per State
SELECT 
    state_name, 
    COUNT(*) AS number_of_stores,
    AVG(sales) AS average_sales
FROM 
    sales
GROUP BY 
    state_name
ORDER BY 
    average_sales DESC;
    

    

    
    

