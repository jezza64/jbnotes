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

