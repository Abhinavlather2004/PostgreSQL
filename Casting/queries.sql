Problem: A table stores birthdates as strings in the format 'YYYY-MM-DD'. You need to calculate the age of customers.
Solution: Cast the birthdate column to a date type and then use date functions to calculate the age.

Query: SELECT 
          customer_id, 
          customer_name, 
          birthdate,
          AGE(CAST(birthdate AS DATE)) AS age
      FROM customers;

Output:
 customer_id | customer_name | birthdate  |           age            
-------------+---------------+------------+--------------------------
           1 | Abhinav       | 2004-01-19 | 20 years 11 mons 28 days
           2 | Varun         | 2003-06-09 | 21 years 7 mons 7 days
           3 | Ayush         | 2003-03-06 | 21 years 10 mons 10 days
           4 | Priyanshu     | 2003-07-07 | 21 years 6 mons 9 days
(4 rows)

Query: SELECT 
          customer_id, 
          customer_name, 
          birthdate,
          EXTRACT(YEAR FROM AGE(CAST(birthdate AS DATE))) AS age_years
        FROM customers;
        
Output:

 customer_id | customer_name | birthdate  | age_years 
-------------+---------------+------------+-----------
           1 | Abhinav       | 2004-01-19 |        20
           2 | Varun         | 2003-06-09 |        21
           3 | Ayush         | 2003-03-06 |        21
           4 | Priyanshu     | 2003-07-07 |        21
(4 rows)





Problem: A column stores a boolean value as 'Y' or 'N'. You need to perform logical operations on this column.
Solution: Cast the 'Y' and 'N' values to boolean (TRUE/FALSE) using CASE expressions or custom functions.

Query:  SELECT 
          user_id, 
          username, 
          is_active,
          CASE 
              WHEN is_active = 'Y' THEN 'TRUE'
              ELSE 'FALSE'
          END AS is_active_bool
        FROM users;

Output:
 user_id | username | is_active | is_active_bool 
---------+----------+-----------+----------------
       1 | Abhinav  | Y         | TRUE
       2 | Varun    | N         | FALSE
       3 | Vishal   | Y         | TRUE
(3 rows)








