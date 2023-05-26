# My SQL Course

## course setup

using mysql local install on windows service.
start the windows service
Connect with SQL Workbench to either the jer-standard or the local copy

## My SQL workbench

keyboard shortcuts in MySQL Workbench:  
execute selected or all with ctrl + enter, ctrl + shift enter for current statement under cursor only  
comment with -- and space after, or #  
or highlight in workbench and right click -> comment  
quotes: can use double or single in MySQL. Ansi sql is single quotes. If the data has quotes, use \' . Can add double quotes to a string to store them.  

## common commands

```sql

USE dog_walking_app;
SELECT database();
SHOW tables;
SHOW COLUMNS FROM cats;
DESC cats;

## functions

-- format number:
Format(number, number of places, locale)


## manipulation

-- multi insert
INSERT INTO people(first_name, last_name, age)
VALUES
    ('Linda', 'Belcher', 45),
    ('Phillip', 'Frond', 38),
    ('Calvin', 'Fischoeder', 70);

-- default values
CREATE TABLE cats3  (    
    name VARCHAR(20) DEFAULT 'no name provided',
    age INT DEFAULT 99  
);

-- PK
CREATE TABLE unique_cats (
	cat_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL
);

--other way to set PK

CREATE TABLE unique_cats2 (
	cat_id INT,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY (cat_id)

-- auto increment
CREATE TABLE unique_cats3 (
    cat_id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY (cat_id)
);

-- alias with AS
SELECT cat_id AS id, name FROM cats;

-- strings
SELECT CONCAT(author_lname, ' is ', CHAR_LENGTH(author_lname), ' characters long') FROM books;

-- distinct
SELECT DISTINCT CONCAT(author_fname,' ', author_lname) FROM books;

order by 
SELECT title, released_year FROM books 
ORDER BY released_year DESC LIMIT 5;

--group by concat and format
select concat(author_fname, ' ', author_lname), format(sum(released_year) / count(*), 0) as average from books group by concat(author_fname, ' ', author_lname);
```

## datatypes

```sql

-- total length and number of decimal places
decimal(5, 2)
-- float & double
-- double is more precision
-- date is date only, time time only, datetime is both
-- timestamp is smaller range datetime. good for e.g. event time. les space than datetime.

-- dates
SELECT CURTIME();
SELECT CURDATE();
SELECT NOW();
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Hazel', CURDATE(), CURTIME(), NOW());

-- date functions
SELECT 
    birthdate,
    DAY(birthdate),
    DAYOFWEEK(birthdate),
    DAYOFYEAR(birthdate)
FROM people;
 
SELECT 
    birthdate,
    MONTHNAME(birthdate),
    YEAR(birthdate)
FROM people;

SELECT 
    birthtime,
    HOUR(birthtime),
    MINUTE(birthtime)
FROM people;
 
SELECT 
    birthdt,
    MONTH(birthdt),
    DAY(birthdt),
    HOUR(birthdt),
    MINUTE(birthdt)
FROM people;

-- date formatting
-- date format abbreviations
-- %b is month in 3 chars, %c is month numeric, %a is weekday etc. 
SELECT birthdate, DATE_FORMAT(birthdate, '%a %b %D') FROM people;
SELECT birthdt, DATE_FORMAT(birthdt, '%H:%i') FROM people;
SELECT birthdt, DATE_FORMAT(birthdt, 'BORN ON: %r') FROM people;
-- format  dd/mm/yyyy
select DATE_FORMAT(curdate(), '%d/%c/%Y'), 

-- date defaults
CREATE TABLE captions (
  text VARCHAR(150),
  created_at TIMESTAMP default CURRENT_TIMESTAMP
);
 
CREATE TABLE captions2 (
  text VARCHAR(150),
  created_at TIMESTAMP default CURRENT_TIMESTAMP,
  updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);



```

## Joins

