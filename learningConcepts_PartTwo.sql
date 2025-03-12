-- MORE BASIC QUERIES _______________________________________________

-- Find all employees (or branches, or clients, or etc.). 
SELECT * FROM employee;
SELECT * FROM branch;
SELECT * FROM branch_supplier;
SELECT * FROM client;
SELECT * FROM works_with;


-- Find all employees ordered by salary. 
SELECT * FROM employee
ORDER BY salary DESC;


-- Find all employees ordered by sex then name. 
SELECT * FROM employee
ORDER BY sex, first_name, last_name;


-- Find the first 5 employees in the table. 
SELECT * FROM employee
LIMIT 5;


-- Find the first and last names of all employees. 
SELECT first_name, last_name 
FROM employee;


-- Find the forename and surnames names of all employees. 
SELECT first_name AS forename, last_name AS surname
FROM employee;


-- Find out all the different genders. DISTINCT - find out what are the different values that are stored in a particular column. 
SELECT DISTINCT sex 
FROM employee;
--______________________
SELECT DISTINCT branch_id 
FROM employee;



-- FUNCTIONS _______________________________________________

-- Find the number of employees. 
SELECT COUNT(emp_id) -- COUNT is a SQL function. In this case, it'll tell us how many employee IDs are in the table. Since emp_id is the primary key, it'll also tell us how many employees are there. 
FROM employee; 


-- Find the number of female employees born after 1970. 
SELECT COUNT(emp_id)
FROM employee 
WHERE sex = 'F' AND birth_day > '1971-01-01';


-- Find the average of all employee's salaries. 
SELECT AVG(salary)
FROM employee;
--______________________
SELECT AVG(salary)
FROM employee
WHERE sex = 'M';


-- Find the sum of all employee's salaries
SELECT SUM(salary)
FROM employee;


-- AGGREGATION
-- An aggregate function is a function that performs a calculation on a set of values, and returns a single value. 
-- Aggregate functions are often used with the GROUP BY clause of the SELECT statement. The GROUP BY clause splits the result-set into groups of values and the aggregate function can be used to return a single value for each group.

-- Find out how many males and females there are. 
SELECT COUNT(sex), sex 
FROM employee
GROUP BY sex; -- the GROUP BY statement groups rows that have the same values into summary rows
--______________________
-- Find the total sales of each salesman
SELECT SUM(total_sales), emp_id 
FROM works_with
GROUP BY emp_id;
--______________________
-- Find the total amount spent by each client
SELECT SUM(total_sales), client_id 
FROM works_with
GROUP BY client_id;



-- WILDCARDS _______________________________________________
-- SQL Wildcard Characters are special characters used in SQL queries to search for patterns within string data.
/*

% = any number of characters.
_ = one character.

*/

-- Find any client's who are an LLC
SELECT * FROM client 
WHERE client_name LIKE '%LLC'; -- If client's name is like this pattern "LLC", then we want to return it. 


-- Find any branch suppliers who are in the label business. 
SELECT * FROM branch_supplier 
WHERE supplier_name LIKE '%label%';


-- Find any employee born in October
SELECT * FROM employee 
WHERE birth_day LIKE '____-10%'; -- it's going to match with any four characters, a hyphen, and then 10 and anything that goes after. 


-- Find any clients who are schools
SELECT * FROM client 
WHERE client_name LIKE '%school%';



-- UNION _______________________________________________
-- used to combine the results of multiple SELECT statements into one. 


-- Find the list of employee and branch names 
SELECT first_name FROM employee
UNION
SELECT branch_name FROM branch;
-- Rules:
/*
    1. Have to have the same number of columns that you're getting in each SELECT statement.
       In our case, we select one column in each SELECT statement. 
    2. Have to have similar datatypes. 
       In our case, first_name and branch_name are both strings.  
*/
SELECT first_name AS Company_Names 
FROM employee
UNION
SELECT branch_name FROM branch
UNION
SELECT client_name FROM client;


