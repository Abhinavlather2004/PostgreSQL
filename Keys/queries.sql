Q1: Design a database for an e-commerce store.
: Identify the primary key for the customers table.
: Define the foreign key relationship between orders and customers.

Query: CREATE TABLE customers (customer_id SERIAL PRIMARY KEY,name VARCHAR(20),email VARCHAR(100) UNIQUE);
CREATE TABLE
                                           Table "public.customers"
   Column    |          Type          | Collation | Nullable |                    Default                     
-------------+------------------------+-----------+----------+------------------------------------------------
 customer_id | integer                |           | not null | nextval('customers_customer_id_seq'::regclass)
 name        | character varying(20)  |           |          | 
 email       | character varying(100) |           |          | 
Indexes:
    "customers_pkey" PRIMARY KEY, btree (customer_id)
    "customers_email_key" UNIQUE CONSTRAINT, btree (email)

Query: CREATE TABLE orders (order_id SERIAL PRIMARY KEY,customer_id INT REFERENCES customers(customer_id),order_date DATE,total_amount NUMERIC(10, 2));
CREATE TABLE

                                     Table "public.orders"
    Column    |     Type      | Collation | Nullable |                 Default                  
--------------+---------------+-----------+----------+------------------------------------------
 order_id     | integer       |           | not null | nextval('orders_order_id_seq'::regclass)
 customer_id  | integer       |           |          | 
 order_date   | date          |           |          | 
 total_amount | numeric(10,2) |           |          | 
Indexes:
    "orders_pkey" PRIMARY KEY, btree (order_id)
Foreign-key constraints:
    "orders_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES customers(customer_id)


Q2: Create a database for a library system.
: Determine the primary key for the books table.
: Establish a foreign key relationship between borrowers and books.

Query: CREATE TABLE books (book_id SERIAL PRIMARY KEY,title VARCHAR(200),author VARCHAR(200));
CREATE TABLE
                                       Table "public.books"
 Column  |          Type          | Collation | Nullable |                Default                 
---------+------------------------+-----------+----------+----------------------------------------
 book_id | integer                |           | not null | nextval('books_book_id_seq'::regclass)
 title   | character varying(200) |           |          | 
 author  | character varying(200) |           |          | 
Indexes:
    "books_pkey" PRIMARY KEY, btree (book_id)

Query: CREATE TABLE borrowers (borrower_id SERIAL PRIMARY KEY,book_id INT REFERENCES books(book_id),borrow_date DATE,return_date DATE);
CREATE TABLE
                                   Table "public.borrowers"
   Column    |  Type   | Collation | Nullable |                    Default                     
-------------+---------+-----------+----------+------------------------------------------------
 borrower_id | integer |           | not null | nextval('borrowers_borrower_id_seq'::regclass)
 book_id     | integer |           |          | 
 borrow_date | date    |           |          | 
 return_date | date    |           |          | 
Indexes:
    "borrowers_pkey" PRIMARY KEY, btree (borrower_id)
Foreign-key constraints:
    "borrowers_book_id_fkey" FOREIGN KEY (book_id) REFERENCES books(book_id)


Q3: Design a database for a university.
: Identify the primary key for the students table.
: Define the foreign key relationship between courses and students.

Query: CREATE TABLE students (student_id SERIAL PRIMARY KEY,first_name VARCHAR(30),last_name VARCHAR(30));
CREATE TABLE
                                         Table "public.students"
   Column   |         Type          | Collation | Nullable |                   Default                    
------------+-----------------------+-----------+----------+----------------------------------------------
 student_id | integer               |           | not null | nextval('students_student_id_seq'::regclass)
 first_name | character varying(30) |           |          | 
 last_name  | character varying(30) |           |          | 
Indexes:
    "students_pkey" PRIMARY KEY, btree (student_id)

Query: CREATE TABLE courses (course_id SERIAL PRIMARY KEY,student_id INT REFERENCES students(student_id),course_name VARCHAR(40));
CREATE TABLE
                                         Table "public.courses"
   Column    |         Type          | Collation | Nullable |                  Default                   
-------------+-----------------------+-----------+----------+--------------------------------------------
 course_id   | integer               |           | not null | nextval('courses_course_id_seq'::regclass)
 student_id  | integer               |           |          | 
 course_name | character varying(40) |           |          | 
Indexes:
    "courses_pkey" PRIMARY KEY, btree (course_id)
Foreign-key constraints:
    "courses_student_id_fkey" FOREIGN KEY (student_id) REFERENCES students(student_id)

