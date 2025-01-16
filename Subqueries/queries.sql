Ques 1 :-> How can you use a subquery to find employees who earn more than the average salary?

-- Theory: A subquery is a query nested inside another query. In this case, the subquery will compute the average salary from the employees table, and the outer query will then compare each employee's salary to that average.

Query: SELECT * FROM employees;
Output:
 employee_id | employee_name |  salary  
-------------+---------------+----------
           1 | Abhinav       | 50000.00
           2 | Varun         | 40000.00
           3 | Ayush         | 60000.00
           4 | Priyanshu     | 30000.00
(4 rows)

Query: SELECT employee_name, salary FROM employees WHERE salary > (SELECT AVG(salary) FROM employees);

Output:
 employee_name |  salary  
---------------+----------
 Abhinav       | 50000.00
 Ayush         | 60000.00
(2 rows)



Ques 2 :-> What is the difference between EXISTS and IN subqueries?

-- Theory: Checks if any rows satisfy a condition in the subquery.

Query: ALTER TABLE employees ADD department_id INTEGER;
Output:
ALTER TABLE
Query: UPDATE employees SET department_id = CASE employee_id WHEN 1 THEN 1 WHEN 2 THEN 2 WHEN 3 THEN 2 WHEN 4 THEN 3 ELSE NULL END;
Output:
UPDATE 4

Query: SELECT * FROM employees;
Output:
 employee_id | employee_name |  salary  | department_id 
-------------+---------------+----------+---------------
           1 | Abhinav       | 50000.00 |             1
           2 | Varun         | 40000.00 |             2
           3 | Ayush         | 60000.00 |             2
           4 | Priyanshu     | 30000.00 |             3
(4 rows)

Main Query: SELECT employee_name FROM employees e WHERE EXISTS (SELECT 1 FROM employees sub WHERE e.department_id = sub.department_id GROUP BY department_id HAVING COUNT(*) > 1);

Output:
 employee_name 
---------------
 Varun
 Ayush
(2 rows)

-- Theory: Checks if a value (or set of values) is present in a list returned by the subquery.

Main Query: SELECT employee_name FROM employees WHERE department_id IN (SELECT department_id FROM employees GROUP BY department_id HAVING COUNT(*) > 1);

Output:
 employee_name 
---------------
 Varun
 Ayush
(2 rows)



Ques 3 :-> How can you use a correlated subquery to find customers who have placed the most orders?

-- Theory: A correlated subquery is a subquery that references columns from the outer query, allowing for dynamic interaction between the two queries.

Query: CREATE TABLE customers ( customer_id INT PRIMARY KEY, customer_name VARCHAR(50));
Output:
CREATE TABLE

Query: INSERT INTO customers ( customer_id, customer_name) VALUES (1, 'Abhinav'), (2, 'Varun'), (3, 'Ayush'), (4, 'Priyanshu');
Output:
INSERT 0 4

Query: CREATE TABLE orders (order_id INT PRIMARY KEY, customer_id INT REFERENCES customers(customer_id), order_date DATE);
Output:
CREATE TABLE

Query: INSERT INTO orders( order_id, customer_id, order_date) VALUES (1, 1, '2025-01-10'), (2, 1, '2025-01-11'), (3, 2, '2025-01-12'), (4, 3, '2025-01-13'), (5, 4, '2025-01-14'), (6, 4, '2025-01-15');
Output:
INSERT 0 6
Query: INSERT INTO orders( order_id, customer_id, order_date) VALUES (7, 1, '2025-01-17');
Output:
INSERT 0 1

Main Query: SELECT customer_name FROM customers c WHERE customer_id = (SELECT customer_id FROM orders GROUP BY customer_id ORDER BY COUNT(*) DESC LIMIT 1);

Output:
 customer_name 
---------------
 Abhinav
(1 row)



Ques 4 :-> Can you use a subquery in the FROM clause? If so, how?

