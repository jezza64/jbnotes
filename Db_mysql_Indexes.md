# MySQL Indexes

## Basics

Faster retrieval, slower updates
CLustered index forces the storage order of the rows
PRIMARY index is clustered.

### index features

InnoDB - Btree index
MyISAM - Btree index
MEMORY/HEAP - Hash or Btree.

can:

- store comments
- make indexes invisible
- use collation to sort asc or desc in index
- index on expression

```sql
-- syntax
CREATE INDEX index_name ON table_name (column_list)

-- can create index with table
CREATE TABLE t(
   c1 INT PRIMARY KEY,
   c2 INT NOT NULL,
   c3 INT NOT NULL,
   c4 VARCHAR(10),
   INDEX (c2,c3) 
);

-- to just see query plan:
EXPLAIN SELECT..

-- to list indexes
SHOW INDEXES FROM employees;

-- drop index
DROP INDEX index_name ON table_name
[algorithm_option | lock_option];

-- drop index algorithms
ALGORITHM [=] {DEFAULT|INPLACE|COPY}
-- Default is INPLACE, which doesn't need a table lock

-- drop index lock types
LOCK [=] {DEFAULT|NONE|SHARED|EXCLUSIVE}

```