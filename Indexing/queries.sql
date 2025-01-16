

Problem: A table storing customer orders is experiencing slow query performance, particularly when filtering by customer name or order date.
Solution: Create indexes on the customer_name and order_date columns to speed up data retrieval for queries involving these columns.

Query: CREATE INDEX idx_customer_name ON customer_orders (customer_name);
Output: 
CREATE INDEX

                                          Table "public.customer_orders"
    Column     |          Type          | Collation | Nullable |                      Default                      
---------------+------------------------+-----------+----------+---------------------------------------------------
 order_id      | integer                |           | not null | nextval('customer_orders_order_id_seq'::regclass)
 customer_name | character varying(100) |           | not null | 
 order_date    | date                   |           | not null | 
 order_amount  | numeric(10,2)          |           |          | 
Indexes:
    "customer_orders_pkey" PRIMARY KEY, btree (order_id)
    "idx_customer_name" btree (customer_name)


Main Query: SELECT * FROM customer_orders
            WHERE customer_name = 'Abhinav'
            AND order_date = '2025-01-01';

Output: 
 order_id | customer_name | order_date | order_amount 
----------+---------------+------------+--------------
        1 | Abhinav       | 2025-01-01 |       150.00
(1 row)



Problem: A table storing product information with frequent searches on product descriptions is causing slow response times.
Solution: Create a GIN index on the product_description column to efficiently handle full-text search queries.

Query: CREATE INDEX idx_product_description ON products USING gin(to_tsvector('english', product_description));
Output:
CREATE INDEX

                                              Table "public.products"
       Column        |         Type          | Collation | Nullable |                   Default                    
---------------------+-----------------------+-----------+----------+----------------------------------------------
 product_id          | integer               |           | not null | nextval('products_product_id_seq'::regclass)
 product_name        | character varying(50) |           | not null | 
 price               | numeric(10,2)         |           | not null | 
 category            | character varying(50) |           | not null | 
 product_description | text                  |           |          | 
Indexes:
    "products_pkey" PRIMARY KEY, btree (product_id)
    "idx_product_description" gin (to_tsvector('english'::regconfig, product_description))