-- Find a list of all clients & branch suppliers' names 
SELECT client_name FROM client
UNION
SELECT supplier_name FROM branch_supplier;
--______________________
SELECT client_name, client.branch_id
FROM client
UNION
SELECT supplier_name, branch_supplier.branch_id
FROM branch_supplier;


-- Find a list of all money spent or earned by the company 
SELECT salary FROM employee
UNION 
SELECT total_sales FROM works_with;

-- The UNION operator selects only distinct values by default. To allow duplicate values, use UNION ALL. 
SELECT employee.emp_id FROM employee
UNION ALL 
SELECT works_with.emp_id FROM works_with;



-- JOINS _______________________________________________
-- A JOIN clause is used to combine rows from two or more tables, based on a related column between them.
INSERT INTO branch VALUES(4, 'Buffalo', NULL, NULL);


-- Find all branches and the names of their managers 
SELECT employee.emp_id, employee.first_name, branch.branch_name -- In our case, emp_id and mgr_id are related columns. 
FROM employee
JOIN branch -- Join the employee table and the branch table together into one table on a specific column (the column that they both have in common). 
ON employee.emp_id = branch.mgr_id; -- combine all of the rows from the employee table and all of the rows from the branch table as long as the mgr_id of the branch row is equal to the emp_id of the employee row. 
-- Only employees whose IDs' match the value in mgr_id column are joined together into combined table. 

-- Above, that's what we call the INNER JOIN. It combines the rows from Employee and Branch tables whenever they have a shared column in common. 


-- LEFT JOIN - we include all of the rows from left table. 
SELECT employee.emp_id, employee.first_name, branch.branch_name 
FROM employee -- Left table.
LEFT JOIN branch 
ON employee.emp_id = branch.mgr_id;


-- RIGHT JOIN - we include all of the rows from right table. 
SELECT employee.emp_id, employee.first_name, branch.branch_name 
FROM employee 
RIGHT JOIN branch -- Right table.
ON employee.emp_id = branch.mgr_id;

-- FULL OUTER JOIN (can't do in MySQL) - LEFT JOIN and RIGHT JOIN combined.



-- NESTED QUERIES _______________________________________________

-- Find names of all employees who have sold over $30,000 to a single client
/*
   In Works_With table, we have total_sales and emp_id, which is only a part of info we need. 
   So, we will use the emp_id in order to get their first and last name in employee table. 
*/
/*    
To get the emp_id who have sold over $30,000 to a single client:
SELECT works_with.emp_id 
FROM works_with 
WHERE works_with.total_sales > 30000;
*/
SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
   SELECT works_with.emp_id 
   FROM works_with 
   WHERE works_with.total_sales > 30000
);
-- Reads as: SELECT the first and last names FROM the employee table where the employee ID is IN the result of the given query. 


-- Find all clients who are handled by the branch that Michael Scott manages. Assume you know Michael's ID.
SELECT client.client_name
FROM client
WHERE client.branch_id = (       -- The equal sign "=" is used only for one outcome. To make sure we get only one, we use LIMIT 1. 
   SELECT branch.branch_id
   FROM branch
   WHERE branch.mgr_id = 102
   LIMIT 1
);



-- ON DELETE _______________________________________________
-- What happens when you delete an employee from the employee table that, for example, has a emp_id = 102? What happens to branch table with the mgr_id = 102 in this case? There are different options to handle situations like this. 

-- ON DELETE SET NULL - updates the foreign key column in the child table to NULL when the corresponding parent record is deleted.
-- In our case, the mgr_id that is associated with deleted employee will be set to NULL.

-- ON DELETE SET CASCADE - is used to delete the rows from the child table automatically, when the rows from the parent table are deleted.
-- In our case, if we delete an employee whose ID is stored in the mgr_id, then it's going to delete the entire row. 