```sql

SELECT first_name, last_name, sum(amount) as total FROM orders
JOIN customers ON customers.id = orders.customer_id
group by first_name, last_name
order by total;

-- left join means all of the table on the left are included
-- so this right join includes all rows from customers table
-- every order  has a customer, not every customer has an order
SELECT first_name, last_name, sum(amount) as total FROM orders
right JOIN customers ON customers.id = orders.customer_id
group by first_name, last_name
order by total;

-- 4 ways to substitute missing values, like isnull()
select first_name, 
	case when (title is null) then "Missing" else title end, 
    ifnull(title, "MISSING"), 
	-- for coalesce you provide as many arguments as you need. COALESCE() will then return the first non-NULL value in the list, or NULL if there are no non-NULL values.
    coalesce(title, "MISSING"), 
    if(title is null, "MISSING", title)
    grade
from students 
left join papers on id = student_id;

-- finding where not exists
select title 
from series 
left join reviews on series.id = reviews.series_id
where reviews.id is null;

select title 
from series s
where not exists (select * from reviews r where s.id = r.series_id);

select first_name, last_name, count(*), count(rating), min(rating), max(rating), format(avg(rating), 1) as avg_rating
from reviewers r
left join reviews rev on r.id = rev.reviewer_id
group by first_name, last_name;

```

## Views

```sql
-- CREATE A VIEW:
CREATE VIEW jb1 AS
SELECT title, released_year, genre, rating, first_name, last_name FROM reviews
JOIN series ON series.id = reviews.series_id
JOIN reviewers ON reviewers.id = reviews.reviewer_id;

-- You can't update or delete a join view. 
-- some views are updatable, and e.g. group functions or distinct etc.

CREATE OR REPLACE VIEW jb1 AS
SELECT title, released_year, genre, rating, first_name, last_name FROM reviews
JOIN series ON series.id = reviews.series_id
JOIN reviewers ON reviewers.id = reviews.reviewer_id;

```

## group by

```sql
-- having limits groups

-- with ROLLUP does aggregation up the hierarchy, ie includes a total of the totals
SELECT title, COUNT(rating)
FROM full_reviews
GROUP BY title WITH ROLLUP;
```

## SQL modes

settings that affect syntax  
modes are global or session  
session start at default global values  

STRICT_TRANS_TABLES mode: this controls what happens when changing data and the data is invalid.  
e.g. insert a string into a decimal, get error back.  
if turn off the strict_trans_tables mode, can insert with incorrect data type and get warning back. Value that is inserted is somehow converted to a different value.  

ONLY_FULL_GROUP_BY: rejects queries where non aggregated cols are in the select list
NO_ZERO_IN_DATE: limits dates with no date!!

```sql
select @@GLOBAL.sql_mode
STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION
select @@SESSION.sql_mode

-- to set
SET SESSION sql_mode = "ONLY_FULL_GROUP,NO_ZERO_DATE";

```

## Window functions

These produce additional result columns aggregating over the other rows in the query.
```sql
SELECT
         year, country, product, profit,
         SUM(profit) OVER() AS total_profit,
         SUM(profit) OVER(PARTITION BY country) AS country_profit
       FROM sales
       ORDER BY country, year, product, profit;

+------+---------+------------+--------+--------------+----------------+
| year | country | product    | profit | total_profit | country_profit |
+------+---------+------------+--------+--------------+----------------+
| 2000 | Finland | Computer   |   1500 |         7535 |           1610 |
| 2000 | Finland | Phone      |    100 |         7535 |           1610 |
| 2001 | Finland | Phone      |     10 |         7535 |           1610 |
| 2000 | India   | Calculator |     75 |         7535 |           1350 |
| 2000 | India   | Calculator |     75 |         7535 |           1350 |
| 2000 | India   | Computer   |   1200 |         7535 |           1350 |
| 2000 | USA     | Calculator |     75 |         7535 |           4575 |
| 2000 | USA     | Computer   |   1500 |         7535 |           4575 |
| 2001 | USA     | Calculator |     50 |         7535 |           4575 |
| 2001 | USA     | Computer   |   1200 |         7535 |           4575 |
| 2001 | USA     | Computer   |   1500 |         7535 |           4575 |
| 2001 | USA     | TV         |    100 |         7535 |           4575 |
| 2001 | USA     | TV         |    150 |         7535 |           4575 |
+------+---------+------------+--------+--------------+----------------+

```

