Ques 1:->  Create a transaction to insert two new employees and update the salary of an existing employee.
Query: BEGIN;
Output:
BEGIN

Query: INSERT INTO employee(employee_id, first_name, last_name, salary) VALUES (101, 'Vishal', 'Kanojia', 1000), (102, 'Varun', 'Thakur', 2000);
Output:
INSERT 0 2
 employee_id | first_name | last_name | salary 
-------------+------------+-----------+--------
         101 | Vishal     | Kanojia   |   1000
         102 | Varun      | Thakur    |   2000
(2 rows)

Query: UPDATE employee SET salary = 20000 WHERE employee_id = 101;
Output:
UPDATE 1
 employee_id | first_name | last_name | salary 
-------------+------------+-----------+--------
         102 | Varun      | Thakur    |   2000
         101 | Vishal     | Kanojia   |  20000
(2 rows)



Ques 2:-> Commit the transaction to save the changes.
Query: COMMIT;
Output:
COMMIT



Ques 3:-> Create a transaction to delete a product and insert a new product.
Query: BEGIN;
Output:
BEGIN

Query: DELETE FROM product WHERE product_id = 101;
Output:
DELETE 1

Query: INSERT INTO product(product_id, product_name, price) VALUES (103, 'Jeans', 3000);
Output:
INSERT 0 1
 product_id | product_name | price 
------------+--------------+-------
        102 | Shirt        |  1200
        103 | Jeans        |  3000
(2 rows)

Query: COMMIT;
Output:
COMMIT



Ques 4:-> Rollback the transaction to undo the changes.
Query: ROLLBACK;
Output:
ROLLBACK



Ques 5:-> Create a transaction to update the price of a product and insert a new
Query: BEGIN;
Output:
BEGIN

Query: UPDATE product SET price = 4000 WHERE product_id = 103;
Output:
UPDATE 1

Query: INSERT INTO product(product_id, product_name, price) VALUES (104, 'Jacket', 5000);
Output:
INSERT 0 1

Query: COMMIT;
Output:
COMMIT
