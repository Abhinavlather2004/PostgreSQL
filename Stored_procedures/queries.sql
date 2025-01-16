Ques 1 :-> How do you create a stored procedure in PostgreSQL?

Query: CREATE PROCEDURE get_employee_details(emp_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
SELECT * FROM employees WHERE employee_id = 1;
END;
$$;

Ques 2 :-> How do you pass parameters to a stored procedure?

--Theory: Parameters are defined in the parentheses of the procedure declaration.

Query: CREATE PROCEDURE get_employee_by_department(department_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
SELECT * FROM employees WHERE department_id = department_id;
END;
$$;

Output:
CREATE PROCEDURE

Main Query: CALL get_employee_by_department(3);



QUES 3 :-> How do you return a result set from a stored procedure?

QUERY: CALL get_employee_by_department(3);



Ques 4 :->  What are the benefits of using stored procedures?

--Theory: Performance: Reduce network traffic by executing logic on the server.
--        Security: Encapsulate logic and hide data complexity.
--        Reusability: Centralize business logic for consistent use.
--        Maintenance: Make application changes without touching client-side code.
--        Transaction Handling: Manage complex transactions within the database.



Ques 5 :-> What are the drawbacks of using stored procedures?

--Theory: Database Dependence: Tightly couples logic with the database, making migrations harder.
--        Version Control: Managing code changes is more complex than in external application code.
--        Debugging: Debugging stored procedures can be difficult compared to application code.
--        Limited Scalability: Complex procedures may impact database performance.



Ques 6 :->  How do you debug a stored procedure?

--Theory: Raise Notices: Use RAISE NOTICE for logging and debugging.
--        Use Logs: Check the PostgreSQL logs for errors.
--        pgAdmin Debugger: Use the built-in debugger in pgAdmin to step through procedures.
--        Unit Testing: Write test cases to validate logic.

Query: CREATE PROCEDURE debug_example()
LANGUAGE plpgsql
AS $$
BEGIN
RAISE NOTICE 'The procedure is starting';
-- Write logic here
RAISE NOTICE 'The procedure is ending';
END;
$$;

OUTPUT: 
CREATE PROCEDURE



Ques 7 :-> How do you grant permissions to a stored procedure?

Query: CREATE ROLE user_role;
Main Query: GRANT EXECUTE ON get_employee_details TO user_role;



Ques 8 :-> How can you use stored procedures to improve application performance?
--Theory: Reduce Network Latency: Minimize data transfer between the application and the database.
--        Precompiled Execution Plans: Stored procedures use cached plans for faster execution.
--        Encapsulation: Simplify application logic by offloading data-intensive operations to the database.
--        Batch Processing: Execute multiple statements in a single call.



Ques 9 :-> What are some common use cases for stored procedures?

--Theory: Data Transformation: Complex data processing tasks.
--        Batch Jobs: Scheduled tasks like data backups and aggregation.
--        Business Logic: Encapsulation of domain-specific rules.
--        Auditing and Logging: Automatically log user actions or changes.
--        Access Control: Manage data access through controlled logic.



Ques 10 :-> How do you handle errors within a stored procedure?

--Theory: PostgreSQL provides the EXCEPTION block for error handling.

CREATE PROCEDURE handle_error_example()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Your logic here
    RAISE NOTICE 'Starting procedure';
    
    -- Simulate error
    RAISE EXCEPTION 'An error occurred';
    
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'An exception occurred: %', SQLERRM;
END;
$$;

OUTPUT:
CREATE PROCEDURE