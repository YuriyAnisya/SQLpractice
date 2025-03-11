-- CREATE COMPANY DATABASE _______________________________________________

-- 1. First, we create Employee table. 
/* 
        emp_id is the employment ID and primary key of the table.
        super_id is the supervisor ID and foreign key that points to another empleyee.
        branch_id is the branch ID and foreign key that point to the brach table. 
*/
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    birth_day DATE,
    sex VARCHAR(1),
    salary INT,
    -- We can't make them as foreign keys just yet because the Employee table and Branch table 
    -- do not technically exist yet. 
    -- We are going to define them as foreign key later. 
    super_id INT,
    branch_id INT
);

-- ___________________________________________________________

-- 2. Create Branch table. 

CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT, -- a foreign key that points to employee table. 
  mgr_start_date DATE,
  -- Define the foreign key mgr_id which references the emp_id in the employee table. 
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

-- ___________________________________________________________

-- 3. Set branch_id and super_id as foreign keys in the employee table. 

ALTER TABLE employee
ADD FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL;
--______________________
ALTER TABLE employee
ADD FOREIGN KEY(super_id) REFERENCES employee(emp_id) ON DELETE SET NULL;

-- ___________________________________________________________

-- 4. Create Client table.

CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40),
  branch_id INT,
  -- Define the foreign key branch_id which references the branch_id in the branch table.
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

-- ___________________________________________________________

-- 5. Create Works With table.

CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  -- Composite Primary Key.
  PRIMARY KEY(emp_id, client_id),
  -- In this case, each component of the primary key is a Foreign Key. 
  /*
      Define the foreign key emp_id which references the emp_id in the employee table.
      Define the foreign key client_id which references the client_id in the client table.
  */
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE, 
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

-- ___________________________________________________________

-- 6. Create Branch Supplier table. 

CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  -- Composite Primary Key.
  PRIMARY KEY(branch_id, supplier_name),
  -- Define the foreign key branch_id which references the branch_id in the branch table.
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

-- ___________________________________________________________

--                          INSERT INFORMATION INTO THE TABLES                          --

-- 7. Begin inserting information into the tables (we start with Corporate branch):

-- a) We insert David into the employee table. The branch_id is set to NULL because the branch wasn't created in the branch table yet. 
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);
-- b) We create the Corporate branch in the branch table. 
INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');
-- c) And now, we can update the employee table ans set the branch_id to 1 for David. 
UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;
-- d) Insert more info. 
INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- ___________________________________________________________

-- 8. Continue inserting information into the tables (Scranton branch):

INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- ___________________________________________________________

-- 9. Continue inserting information into the tables (Stamford branch):

INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

-- DONE INSERTING INFO TO EMPLOYEE AND BRANCH TABLES. 

-- ___________________________________________________________

-- 10. Insert info into Branch Supplier table.

INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- ___________________________________________________________

-- 11. Insert info into Client table.

INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- ___________________________________________________________

-- 12. Insert info into Client table.

INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

-- ___________________________________________________________

-- 13. DONE WITH INSERTING INFO INTO THE TABLES. Check the tables. 
SELECT * FROM employee;
SELECT * FROM branch;
SELECT * FROM branch_supplier;
SELECT * FROM client;
SELECT * FROM works_with;