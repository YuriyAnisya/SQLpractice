/*
-- Basic data types:
INT -- Whole Numbers 
DECIMAL(M,N) -- Decimal Numbers - Exact Value (M - total digits, where N of those digits coming after the decimal point)
VARCHAR(1) -- String of text of length 1
BLOB -- Binary Large Object, Stores large data
DATE -- 'YYYY-MM-DD'
TIMESTAMP -- 'YYYY-MM-DD HH:MM:SS' - used for recording when something happens. 
*/

-- IMPORTANT - In PopSQL, if you clicl on the SQL statement, and then click run - it will run the chosen statement separately of all other statements. 

-- First step, create a table inside the database. 
CREATE TABLE student (    -- Define attributes and data types.
    student_id INT,      -- Attribute, data type
    name VARCHAR(20),
    major VARCHAR(20),
    PRIMARY KEY (student_id)    -- Define primary key
);

-- Describes the table. 
DESCRIBE student;

-- Delete the table. 
DROP TABLE student;

-- Add column to the table. 
ALTER TABLE student ADD gpa DECIMAL(3, 2);

-- Remove column from the table 
ALTER TABLE student DROP COLUMN gpa;

-- INSERTING DATA _______________________________________________

-- To get all the info from the table:
SELECT * FROM student; -- reads like this: Select all from student table.

-- Insert data. No need to type a new line of code, just change the values and run the code again. 
INSERT INTO student VALUES(5, 'Mike', 'CS'); --  student_id = 1, name = Jack, major = Biology. 
-- In this case, we indicate that we can only insert two specific attributes. 
INSERT INTO student(student_id, name) VALUES(3, 'Claire'); 

-- CONSTRAINS _______________________________________________
-- Constrains, for example, are NOT NULL and UNIQUE. 
-- A  way to create the student table in order to make it a little bit easier to insert info and control what data is entered. 
CREATE TABLE student (    
    student_id INT,      
    name VARCHAR(20) NOT NULL,      -- NOT NULL means this column can't be null. 
    major VARCHAR(20) UNIQUE,       -- UNIQUE means that the major field has to be unique for each row in this table. 
    PRIMARY KEY (student_id)    
);
INSERT INTO student VALUES(1, 'Jack', 'Biology');
INSERT INTO student VALUES(2, 'Kate', 'Sociology');
INSERT INTO student VALUES(3, NULL, 'Chemistry'); -- Gives error, since the name cannot be null. 
INSERT INTO student VALUES(3, 'Claire', 'Chemistry');
INSERT INTO student VALUES(4, 'Jack', 'Biology'); -- Gives error, since we indicated that the major field has to be unique, Biology is a duplicate entry. 
INSERT INTO student VALUES(4, 'Jack', 'Crypto');
INSERT INTO student VALUES(5, 'Mike', 'CS');
-- ___________________________________________________________

CREATE TABLE student (    
    student_id INT,      
    name VARCHAR(20), 
    major VARCHAR(20) DEFAULT 'undecided',       -- DEFAULT means default value if no input
    PRIMARY KEY (student_id)    
);
INSERT INTO student(student_id, name) VALUES(3, 'Claire'); 

-- ___________________________________________________________

CREATE TABLE student (    
    student_id INT AUTO_INCREMENT,    -- AUTO_INCREMENT means that the data that gets gets inserted into student_id is automatically incremented every time we add one in.        
    name VARCHAR(20),
    major VARCHAR(20),       -- 
    PRIMARY KEY (student_id)    
);
INSERT INTO student(name, major) VALUES('Jack', 'CS');
INSERT INTO student(name, major) VALUES('Kate', 'Sociology');


-- UPDATE & DELETE _______________________________________________
/*
CREATE TABLE student (    
    student_id INT,      
    name VARCHAR(20),      -- NOT NULL means this column can't be null. 
    major VARCHAR(20),       -- UNIQUE means that the major field has to be unique for each row in this table. 
    PRIMARY KEY (student_id)    
);
INSERT INTO student VALUES(1, 'Jack', 'Biology');
INSERT INTO student VALUES(2, 'Kate', 'Sociology');
INSERT INTO student VALUES(3, 'Claire', 'Chemistry');
INSERT INTO student VALUES(4, 'Jack', 'Biology');
INSERT INTO student VALUES(5, 'Mike', 'CS');
*/
/*
Comparision ops:
=   :equals
<>  :not equal
>   :greater than
<   :less than
>=  :greater than or equal 
<=  :less than or equal
*/
SELECT * FROM student;


-- Reads as: Update the student table. Set major to Bio where major is set as Biology
UPDATE student 
SET major = 'Bio'
WHERE major = 'Biology';
--______________________
UPDATE student 
SET major = 'CS'
WHERE student_id = 3;
--______________________
UPDATE student 
SET major = 'BioProgramming'
WHERE major = 'Bio' OR major = 'CS';
--______________________
UPDATE student 
SET name = 'Voldemort', major = 'Dark Lord'
WHERE student_id = 1;
--______________________
UPDATE student 
SET major = 'Wizard';

-- ___________________________________________________________

DELETE FROM student; -- deletes all rows inside the student table. 

DELETE FROM student
WHERE student_id = 1; -- Deletes any row from the table that have a student_id = 5. 

DELETE FROM student
WHERE name = 'Voldemort' AND major = 'Wizard';


-- BASIC QUERIES _______________________________________________
SELECT * FROM student; -- Reads as: Selecn every column from the table. 

-- We can specify what column to select
SELECT name FROM student;

SELECT name, major 
FROM student;
-- OR -- 
SELECT student.name, student.major 
FROM student;


SELECT student.name, student.major 
FROM student
ORDER BY name; -- outputs names in alphabetical order, and in ascending order by default. 
--______________________
SELECT * 
FROM student
ORDER BY student_id ASC; -- DESC - in descending order. ASC - in ascending order. 
--______________________
SELECT * 
FROM student
ORDER BY major, student_id; -- it's going to order by major first. If same major, it'll order by student_id. 


-- Reads as: Select all from student table. Order by student_id in descending order and limit to 2. 
SELECT * 
FROM student
ORDER BY student_id DESC
LIMIT 2; -- limits the output to 2. 


SELECT name, major 
FROM student
WHERE major = 'Biology' OR major = 'CS' OR name = 'Kate';
--______________________
SELECT name, major 
FROM student
WHERE major <> 'Biology'; -- where major not equal to Biology
--______________________
SELECT * 
FROM student
WHERE student_id < 3 AND name <> 'Jack';


-- Reads as: Select all from student table where the name is in the given group of values. 
SELECT * 
FROM student
WHERE name IN ('Claire', 'Kate', 'Mike');
--______________________
SELECT * 
FROM student
WHERE major IN ('CS', 'Chemistry') AND name IN ('Claire', 'Kate', 'Mike') AND student_id >= 3;