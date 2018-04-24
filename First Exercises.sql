-- SELECT CONCAT
--     (
--         SUBSTRING(title, 1, 15),
--         '...'
--     ) AS 'Short Title'
-- FROM books;

-- SELECT SUBSTRING(REPLACE(title,  'e', '3'),1,15) AS 'REPLACED'
-- FROM books;

-- SELECT
--     CONCAT(SUBSTRING(title, 1, 15), '...') AS 'Short title',
--     CONCAT(author_lname, ', ', author_fname) AS 'Author',
--     CONCAT(stock_quantity, ' in stock') AS 'quantity'
-- FROM books;


-- SELECT 
--     CONCAT(title, ' - ', released_year) AS 'Summary'
-- FROM books ORDER BY released_year DESC  LIMIT 3;

-- SELECT
--     released_year AS year,
--     COUNT(author_fname) AS '# Books',
--     AVG(pages) AS 'Avg pages'
-- FROM books GROUP BY released_year;

SELECT title, author_lname FROM books
WHERE SUBSTRING(author_lname,1,1) IN ('C', 's');

SELECT title, author_lname,
    CASE
        WHEN title LIKE '%stories%' THEN 'Short Stories'
        WHEN title LIKE '%just kids%' THEN 'Memoir'
        ELSE 'Novel'
    END AS genre
FROM books;

SELECT title, author_lname, 
    CASE
        WHEN COUNT(*) = 1 THEN CONCAT(COUNT(*), ' book')
        ELSE CONCAT(COUNT(*), ' books')
    END AS 'COUNT'
FROM books GROUP BY author_lname;




-- Creating the customers and orders tables

CREATE TABLE customers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);
CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);
-- Inserting some customers and orders

INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5);
       
       
SELECT first_name, title, grade
    FROM students JOIN papers ON
    students.id = papers.student_id
    ORDER BY papers.grade DESC;
    
SELECT first_name, title, grade
    FROM students 
    LEFT JOIN papers ON
    students.id = papers.student_id
   ;
   
  SELECT first_name, 
    IFNULL(title, 'MISSING') AS title,
    IFNULL(grade, 0) AS grade
    FROM students 
    LEFT JOIN papers ON
    students.id = papers.student_id
   ;
   
SELECT first_name,
    IFNULL(AVG(grade),0)  AS average,
    CASE
        WHEN AVG(grade) >= 75 THEN 'PASSING'
        ELSE 'Failing'
    END AS passing_status
    FROM students 
    LEFT JOIN papers ON
    students.id = papers.student_id
    GROUP BY students.id
    ORDER BY average DESC
   ;