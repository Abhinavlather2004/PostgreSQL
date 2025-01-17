Problem: A table stores customer addresses. You need to create a trigger that updates the state_name column based on the state_code whenever the state_code is updated. The state_code to state_name mapping is stored in a separate lookup table.
Solution: Combine a trigger with a JOIN operation to retrieve the corresponding state_name from the lookup table and update the state_name column in the customer addresses table.

Query:  CREATE TABLE state_lookup (
          state_code VARCHAR(10) PRIMARY KEY,
          state_name VARCHAR(100) NOT NULL
        );

Output:
CREATE TABLE

                     Table "public.state_lookup"
   Column   |          Type          | Collation | Nullable | Default 
------------+------------------------+-----------+----------+---------
 state_code | character varying(10)  |           | not null | 
 state_name | character varying(100) |           | not null | 
Indexes:
    "state_lookup_pkey" PRIMARY KEY, btree (state_code)

Query: INSERT INTO state_lookup (state_code, state_name) VALUES
        ('HR', 'Haryana'),
        ('CH', 'Chandigarh'),
        ('PB', 'Punjab');

Output:
INSERT 0 3
 state_code | state_name 
------------+------------
 HR         | Haryana
 CH         | Chandigarh
 PB         | Punjab
(3 rows)


Query:  CREATE TABLE customer_addresses (
           id SERIAL PRIMARY KEY,
           customer_name VARCHAR(100) NOT NULL,
           state_code VARCHAR(10),
           state_name VARCHAR(100)
        );

Output:
CREATE TABLE

                                       Table "public.customer_addresses"
    Column     |          Type          | Collation | Nullable |                    Default                     
---------------+------------------------+-----------+----------+------------------------------------------------
 id            | integer                |           | not null | nextval('customer_addresses_id_seq'::regclass)
 customer_name | character varying(100) |           | not null | 
 state_code    | character varying(10)  |           |          | 
 state_name    | character varying(100) |           |          | 
Indexes:
    "customer_addresses_pkey" PRIMARY KEY, btree (id)

Query:  CREATE OR REPLACE FUNCTION update_state_name()
        RETURNS TRIGGER AS $$
        BEGIN

          NEW.state_name = (SELECT state_name
                            FROM state_lookup
                            WHERE state_code = NEW.state_code);
          RETURN NEW;
        END;
        $$ LANGUAGE plpgsql;

Output:
CREATE FUNCTION

                             List of functions
 Schema |       Name        | Result data type | Argument data types | Type 
--------+-------------------+------------------+---------------------+------
 public | update_state_name | trigger          |                     | func
(1 row)

Query:  CREATE TRIGGER update_state_name_trigger
        BEFORE UPDATE OF state_code ON customer_addresses
        FOR EACH ROW
        EXECUTE FUNCTION update_state_name();

Output:
CREATE TRIGGER

Query:  INSERT INTO customer_addresses (customer_name, state_code, state_name) VALUES
        ('Abhinav', 'HR', 'Haryana'),
        ('Priyanshu', 'PB', 'Punjab');

Output:
INSERT 0 2

 id | customer_name | state_code | state_name 
----+---------------+------------+------------
  1 | Abhinav       | HR         | Haryana
  2 | Priyanshu     | PB         | Punjab
(2 rows)

Query:  UPDATE customer_addresses
        SET state_code = 'CH'
        WHERE customer_name = 'Priyanshu';
Output:
UPDATE 1

 id | customer_name | state_code | state_name 
----+---------------+------------+------------
  1 | Abhinav       | HR         | Haryana
  2 | Priyanshu     | CH         | Chandigarh
(2 rows)