-- ON DELETE SET NULL:
CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT, 
  mgr_start_date DATE,
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL -- if the emp_id in the employee table gets deleted, we want to set the mgr_id to NULL
);
-- To show, let's delete one employee. 
DELETE FROM employee
WHERE emp_id = 102;

-- Let's check the results
SELECT * FROM employee;
SELECT * FROM branch;


-- ON DELETE SET CASCADE:
CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE -- if the branch_id that's stored as the foreign key in the Branch Supplier table gets deleted, then we delete the entire row in the database (in the Branch Supplier table). 
);

-- To show, let's delete one branch_id. 
DELETE FROM branch
WHERE branch_id = 2;

-- Let's check the results
SELECT * FROM branch_supplier;

-- On the Branch table, it's okay to use ON DELETE SET NULL because the mgr_id on the Branch table is just a foreign key, not actually a primary key.
-- So, the mgr_id isn't absolutely essential for the Branch table. 

-- However, on the Branch Supplier table, the branch_id (foreign key) is also a part of the primary key, which means the branch_id is absolutely crucial. 
-- The primary key can not be NULL, so the entire row gets deleted. 



-- TRIGGERS _______________________________________________
-- SQL triggers are a critical feature in database management systems (DBMS) that provide automatic execution of a set of SQL statements
-- when specific database events, such as INSERT, UPDATE, or DELETE operations, occur.

CREATE TABLE trigger_test (
    message VARCHAR(100)
);

-- Triggers are defined in the command line. First, we have to use our database learningsql. Example how it looks:
/*
    mysql> use learningsql
    mysql> DELIMITER $$
    mysql> CREATE TRIGGER my_trigger BEFORE INSERT ON employee FOR EACH ROW BEGIN INSERT INTO trigger_test VALUES('added new employee'); END$$
    mysql> DELIMITER ;
*/
/*
-- An example trigger. 
DELIMITER $$ -- a special keyword in MySQL that changes MySQL delimiter. Because we might use the semicolon in the trigger to end an SQL command, we use DELIMITER keyword to change the delimiter to $$. 
        -- Trigger begins here. 
        -- We are defining the trigger and saying that Before something (any new items) gets inserted on the Employee table, for each of the new items (ROW) that are getting insetred, we want to insert into the trigger test table the value 'added new employee'.
CREATE
    TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_test VALUES('added new employee');
    END$$
        -- Trigger ends here.
DELIMITER ;
*/

-- Let's test it
INSERT INTO employee 
VALUES(109, 'Oscar', 'Martinez', '1968-02-19', 'M', 69000, 106, 3);
-- and check the trigger_test table. 
SELECT * FROM trigger_test;


-- Another example of a trigger. 
DELIMITER $$ 
CREATE
    TRIGGER my_trigger1 BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_test VALUES(NEW.first_name); -- NEW.first_name gives the first name of the employee that's getting inserted. It allows us to access a particular attribute about the thing we just inserted. NEW refers to the row that's getting inserted, and then we can access specific column from that row (.first_name).
    END$$
DELIMITER ;

INSERT INTO employee 
VALUES(111, 'Edik', 'Durak', '1996-08-20', 'M', 69000, 106, 3);

SELECT * FROM trigger_test;

-- Another example of a more complex trigger. 
DELIMITER $$ 
CREATE
    TRIGGER my_trigger2 BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        IF NEW.sex = 'M' THEN
            INSERT INTO trigger_test VALUES( 'added male');
        ELSEIF NEW.sex = 'F' THEN
            INSERT INTO trigger_test VALUES( 'added female');
        ELSE
            INSERT INTO trigger_test VALUES( 'added other employee');
        END IF;
    END$$
DELIMITER ;

INSERT INTO employee 
VALUES(112, 'Edik', 'Durachok', '1996-08-20', 'M', 69000, 106, 3);

INSERT INTO employee 
VALUES(113, 'Edik', 'Lady', '1996-08-20', 'F', 69000, 106, 3);

SELECT * FROM trigger_test;