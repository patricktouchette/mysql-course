#### Cloud 9 Setup for MYSQL
mysql-ctl start                 To start MYSQL
mysql-ctl cli                   To open mysql command line
mysql-ctl stop                  To stop MYSQL
phpmyadmin-ctl install          To install phpmyadmin

#### MYSQL COMMAND LINE
show databases ;                To show databases
quit;   or ctrl-c               To exit mysql command line
help;
help contents;
show databases;
select @@hostname;


CREATE DATABASE name;           Creates database
DROP DATABASE name;             Deletes database
SELECT database();              Shows currently used database
USE database;                   Uses database

CREATE TABLE tablename (column_name data_type, column_name data_type);
CREATE TABLE cats (name VARCHAR(50), quantity INT);
SHOW TABLES;
SHOW COLUMNS FROM tablename;   or DESC tablename
DROP TABLE tablename
CREATE TABLE tablename (id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
                        name VARCHAR(100),
                        age INT
                        );

INSERT INTO tablename(column1, column2) VALUES('test', 11);
INSERT INTO cats(name, quantity) VALUES('test', 11);
INSERT INTO cats(name, age) VALUES ('Peanut', 2), ('Butter', 4);
INSERT INTO table_name 
            (column_name, column_name) 
VALUES      (value, value), 
            (value, value), 
            (value, value);
            
SHOW WARNINGS;
name VARCHAR(50) NOT NULL
DEFAULT


SELECT * FROM tablename;
SELECT name, age FROM cats;
SELECT * FROM cats WHERE age=4;
SELECT cat_id AS id, name FROM cats;

UPDATE cats SET breed='Shorthair' WHERE breed='Tabby';
UPDATE cats SET age=14 WHERE cat_id=5;

DELETE FROM cats WHERE name='Egg';
DELETE FROM cats;     deletes everything.!!


SOURCE path/filename.sql         Run sql file

#### The World of string Functions
USE book_store
SELECT author_fname AS first, author_lname AS last,
    CONCAT(author_fname, ' ', author_lname) AS full
    FROM books;
CONCAT_WS('seperator', col1, col2)
SELECT SUBSTRING('Hello World', 1,4);   HELL
SELECT SUBSTRING('Hello World', 7); World
SELECT SUBSTRING('Hello World', -3); rld
SELECT REPLACE('Hello Word', 'Hell', '$#!%')
SELECT REVERSE('Hello World');
SELECT CONCAT('woof', REVERSE('woof'));
SELECT CHAR_LENGTH('Hello World');
SELECT author_lname,  CHAR_LENGTH(author_lname) AS 'length' FROM books;
SELECT UPPER('test');
SELECT LOWER('tTEssetT');
SELECT DISTINCT author_lname FROM books;
SELECT DISTINCT author_fname, author_lname FROM books;
SELECT author_lname FROM books ORDER BY author_lname; ASC or DESC
SELECT col1, col2, col3 ORDER BY 2 ; orders by col1 then col2
SELECT titles FROM books LIMIT 10;
LIKE
WHERE author_fname LIKE '%da%'


#### Aggregate Functions
SELECT COUNT(*) FROM books;
SELECT COUNT(DISTINCT author_fname) FROM books;
SELECT title, author_lname FROM books GROUP BY author_lname;
SELECT author_lname, COUNT(*) FROM books GROUP BY author_lname;
SELECT MIN(pages) FROM books;
SELECT MAX(pages) FROM books;
SELECT author_fname, author_lname, MAX(pages) 
    FROM books GROUP BY author_lname, author_fname;
SELECT AVG(released_year) FROM books;
SELECT released_year, AVG(stock_quantity) FROM books GROUP BY released_year;
SELECT SUM(stock_quantity) FROM books;

### Sub Query
SELECT * FROM books
WHERE pages = (SELECT MAX(pages) FROM books);


#### DAta Types
DECIMAL(5,2) 5 digits long, so 500.00
FLOAT- 7 digits precision
DOUBLE - 15 digits precision

### Dates
DATE
TIME
DATETIME
CURDATE()
CURTIME()
NOW()
SELECT DATE_FORMAT(datetime, '%W%M%Y')
SELECT DATEDIFF(NOW(), birthdate) FROM people;
DATE_ADD(date, )
+/- you can change together with + INTERVAL 10 MONTH, INTERVAL 10 SECOND
CREATE TABLE comments (content VARCHAR(100), created_at TIMESTAMP DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP);

### Logical operators
!=
NOT LIKE
SELECT title FROM books WHERE title NOT LIKE 'W%';
AND or &&
OR ||
BETWEEN
SELECT title, released_year FROM books WHERE released_year BETWEEN 2004 AND 2015;
NOT BETWEEN
IN   / NOT IN
SELECT title, author_lname FROM books WHERE author_lname IN ('Carver', 'Lahiri', 'Smith');
IFNULL(value, 0)
IF(condition to check, ifTrue, ifFalse)

SELECT title, released_year,
    CASE
        WHEN released_year >= 2000 THEN 'Modern Lit'
        ELSE '20th Century Lit'
    END AS genre
FROM books;

### JOINS
-Implicit inner join
SELECT * FROM customers, orders 
WHERE customers.id = orders.customer_id; 

-Explicit inner join
SELECT * FROM customers 
JOIN orders ON customers.id = orders.customer_id;

SELECT first_name, last_name, order_date, amount
FROM customers JOIN orders
    ON customers.id = orders.customer_id
ORDER BY amount;

SELECT first_name, last_name, order_date, SUM(amount) AS total
FROM customers JOIN orders
    ON customers.id = orders.customer_id
GROUP BY orders.customer_id
ORDER BY total DESC;

-- LEFT JOIN
SELECT * FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id;
    
--RIGHT JOIN
SELECT * FROM customers
RIGHT JOIN orders
    ON customers.id = orders.customer_id;
    
-- ON DELETE CASCADE
FOREIGN KEY(customer_id) REFERENCES customers(id)
ON DELETE CASCADE