-- Theory: Yes, i can use a subquery in the FROM clause, and it is commonly referred to as a derived table. A subquery in the FROM clause acts as a temporary table that you can query from in the outer query.

Query: SELECT d.department_id, d.average_salary FROM( SELECT department_id, AVG(salary) AS average_salary FROM employees GROUP BY department_id) d WHERE d.average_salary > 40000;

Output:
 department_id |   average_salary   
---------------+--------------------
             2 | 50000.000000000000
             1 | 50000.000000000000
(2 rows)



Ques 5 :-> How can you use a subquery to find the department with the highest average salary?

Query: SELECT department_id, AVG(salary) AS avg_salary FROM employees GROUP BY department_id HAVING AVG(salary) = (SELECT MAX(avg_salary) FROM (SELECT department_id, AVG(salary) AS avg_salary FROM employees GROUP BY department_id));

Output:
 department_id |     avg_salary     
---------------+--------------------
             2 | 50000.000000000000
             1 | 50000.000000000000
(2 rows)



Ques 6 :-> What are some common performance issues with subqueries?
-- Theory: Correlated subqueries: Evaluated for each row in the outer query, leading to poor performance on large datasets.
-- Large result sets: Subqueries returning many rows can slow down the query (e.g., using IN with large data).
-- Unoptimized execution: Lack of indexes on columns referenced in the subquery degrades performance.
-- Nested subqueries: Multiple layers of subqueries increase complexity and execution time.



Ques 7 :-> How can you optimize a subquery to improve performance?

-- Theory: Replace IN with EXISTS or JOIN.

Query: SELECT c.customer_id FROM customers c JOIN (SELECT customer_id,
 COUNT(*) AS order_count FROM orders GROUP BY customer_id) o ON c.customer_id =
o.customer_id WHERE o.order_count > 2;

Output:
 customer_id 
-------------
           1
(1 row)



Ques 8 :-> Can you use a subquery within another subquery?

-- Theory: Yes, i can use a subquery within another subquery. This is known as a nested subquery. SQL allows subqueries to be nested at multiple levels, depending on the complexity of the query and the requirements of the task.

Query: SELECT employee_name FROM employees WHERE salary > ( SELECT AVG(salary) FROM employees WHERE department_id = ( SELECT department_id FROM employees GROUP BY department_id ORDER BY AVG(salary) DESC LIMIT 1));

Output:
 employee_name 
---------------
 Ayush
(1 row)



Ques 9 :-> How can you use a subquery to find duplicate records in a table?

--Theory: To find duplicate records in a table using a subquery, the goal is to identify rows where certain columns (or combinations of columns) have the same values across multiple rows. Subqueries are an effective way to achieve this by leveraging aggregation and filtering techniques.

Query: SELECT employee_name FROM employees GROUP BY employee_name HAVING COUNT(*) > 1;
Output:

 employee_name 
---------------
(0 rows)



Ques 10 :-> What are some real-world examples of how subqueries are used in business applications?

--Theory: Subqueries are powerful tools for answering business-specific questions that require dynamic filtering, aggregation, and hierarchical data analysis.

Query: ALTER TABLE orders ADD COLUMN price NUMERIC(10, 2);
Output:
ALTER TABLE

Query: UPDATE orders SET price = CASE order_id
WHEN 1 THEN 300.00
WHEN 2 THEN 400.00
WHEN 3 THEN 500.00
WHEN 4 THEN 350.00
WHEN 5 THEN 600.00
WHEN 6 THEN 850.00
WHEN 7 THEN 450.00 END;
Output:
UPDATE 7

Main Query: SELECT customer_id, customer_name FROM customers WHERE (SELECT
SUM(price) FROM orders WHERE orders.customer_id = customers.customer_id) > ( SEL
ECT AVG(price) FROM orders);

Output:
 customer_id | customer_name 
-------------+---------------
           1 | Abhinav
           2 | Varun
           4 | Priyanshu
(3 rows)

