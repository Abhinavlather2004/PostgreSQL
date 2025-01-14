
Ques 1 :->DDL (Data Definition Language):
   * Create the following tables:
     * Books with columns: book_id, title, author, publication_year, genre.
     * Members with columns: member_id, name, address, contact_number.
     * Borrowings with columns: borrowing_id, book_id, member_id, borrow_date, due_date, returned_date.



Query: CREATE TABLE Books(book_id SERIAL PRIMARY KEY, title VARCHAR(50 
library_system(# ), author VARCHAR(40), publication_year INTEGER, genre VARCHAR(100));
Query: CREATE TABLE Members(member_id SERIAL PRIMARY KEY, name VARCHAR(40), address VARCHAR(200), contact_number VARCHAR(12));
Query: CREATE TABLE Borrowings(borrowing_id SERIAL PRIMARY KEY, book_id INTEGER, member_id INTEGER, borrow_date DATE, due_date DATE, return_date DATE, FOREIGN KEY (book_id) REFERENCES Books(book_id), FOREIGN KEY (member_id) REFERENCES Members(member_id));
CREATE TABLE
CREATE TABLE
CREATE TABLE
Query: \d Books
                                           Table "public.books"
      Column      |          Type          | Collation | Nullable |                Default                 
------------------+------------------------+-----------+----------+----------------------------------------
 book_id          | integer                |           | not null | nextval('books_book_id_seq'::regclass)
 title            | character varying(50)  |           |          | 
 author           | character varying(40)  |           |          | 
 publication_year | integer                |           |          | 
 genre            | character varying(100) |           |          | 
Indexes:
    "books_pkey" PRIMARY KEY, btree (book_id)
Referenced by:
    TABLE "borrowings" CONSTRAINT "borrowings_book_id_fkey" FOREIGN KEY (book_id) REFERENCES books(book_id)

Query: \dt
           List of relations
 Schema |    Name    | Type  |  Owner   
--------+------------+-------+----------
 public | books      | table | postgres
 public | borrowings | table | postgres
 public | members    | table | postgres
(3 rows)


Ques 2: * DML (Data Manipulation Language):
   * Insert sample data into each table (at least 5 records per table).

Query: INSERT INTO Books(title, author, publication_year, genre) VALUES ('Book1', 'author1', 2020, 'genre1'), ('Book2', 'author2', 2021, 'genre2'), ('Book3', 'author3', 2022, 'genre3'), ('Book4', 'author4', 2023, 'genre4'), ('Book5', 'author5', 2024, 'genre5');
Query: INSERT INTO Members(name, address, contact_number) VALUES ('Ayush', 'Saharanpur', '86375436'), ('Abhinav', 'Kurukshetra', '7082956'), ('Vishal', 'Banaras', '3456776'), ('Varun', 'Himachal', '8765123'), ('Priyanshu', 'Banur', '456798');
Query: INSERT INTO Borrowings(book_id, member_id, borrow_date, return_date, due_date) VALUES (1, 1, '2025-01-01', '2025-01-21', '2025-01-10'), (2, 2,
'2025-01-02', '2025-01-22', '2025-01-12'), (3, 3, '2025-01-03', '2025-01-23', '2025-01-13'), (4, 4, '2025-01-04', '2025-01-24', '2025-01-14'), (5, 5, '2025-01-05', '2025-01-25', '2025-01-15');

INSERT 0 5
INSERT 0 5
INSERT 0 5

Query: SELECT * FROM Books;
 book_id | title | author  | publication_year | genre  
---------+-------+---------+------------------+--------
       1 | Book1 | author1 |             2020 | genre1
       2 | Book2 | author2 |             2021 | genre2
       3 | Book3 | author3 |             2022 | genre3
       4 | Book4 | author4 |             2023 | genre4
       5 | Book5 | author5 |             2024 | genre5
(5 rows)

Query: SELECT * FROM Members;
 member_id |   name    |   address   | contact_number 
-----------+-----------+-------------+----------------
         1 | Ayush     | Saharanpur  | 86375436
         2 | Abhinav   | Kurukshetra | 7082956
         3 | Vishal    | Banaras     | 3456776
         4 | Varun     | Himachal    | 8765123
         5 | Priyanshu | Banur       | 456798
(5 rows)

Query: SELECT * FROM Borrowings;
 borrowing_id | book_id | member_id | borrow_date |  due_date  | return_date 
--------------+---------+-----------+-------------+------------+-------------
            1 |       1 |         1 | 2025-01-01  | 2025-01-10 | 2025-01-21
            2 |       2 |         2 | 2025-01-02  | 2025-01-12 | 2025-01-22
            3 |       3 |         3 | 2025-01-03  | 2025-01-13 | 2025-01-23
            4 |       4 |         4 | 2025-01-04  | 2025-01-14 | 2025-01-24
            5 |       5 |         5 | 2025-01-05  | 2025-01-15 | 2025-01-25
(5 rows)


Ques 3 :-> Retrieve all books by a specific author.
Query: SELECT * FROM Books WHERE author = 'author3';

 book_id | title | author  | publication_year | genre  
---------+-------+---------+------------------+--------
       3 | Book3 | author3 |             2022 | genre3
(1 row)


Ques4 :->  Find members who have borrowed a particular book.
Query: SELECT member_id FROM Borrowings WHERE book_id = 2;
 member_id 
-----------
         2
(1 row)


Ques5 :->  Display books that are currently overdue. 
Query: SELECT title FROM books WHERE book_id IN (SELECT book_id FROM Borrowings WHERE due_date<return_date);

 title 
-------
 Book1
 Book2
 Book3
 Book4
 Book5
(5 rows)


Ques 6 :-> Calculate the total number of books borrowed by each member. 
Query: SELECT member_id, (SELECT COUNT(*) FROM Borrowings WHERE Borrowings.member_id = Members.member_id) AS total_borrowed FROM Members;

 member_id | total_borrowed 
-----------+----------------
         1 |              1
         2 |              1
         3 |              1
         4 |              1
         5 |              1
(5 rows)


Ques 7 :-> Demonstrate the use of COMMIT and ROLLBACK in a scenario where a member borrows a book, but the transaction needs to be canceled due to an error.
Queries: START TRANSACTION;

INSERT INTO Borrowings(book_id, member_id, borrow_date, return_date, due_date) VALUES (1, 2, '2025-03-10', '2025-03-25', '2025-03-15');

COMMIT;

ROLLBACK;

Output: 
START TRANSACTION
INSERT 0 1
COMMIT
ROLLBACK
