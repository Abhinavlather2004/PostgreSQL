# Advanced PostgreSQL Transaction Queries

-> This project demonstrates the use of advanced PostgreSQL transaction control using real-world scenarios like banking, e-commerce, and logical rollbacks.


# Basic tables required for executing the queries:

Query:
CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    balance NUMERIC NOT NULL DEFAULT 0
);
Output:
CREATE TABLE


Query: 
INSERT INTO accounts (name, balance) VALUES 
('Alice', 1000),
('Bob', 1500),
('Charlie', 2000);
Output:
INSERT 0 3


Query:
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name TEXT,
    stock INT
);
Output:
CREATE TABLE


Query:
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(id),
    quantity INT
);
Output:
CREATE TABLE


Query:
INSERT INTO products (name, stock) VALUES ('Laptop', 5);
Output:
INSERT 0 1



Problem 1: Transfer Money Between Accounts (Successful)
-> Simulates a successful transaction transferring ₹500 from Alice to Bob using `BEGIN` and `COMMIT`.

Query:
BEGIN;

UPDATE accounts SET balance = balance - 500 WHERE name = 'Alice';
UPDATE accounts SET balance = balance + 500 WHERE name = 'Bob';

COMMIT;

Outputs:
BEGIN
UPDATE 1
UPDATE 1
COMMIT



Problem 2: Handle Failed Transfer Gracefully (Rollback)
-> Transfers to a non-existent user to show how `ROLLBACK` handles errors.

Query:
UPDATE accounts SET balance = balance - 1000 WHERE name = 'Alice';

-- This will fail because 'Ghost' doesn't exist
UPDATE accounts SET balance = balance + 1000 WHERE name = 'Ghost';

ROLLBACK;

Outputs:
BEGIN
UPDATE 1
UPDATE 0
ROLLBACK



Problem 3: Partial Rollback with Savepoints
-> Transfers from Charlie to Bob and Alice, but only undoes part of it when an error occurs.

Query:
BEGIN;

UPDATE accounts SET balance = balance - 100 WHERE name = 'Charlie';
SAVEPOINT after_deduction;

UPDATE accounts SET balance = balance + 50 WHERE name = 'Bob';
SAVEPOINT after_bob;

-- Intentional failure
UPDATE accounts SET balance = balance + 50 WHERE name = 'UnknownUser';

-- Rollback to previous successful point
ROLLBACK TO after_bob;

COMMIT;

Outputs:
BEGIN
UPDATE 1
SAVEPOINT
UPDATE 1
SAVEPOINT
UPDATE 0
ROLLBACK
COMMIT



Problem 4: Cancel Order on Stock Update Failure
-> Simulates an e-commerce order where a failed stock update rolls back the order creation too.

Query:
-- Insert a new order
INSERT INTO orders (product_id, quantity) VALUES (1, 2);

-- Update product stock
UPDATE products SET stock = stock - 2 WHERE id = 1;

COMMIT;

-- Now simulate a failure by using wrong product_id

BEGIN;

INSERT INTO orders (product_id, quantity) VALUES (999, 1); -- Invalid ID
UPDATE products SET stock = stock - 1 WHERE id = 999;

ROLLBACK;

Outputs:
BEGIN
INSERT 0 1
UPDATE 1
COMMIT
BEGIN
ROLLBACK



Problem 5: Logical Rollback Based on Balance
-> Validates the senders balance and conditionally commits or rolls back using PL/pgSQL.

Query:
DO $$
DECLARE
    current_balance NUMERIC;
BEGIN
    SELECT balance INTO current_balance FROM accounts WHERE name = 'Alice';

    IF current_balance >= 300 THEN
        BEGIN
            UPDATE accounts SET balance = balance - 300 WHERE name = 'Alice';
            UPDATE accounts SET balance = balance + 300 WHERE name = 'Charlie';
            COMMIT;
        END;
    ELSE
        RAISE NOTICE 'Insufficient balance. Rolling back...';
        ROLLBACK;
    END IF;
END $$;

Output:
DO



Problem 6: Nested Savepoints for Insert Handling
-> Uses multiple savepoints and rollbacks to demonstrate fine-grained transaction control.

Query:
BEGIN;

INSERT INTO accounts (name, balance) VALUES ('User1', 1000);
SAVEPOINT sp1;

INSERT INTO accounts (name, balance) VALUES ('User2', 2000);
SAVEPOINT sp2;

-- This will fail (name = NULL)
INSERT INTO accounts (name, balance) VALUES (NULL, 3000);

-- Rollback only to last successful insert
ROLLBACK TO sp2;

COMMIT;

Outputs:
BEGIN
INSERT 0 1
SAVEPOINT
INSERT 0 1
SAVEPOINT
ROLLBACK
COMMIT



Problem 7: Process a customer order: add the customer if new, then create their order.
->If the order creation fails (e.g., invalid amount), keep the customer but don’t create the order.

Query:

BEGIN;
INSERT INTO customers (name)
VALUES ('John Doe');
DO $$
DECLARE
    new_customer_id INT;
BEGIN
    new_customer_id := currval('customers_customer_id_seq');
    BEGIN
        IF 0 > 0 THEN
            INSERT INTO orders (customer_id, amount)
            VALUES (new_customer_id, -50.00);
        ELSE
            RAISE EXCEPTION 'Invalid order amount';
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'Order failed: %', SQLERRM;
    END;
END $$;
NOTICE:  Order failed: Invalid order amount
COMMIT;

Outputs:
CREATE TABLE
CREATE TABLE
 customer_id | name 
-------------+------
(0 rows)

 order_id | customer_id | amount 
----------+-------------+--------
(0 rows)

BEGIN
INSERT 0 1
DO
COMMIT
 customer_id |   name   
-------------+----------
           1 | John Doe
(1 row)

 order_id | customer_id | amount 
----------+-------------+--------
(0 rows)