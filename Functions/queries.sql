Query:
CREATE TABLE products (
  product_id SERIAL PRIMARY KEY,
  product_name VARCHAR(50) NOT NULL,
  price NUMERIC(10, 2) NOT NULL,
  category VARCHAR(50) NOT NULL
);
Output: 
CREATE TABLE


Query: 
INSERT INTO products (product_name, price, category) 
VALUES 
('Laptop', 1200.00, 'Electronics'),
('Smartphone', 800.00, 'Electronics'),
('Desk', 150.00, 'Furniture'),
('Chair', 80.00, 'Furniture'),
('Tablet', 300.00, 'Electronics');
Output: 
INSERT 0 5



Ques 1 :-> What is the difference between a function and a stored procedure?

--Theory: Stored Procedure:
-- Does not return a value directly (though it can return multiple output parameters).
-- Used for executing a sequence of SQL commands and logic, including side effects like modifying data (e.g., INSERT, UPDATE, DELETE).

--Function:
-- Returns a single value (or a set of values) directly via the RETURN statement.
-- Can be used in SQL queries (e.g., SELECT, WHERE, etc.).



Ques 2 :-> How do you create a function in PostgreSQL?

Query:  CREATE FUNCTION add_numbers(a INT, b INT)
        RETURNS INT
        LANGUAGE plpgsql
        AS $$
        BEGIN
            RETURN a + b;
        END;
        $$;

OUTPUT:
CREATE FUNCTION



Ques 3 :-> How do you return a value from a function?

Query:  CREATE FUNCTION get_products_by_category(cat_name VARCHAR)
        RETURNS TABLE(product_id INT, product_name VARCHAR, price NUMERIC)
        LANGUAGE plpgsql
        AS $$
        BEGIN
            RETURN QUERY
            SELECT products.product_id, products.product_name, products.price 
            FROM products 
            WHERE products.category = cat_name;
        END;
        $$;

Main Query: SELECT * FROM get_products_by_category('Electronics');
Output:
 product_id | product_name |  price  
------------+--------------+---------
          1 | Laptop       | 1200.00
          2 | Smartphone   |  800.00
          5 | Tablet       |  300.00
(3 rows)



Ques 5 :-> What are some common data types that can be returned by a function?

Query:  CREATE FUNCTION get_employee_ids() 
        RETURNS INT[] AS $$
        BEGIN
            RETURN ARRAY(SELECT employee_id FROM employees);
        END;
        $$ LANGUAGE plpgsql;

Output:
CREATE FUNCTION



Ques 6 :-> How can you use functions to improve code readability and maintainability?

--Theory: Encapsulation: Functions allow you to encapsulate repetitive logic, which makes your SQL code cleaner and easier to understand.
--        Reuse: Once defined, functions can be reused across multiple queries, reducing code duplication.
--        Modularity: Breaking complex logic into smaller, self-contained functions makes the overall system easier to maintain and debug.
--        Separation of Concerns: Functions allow for a clear separation between business logic and query execution.

Query: 
CREATE FUNCTION calculate_discount(original_price NUMERIC, discount_percentage NUMERIC)
 RETURNS NUMERIC AS $$
 BEGIN
     RETURN original_price - (original_price * discount_percentage / 100);
 END;
 $$ LANGUAGE plpgsql;

Output:
CREATE FUNCTION 

Main Query:  
SELECT 
    product_id,
    product_name,
    category,
    price AS original_price,
    calculate_discount(price, 10) AS discounted_price
FROM products;

Output: 
 product_id | product_name |  category   | original_price |   discounted_price    
------------+--------------+-------------+----------------+-----------------------
          1 | Laptop       | Electronics |        1200.00 | 1080.0000000000000000
          2 | Smartphone   | Electronics |         800.00 |  720.0000000000000000
          3 | Desk         | Furniture   |         150.00 |  135.0000000000000000
          4 | Chair        | Furniture   |          80.00 |   72.0000000000000000
          5 | Tablet       | Electronics |         300.00 |  270.0000000000000000
(5 rows)



Ques 7 :-> How can you use functions to perform complex calculations?

Query:  CREATE FUNCTION calculate_bmi(weight NUMERIC, height NUMERIC)
        RETURNS TABLE (bmi NUMERIC, category VARCHAR)
        LANGUAGE plpgsql
        AS $$
        BEGIN
          RETURN QUERY 
          SELECT 
              weight / (height * height) AS bmi,
              CASE 
                WHEN weight / (height * height) < 18.5 THEN 'Underweight'::VARCHAR
                WHEN weight / (height * height) BETWEEN 18.5 AND 24.9 THEN 'Normal weight'::VARCHAR
                WHEN weight / (height * height) BETWEEN 25 AND 29.9 THEN'Overweight'::VARCHAR
              END AS category;
        END;
        $$;

Output: 
CREATE FUNCTION

Main Query: SELECT * FROM calculate_bmi(70, 1.75);
Output:

         bmi         |   category    
---------------------+---------------
 22.8571428571428571 | Normal weight
(1 row)



Ques 8 :-> What are some performance considerations when using functions?

--Theory: Performance Overhead: Functions add a layer of abstraction, and in some cases, they can introduce slight overhead, especially for complex operations or when they are called repeatedly in large datasets.
--        Avoiding Expensive Queries: Functions that involve complex or nested queries should be optimized. Avoid using functions for operations that can be done directly in SQL queries, as functions might result in additional overhead.
--        Side Effects: Functions with side effects (e.g., VOLATILE functions that modify data) can affect performance, especially if used in SELECT queries with large data volumes.



Ques 9 :-> How can you use functions to implement custom business logic?

Query:  CREATE OR REPLACE FUNCTION calculate_tax(price NUMERIC, tax_rate NUMERIC)
        RETURNS NUMERIC
        LANGUAGE plpgsql
        AS $$
        BEGIN
            RETURN price * (1 + tax_rate / 100);
        END;
        $$;

Main Query: 
SELECT 
    product_id, 
    product_name, 
    calculate_tax(price, 10) AS total_price 
FROM 
    products;

Output: 
 product_id | product_name |         total_price         
------------+--------------+-----------------------------
          1 | Laptop       | 1320.0000000000000000000000
          2 | Smartphone   |  880.0000000000000000000000
          3 | Desk         |  165.0000000000000000000000
          4 | Chair        |   88.0000000000000000000000
          5 | Tablet       |  330.0000000000000000000000
(5 rows)    



Ques 10 :-> What are some examples of built-in functions in PostgreSQL?

--Theory: String Functions: CONCAT(), SUBSTRING(), LENGTH(), UPPER(), LOWER(), TRIM()
--        Aggregate Functions: COUNT(), SUM(), AVG(), MIN(), MAX()
--        Date/Time Functions: CURRENT_DATE, CURRENT_TIME


