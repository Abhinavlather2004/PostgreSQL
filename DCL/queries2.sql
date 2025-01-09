Ques 1:-> Grant the SELECT privilege on the "employees" table to a specific user.
Query: CREATE ROLE user1 WITH LOGIN PASSWORD 'firstUser';
Output:
CREATE ROLE

Query: CREATE ROLE user2 WITH LOGIN PASSWORD 'password2';
Output:
CREATE ROLE

Query: CREATE ROLE insert_group;
Output: 
CREATE ROLE

Main Query: GRANT SELECT ON employees TO user1;
Output:
GRANT



Ques 2:-> Grant the INSERT privilege on the "employees" table to a group of users.
Query: GRANT insert_group TO user2;
Output:
GRANT ROLE

Main Query: GRANT INSERT ON employees TO insert_group;
Output:
GRANT



Ques 3:-> Revoke the UPDATE privilege on the "employees" table from a specific user.

Main Query: REVOKE UPDATE ON employees FROM user1;
Output:
REVOKE



Ques 4:-> Grant all privileges on the "products" table to a specific role.
Query: CREATE ROLE CEO WITH LOGIN PASSWORD 'HeadOfCompany';
Output:
CREATE ROLE

Main Query: GRANT ALL PRIVILEGES ON products TO CEO;
Output:
GRANT



Ques 5:-> Revoke the DELETE privilege on the "products" table from all users.

Main Query: REVOKE DELETE ON products FROM PUBLIC;
Output:
REVOKE

Ques 6:-> Grant the SELECT and INSERT privileges on the "departments" table to a specific user.
Query: CREATE ROLE Mentor WITH LOGIN PASSWORD 'Mentor123';
Output:
CREATE ROLE

Main Query: GRANT SELECT, INSERT on departments TO Mentor;
Output:
GRANT



Ques 7:-> Revoke all privileges on the "departments" table from a specific role
Query: CREATE ROLE Student WITH LOGIN PASSWORD 'Student123';
Output:
CREATE ROLE

Main Query: REVOKE ALL PRIVILEGES ON departments FROM Student;
Output:
REVOKE



Ques 8:-> Grant the USAGE privilege on a specific schema to a user.
Query: CREATE SCHEMA AllTables;
Output:
CREATE SCHEMA

Query: ALTER TABLE products SET SCHEMA AllTables;
Output:
ALTER TABLE

Query: ALTER TABLE departments SET SCHEMA AllTables;
Output:
ALTER TABLE

Query: ALTER TABLE employees SET SCHEMA AllTables;
Output:
ALTER TABLE

Main Query: GRANT USAGE ON SCHEMA AllTables TO CEO;
Output:
GRANT



Ques 9:-> Revoke the USAGE privilege on a specific schema from a group of users.

Main Query: REVOKE USAGE ON SCHEMA AllTables FROM user1, user2, Student;
Output:
REVOKE



Ques 10:-> Grant the CONNECT privilege to a new user.
Query: CREATE ROLE new_user WITH LOGIN PASSWORD 'newUser123';
Output:
CREATE ROLE

Main Query: GRANT CONNECT ON DATABASE company TO new_user;
Output:
GRANT
