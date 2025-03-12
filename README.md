# Company Database (SQL Learning Project)

## Overview
This project is designed to facilitate learning **SQL basics** through building and working with a **Company Database**. It covers fundamental SQL concepts like table creation, data types, relationships, primary and foreign keys, querying with SELECT, filtering data, using joins, aggregating results, and more. The provided SQL files guide through different stages of learning SQL and applying it to real-world business data.

## Purpose
The primary goal of this project is to provide hands-on experience with SQL. By working with these SQL files, the following concepts are explored:
- Creation of tables and definition of data types.
- Understanding the definition and use of primary keys, foreign keys, and relationships between tables.
- Insertion, updating, and deletion of data.
- Writing SQL queries to retrieve data, filter results, and perform aggregations.
- Implementing complex queries using JOINs, GROUP BY, and subqueries.

## Files Included

### 1. **learningConcepts_PartOne.sql**
This file introduces the basics of SQL:
- **Table Creation**: Learning how to create tables and define columns.
- **Data Types**: Understanding various data types used in SQL.
- **Primary and Foreign Keys**: Defining primary and foreign keys to establish relationships between tables.

### 2. **CompanyDatabase_LearningConcepts.sql**
This file builds upon Part One and adds functionality:
- **Data Insertion**: Inserting sample data into the tables.
- **Basic SELECT Queries**: Writing simple queries to retrieve data from the tables.
- **Relationship Queries**: Querying data from multiple tables using basic SQL joins.

### 3. **company-database.png**
This PNG file (company-database.png) provides a **visual representation of the Company Database schema**. It includes:
- **Table Structures**: Diagrams showing the structure of the `Employee`, `Branch`, `Client`, `Works_With`, and `Branch_Supplier` tables.
- **Relationships**: Clear illustrations of how tables are related, highlighting primary and foreign keys.
- **Entity Attributes**: A detailed breakdown of the attributes for each entity in the database.
  
### 4. **learningConcepts_PartTwo.sql**
This file introduces more advanced SQL concepts and functions:
- **Basic Queries**: Several basic queries for selecting data, ordering results, and using the `LIMIT` and `DISTINCT` clauses to filter and manipulate results. Example queries include ordering employees by salary, selecting distinct genders, and using `LIMIT` to fetch a specific number of records.
  
- **Aggregate Functions**: The use of functions like `COUNT()`, `AVG()`, and `SUM()` is demonstrated to perform calculations on sets of values. Examples include:
  - Counting the total number of employees.
  - Calculating the average salary of male employees.
  - Summing total sales for each employee.

- **Grouping Data**: The file demonstrates the use of the `GROUP BY` clause to group rows by specific columns (e.g., counting male and female employees, calculating total sales by employee or client).

- **Wildcards**: SQL wildcard characters (`%`, `_`) are used to search for patterns within string data, such as finding clients whose names contain "LLC" or employees born in October.

- **UNION**: Combines the results of multiple `SELECT` statements into a single result set, ensuring the same number of columns and compatible data types across queries. Examples include creating lists of employee, client, and branch names or combining financial data (e.g., salary and sales).

- **Joins**: The file demonstrates several types of SQL joins:
  - **INNER JOIN**: Combining rows from two tables where a matching column exists (e.g., finding managers and their branches).
  - **LEFT JOIN**: Including all rows from the left table, even if there is no match in the right table.
  - **RIGHT JOIN**: Including all rows from the right table, even if there is no match in the left table.

- **Nested Queries**: Examples of subqueries (nested SELECT statements) are provided. These queries fetch data based on conditions set by another query, such as finding employees who sold over $30,000 or finding clients handled by a specific branch manager.

- **Delete Operations**: The file shows how to use `ON DELETE` clauses to handle cascading deletes or setting foreign key columns to `NULL` when a referenced row is deleted. For example, deleting an employee might set the corresponding manager ID to `NULL` in the `branch` table, or delete all related rows in `branch_supplier`.

- **Triggers**: Examples of SQL triggers are included, showing how to automatically execute SQL statements when certain events occur (e.g., when a new employee is inserted). The triggers can insert data into other tables or perform custom logic based on inserted values.
