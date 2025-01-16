
Ques 1 :-> How do you create a view in PostgreSQL?

Query:  CREATE VIEW employee_salary_view AS
        SELECT employee_id, employee_name, salary
        FROM employees
        WHERE salary > 50000;

Output: 
CREATE VIEW

Query: \dv employee_salary_view;
Output: 

                List of relations
 Schema |         Name         | Type |  Owner   
--------+----------------------+------+----------
 public | employee_salary_view | view | postgres
(1 row)


Ques 2 :-> What are the benefits of using views?

--Theory: Simplification of Complex Queries: Views allow you to encapsulate complex queries and provide a simplified interface to users, making it easier to interact with the data.
--        Abstraction: Views provide an abstraction layer over the underlying tables, so users can work with predefined data structures rather than needing to understand complex joins and subqueries.
--        Data Security: Views can expose only specific columns or rows of data, improving security by restricting access to sensitive information.
--        Reusability: Once defined, views can be reused in multiple queries without needing to rewrite the logic each time.



Ques 3 :-> How can you update data through a view?

Query: SELECT * FROM employees;
Output: 
 employee_id | employee_name |  salary  | department_id 
-------------+---------------+----------+---------------
           1 | Abhinav       | 70000.00 |             1
           2 | Varun         | 40000.00 |             2
           3 | Ayush         | 60000.00 |             2
           4 | Priyanshu     | 30000.00 |             3
(4 rows)

Main Query: SELECT * FROM employee_salary_view;
            UPDATE employees
            SET salary = 90000;
Output:
UPDATE 1

Query: SELECT * FROM employee_details_view WHERE salary > 50000;
Output: 
 employee_id | employee_name |  salary  
-------------+---------------+----------
           1 | Abhinav       | 70000.00
           3 | Ayush         | 90000.00
(2 rows)



Ques 4 :-> What are the limitations of using views?

--Theory: Performance Overhead: Views can sometimes introduce performance overhead, especially when they are based on complex queries or large datasets. Each time the view is accessed, the underlying query is executed.
--        Non-Updatable Views: Views based on joins, aggregates, or other complex operations may not allow direct updates, making them less flexible in some cases.



Ques 5 :-> How can you use views to improve data security?

--Theory: Restricting Data Access: You can create views that expose only a subset of the data (e.g., only certain columns or rows) to users, preventing them from accessing sensitive or irrelevant information.
--        Hiding Sensitive Data: You can hide sensitive columns like passwords or personal information in the underlying tables by not including them in the view.

Query:  CREATE VIEW employee_info AS
        SELECT employee_id, employee_name
        FROM employees;

Output:
CREATE VIEW

Query: \dv employee_info;
Output:
           List of relations
 Schema |     Name      | Type |  Owner   
--------+---------------+------+----------
 public | employee_info | view | postgres
(1 row)


Ques 6 :-> How can you use views to simplify complex queries?

Query:  CREATE VIEW employee_details_view AS
        SELECT e.employee_id, e.employee_name, d.depart_name, e.salary
        FROM employees e
        JOIN departments d ON e.department_id = d.depart_id;

Output: 
CREATE VIEW

Query: SELECT * FROM employee_details_view;
Output: 
 employee_id | employee_name | depart_name |  salary  
-------------+---------------+-------------+----------
           2 | Varun         | Sales       | 40000.00
           4 | Priyanshu     | IT          | 30000.00
           1 | Abhinav       | HR          | 70000.00
           3 | Ayush         | Sales       | 90000.00
(4 rows)

Query: SELECT * FROM employee_details_view WHERE salary > 50000;
Output:
 employee_id | employee_name | depart_name |  salary  
-------------+---------------+-------------+----------
           1 | Abhinav       | HR          | 70000.00
           3 | Ayush         | Sales       | 90000.00
(2 rows)


Ques 7 :-> How do you drop a view in PostgreSQL?

Query: DROP VIEW employee_salary_view;
Output: 
DROP VIEW



Ques 8 :-> Can a view be based on another view?

Query:  CREATE VIEW department_salary_view AS
        SELECT depart_name, AVG(salary) AS average_salary
        FROM employee_details_view
        GROUP BY depart_name;

Output: 
CREATE VIEW

Query: SELECT * FROM department_salary_view;
Output: 
 depart_name |   average_salary   
-------------+--------------------
 Sales       | 65000.000000000000
 IT          | 30000.000000000000
 HR          | 70000.000000000000
(3 rows)



Ques 9 :-> What are some common use cases for views?

--Theory: Data Aggregation: Views can be used to pre-aggregate data (e.g., calculating sums, averages, or counts) for reporting purposes.
--        Data Abstraction: Views can abstract the complexity of database schema and logic, presenting users with a simpler interface to interact with.
--        Data Filtering: Views can be used to filter data for specific use cases (e.g., showing only active customers or employees).



Ques 10 :-> How can you use views to implement data virtualization?

--Theory: Data virtualization refers to the technique of providing a simplified view of data from multiple sources without physically moving or replicating the data.