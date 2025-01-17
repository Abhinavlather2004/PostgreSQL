Problem: Calculate the total sales amount for each order by summing the product price and quantity for each order item.
Solution: Use the SUM() function with appropriate joins and calculations to determine the total sales amount.

Query:  SELECT 
          order_id, 
          SUM(product_price * quantity) AS total_sales
        FROM order_items
        GROUP BY order_id;

Output:
 order_id | total_sales 
----------+-------------
        2 |      100.00
        1 |      130.00
(2 rows)



Problem: Find all customers who placed an order in the last 30 days.
Solution: Use the current_date function and the - operator to calculate the date 30 days ago and then filter the orders based on the order date.

Query:  SELECT DISTINCT customer_id, order_date
        FROM orders
        WHERE order_date >= CURRENT_DATE - INTERVAL '30 days';

Output:
 customer_id | order_date 
-------------+------------
           2 | 2025-01-12
           3 | 2025-01-13
           1 | 2025-01-10
           4 | 2025-01-15
           4 | 2025-01-14
           1 | 2025-01-11
           1 | 2025-01-17
(7 rows)

