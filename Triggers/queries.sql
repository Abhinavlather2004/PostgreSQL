
Problem: Ensure that the updated_at timestamp column is automatically updated whenever a row in the products table is modified.
Solution: Create a BEFORE UPDATE trigger on the products table that updates the updated_at column with the current timestamp.

Query:  CREATE FUNCTION update_timestamp()
        RETURNS TRIGGER AS $$
        BEGIN
            
            NEW.updated_at := CURRENT_TIMESTAMP;
            RETURN NEW;
        END;
        $$ LANGUAGE plpgsql;
Output:
CREATE FUNCTION

Query:  CREATE TRIGGER before_update_products
        BEFORE UPDATE ON products
        FOR EACH ROW
        EXECUTE FUNCTION update_timestamp();

Output:
CREATE TRIGGER

Query: SELECT * FROM products;
Output: 
 product_id | product_name |  price  |  category   |                     product_description                      |         updated_at         
------------+--------------+---------+-------------+--------------------------------------------------------------+----------------------------
          1 | Laptop       | 1200.00 | Electronics | A high-performance device for work and personal use          | 2025-01-16 14:11:20.725383
          2 | Smartphone   |  800.00 | Electronics | A portable communication and multimedia device               | 2025-01-16 14:11:20.725383
          3 | Desk         |  150.00 | Furniture   | A sturdy piece of furniture ideal for workspace organization | 2025-01-16 14:11:20.725383
          4 | Chair        |   80.00 | Furniture   |  A comfortable seating solution for home or office           | 2025-01-16 14:11:20.725383
          5 | Tablet       |  300.00 | Electronics | A compact device for browsing and entertainment              | 2025-01-16 14:11:20.725383
(5 rows)

Query:  UPDATE products
        SET price = 1000.00
        WHERE product_id = 1;
Output:
UPDATE 1

Query: SELECT * FROM products WHERE product_id = 1;
Output:
 product_id | product_name |  price  |  category   |                 product_description                 |         updated_at         
------------+--------------+---------+-------------+-----------------------------------------------------+----------------------------
          1 | Laptop       | 1000.00 | Electronics | A high-performance device for work and personal use | 2025-01-16 14:18:34.942984
(1 row)



Problem: Prevent users from deleting orders with associated shipments.
Solution: Create a BEFORE DELETE trigger on the orders table that checks for the existence of related shipments and raises an error if any are found.

Query:  CREATE OR REPLACE FUNCTION prevent_delete_with_shipments()
        RETURNS TRIGGER AS $$
        BEGIN
            
          IF EXISTS (SELECT 1 FROM shipments WHERE order_id = OLD.order_id) THEN
              RAISE EXCEPTION 'Cannot delete order with associated shipments';
          END IF;
          
          RETURN OLD;
        END;
        $$ LANGUAGE plpgsql;
Output:
CREATE FUNCTION

Query:  CREATE TRIGGER before_delete_order
        BEFORE DELETE ON orderss
        FOR EACH ROW
        EXECUTE FUNCTION prevent_delete_with_shipments();
Output:
CREATE TRIGGER

Query: DELETE FROM orderss WHERE order_id = 1;
Output: Cannot delete order with associated shipments

Main Query: DELETE FROM orderss WHERE order_id = 2;
Output:
DELETE 1


