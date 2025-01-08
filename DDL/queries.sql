Ques 1:-> Create a database named "company" to store employee information.
Query :-> create database company;

OUTPUT:
CREATE DATABASE
                                                List of databases
   Name    |  Owner   | Encoding | Locale Provider | Collate | Ctype | Locale | ICU Rules |   Access privileges   
-----------+----------+----------+-----------------+---------+-------+--------+-----------+-----------------------
 company   | postgres | UTF8     | libc            | C       | C     |        |           | 
 postgres  | postgres | UTF8     | libc            | C       | C     |        |           | 
 template0 | postgres | UTF8     | libc            | C       | C     |        |           | =c/postgres          +
           |          |          |                 |         |       |        |           | postgres=CTc/postgres
 template1 | postgres | UTF8     | libc            | C       | C     |        |           | =c/postgres          +
           |          |          |                 |         |       |        |           | postgres=CTc/postgres
(4 rows)



Ques 2:-> Create a table named "employees" with columns for employee_id (integer), first_name (varchar), last_name (varchar), and salary (decimal).
Query :-> CREATE TABLE employees(employee_id integer, first_name varchar(20), last_name varchar(20), salary decimal);

OUTPUT:
CREATE TABLE
           List of relations
 Schema |   Name    | Type  |  Owner   
--------+-----------+-------+----------
 public | employees | table | postgres
(1 row)



Ques 3:-> Add a new column named "department" to the "employees" table.
Query :-> ALTER TABLE employees ADD department varchar(20)

ALTER TABLE
                       Table "public.employees"
   Column    |         Type          | Collation | Nullable | Default 
-------------+-----------------------+-----------+----------+---------
 employee_id | integer               |           |          | 
 first_name  | character varying(20) |           |          | 
 last_name   | character varying(20) |           |          | 
 salary      | numeric               |           |          | 
 department  | character varying(20) |           |          | 



Ques 4:-> Modify the "salary" column in the "employees" table to allow for NULL values.
Query :-> ALTER TABLE employees ALTER COLUMN salary SET NOT NULL;

OUTPUT:
ALTER TABLE
                       Table "public.employees"
   Column    |         Type          | Collation | Nullable | Default 
-------------+-----------------------+-----------+----------+---------
 employee_id | integer               |           |          | 
 first_name  | character varying(20) |           |          | 
 last_name   | character varying(20) |           |          | 
 salary      | numeric               |           | not null | 
 department  | character varying(20) |           |          | 



Ques 5:-> Rename the "employees" table to "staff"
Query :-> ALTER TABLE employees RENAME TO staff;

OUTPUT:
ALTER TABLE
         List of relations
 Schema | Name  | Type  |  Owner   
--------+-------+-------+----------
 public | staff | table | postgres
(1 row)



Ques 6:-> Drop the "department" column from the "staff" table.
Query :-> ALTER TABLE staff DROP COLUMN department;

OUTPUT:
ALTER TABLE
                         Table "public.staff"
   Column    |         Type          | Collation | Nullable | Default 
-------------+-----------------------+-----------+----------+---------
 employee_id | integer               |           |          | 
 first_name  | character varying(20) |           |          | 
 last_name   | character varying(20) |           |          | 
 salary      | numeric               |           | not null | 



Ques 7:-> Create a table named "departments" with columns for department_id (integer) and department_name (varchar).
Query :-> CREATE TABLE departments(department_id integer, department_name varchar(20));

OUTPUT:
CREATE TABLE
            List of relations
 Schema |    Name     | Type  |  Owner   
--------+-------------+-------+----------
 public | departments | table | postgres
 public | staff       | table | postgres
(2 rows)



Ques 8:-> Create a database named "inventory" to store product information.
Query :-> CREATE DATABASE inventory;

OUTPUT:
CREATE DATABASE
                                                List of databases
   Name    |  Owner   | Encoding | Locale Provider | Collate | Ctype | Locale | ICU Rules |   Access privileges   
-----------+----------+----------+-----------------+---------+-------+--------+-----------+-----------------------
 company   | postgres | UTF8     | libc            | C       | C     |        |           | 
 inventory | postgres | UTF8     | libc            | C       | C     |        |           | 
 postgres  | postgres | UTF8     | libc            | C       | C     |        |           | 
 template0 | postgres | UTF8     | libc            | C       | C     |        |           | =c/postgres          +
           |          |          |                 |         |       |        |           | postgres=CTc/postgres
 template1 | postgres | UTF8     | libc            | C       | C     |        |           | =c/postgres          +
           |          |          |                 |         |       |        |           | postgres=CTc/postgres
(5 rows)



Ques 9:-> Create a table named "products" with columns for product_id (integer), product_name (varchar), and price (decimal).
Query :-> CREATE TABLE products(product_id integer, product_name varchar(30), price decimal);

OUTPUT:
CREATE TABLE
                        Table "public.products"
    Column    |         Type          | Collation | Nullable | Default 
--------------+-----------------------+-----------+----------+---------
 product_id   | integer               |           |          | 
 product_name | character varying(30) |           |          | 
 price        | numeric               |           |          | 



Ques 10:-> Drop the "inventory" database
Query :-> DROP DATABASE inventory;

OUTPUT:
DROP DATABASE
                                                List of databases
   Name    |  Owner   | Encoding | Locale Provider | Collate | Ctype | Locale | ICU Rules |   Access privileges   
-----------+----------+----------+-----------------+---------+-------+--------+-----------+-----------------------
 company   | postgres | UTF8     | libc            | C       | C     |        |           | 
 postgres  | postgres | UTF8     | libc            | C       | C     |        |           | 
 template0 | postgres | UTF8     | libc            | C       | C     |        |           | =c/postgres          +
           |          |          |                 |         |       |        |           | postgres=CTc/postgres
 template1 | postgres | UTF8     | libc            | C       | C     |        |           | =c/postgres          +
           |          |          |                 |         |       |        |           | postgres=CTc/postgres
(4 rows)

