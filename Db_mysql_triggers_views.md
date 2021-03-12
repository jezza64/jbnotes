# MYSQL views, Triggers

## Views

- By definition, a view is a named query stored in the database catalog.
- Note that a view does not physically store the data.
- MySQL allows you to create a view based on another view.

Good for

- simplify complex query
- add security
- consistent business logic
- backward compatibility

By default column names from select statement but can rename in definition
order by optional, acts if no other order by.

### Algorithm type

The CREATE VIEW and ALTER VIEW statements have an optional clause: ALGORITHM. The algorithm determines how MySQL process a view and can take one of three values MERGE, TEMPTABLE, and UNDEFINE.

- Merge: does view resolution to combine SQL with view definition and resolve
- Temptable: creates temp table and then runs outer query. Not updatable, less efficient.
- Undefined: allows MySQL to choose either MERGE or TEMPTABLE. Generally does merge, if not possible them temptable.

### Updatable views

- no aggregate functions, distinct, union, outer joins, etc.
- You can check if a view in a database in updatable by querying the is_updatable column from the views table in the information_schema database.
- The WITH CHECK OPTION is an optional clause of the CREATE VIEW statement. The WITH CHECK OPTION prevents a view from updating or inserting rows that are not visible through it.
- To determine the scope of the check, MySQL provides two options: LOCAL and CASCADED. If you don’t specify the keyword explicitly in the WITH CHECK OPTION clause, MySQL uses CASCADED by default.

```sql
-- syntax
CREATE [OR REPLACE] VIEW [db_name.]view_name [(column_list)]
AS
  select-statement;

-- syntax with ALGORITHM clause
CREATE [OR REPLACE][ALGORITHM = {MERGE | TEMPTABLE | UNDEFINED}] VIEW 
   view_name[(column_list)]
AS 
   select-statement;

-- example
CREATE VIEW salePerOrder AS
    SELECT 
        orderNumber, 
        SUM(quantityOrdered * priceEach) total
    FROM
        orderDetails
    GROUP by orderNumber
    ORDER BY total DESC;


-- doesnt show views
SHOW TABLES;
-- does show views
SHOW ALL TABLES;
-- only views
SHOW FULL TABLES 
WHERE table_type = 'VIEW'
-- show definition
SHOW CREATE VIEW [database_name].[view_ name];

-- using system catalogue:
SELECT * 
FROM information_schema.tables;

SELECT 
    table_name view_name
FROM 
    information_schema.tables 
WHERE 
    table_type   = 'VIEW' AND 
    table_schema = 'classicmodels';


-- join example
CREATE OR REPLACE VIEW customerOrders AS
SELECT 
    orderNumber,
    customerName,
    SUM(quantityOrdered * priceEach) total
FROM
    orderDetails
INNER JOIN orders o USING (orderNumber)
INNER JOIN customers USING (customerNumber)
GROUP BY orderNumber;

-- subquery example
CREATE VIEW aboveAvgProducts AS
    SELECT 
        productCode, 
        productName, 
        buyPrice
    FROM
        products
    WHERE
        buyPrice > (
            SELECT 
                AVG(buyPrice)
            FROM
                products)
    ORDER BY buyPrice DESC;


    -- check if updatable
SELECT 
    table_name, 
    is_updatable
FROM
    information_schema.views
WHERE
    table_schema = 'classicmodels';

```



## Triggers

The SQL standard defines two types of triggers: row-level triggers and statement-level triggers.

- A row-level trigger is activated for each row that is inserted, updated, or deleted.  For example, if a table has 100 rows inserted, updated, or deleted, the trigger is automatically invoked 100 times for the 100 rows affected.
- A statement-level trigger is executed once for each transaction regardless of how many rows are inserted, updated, or deleted.

**MySQL supports only row-level triggers. It doesn’t support statement-level triggers.**

- not called for TRUNCATE
- REPLACE calls the INSERT trigger.
- LOAD DATA calls the INSERT trigger
- good naming convention is (BEFORE | AFTER)_tableName_(INSERT| UPDATE | DELETE)
- MySQL stores triggers in a data directory e.g., /data/classicmodels/ with the files named tablename.TRG and triggername.TRN. The tablename.TRG file maps the trigger to the corresponding table. the triggername.TRN file contains the trigger definition.

MySQL triggers cannot:

- Use SHOW, LOAD DATA, LOAD TABLE, BACKUP DATABASE, RESTORE, FLUSH and RETURN statements.
- Use statements that commit or rollback implicitly or explicitly such as COMMIT , ROLLBACK , START TRANSACTION , LOCK/UNLOCK TABLES , ALTER , CREATE , DROP ,  RENAME.
- Use prepared statements such as PREPARE and EXECUTE.
- Use dynamic SQL statements.

Advantages of triggers

- Triggers provide another way to check the integrity of data.
- Triggers handle errors from the database layer.
- Triggers give an alternative way to run scheduled tasks. By using triggers, you don’t have to wait for the scheduled events to run because the triggers are invoked automatically before or after a change is made to the data in a table.
- Triggers can be useful for auditing the data changes in tables.

Disadvantages of triggers

- Triggers can only provide extended validations, not all validations. For simple validations, you can use the NOT NULL, UNIQUE, CHECK and FOREIGN KEY constraints.
- Triggers can be difficult to troubleshoot because they execute automatically in the database, which may not invisible to the client applications.
- Triggers may increase the overhead of the MySQL Server.

### features

- run Before or after row modification
- The trigger body can access the values of the column being affected by the DML statement.
- To distinguish between the value of the columns BEFORE and AFTER the DML has fired, you use the NEW and OLD modifiers

### coded

```sql
-- basic syntax
CREATE TRIGGER trigger_name
{BEFORE | AFTER} {INSERT | UPDATE| DELETE }
ON table_name FOR EACH ROW
trigger_body;

-- example
CREATE TRIGGER before_employee_update 
    BEFORE UPDATE ON employees
    FOR EACH ROW 
 INSERT INTO employees_audit
 SET action = 'update',
     employeeNumber = OLD.employeeNumber,
     lastname = OLD.lastname,
     changedat = NOW();

-- drop
DROP TRIGGER [IF EXISTS] [schema_name.]trigger_name;

-- before insert
CREATE TRIGGER before_workcenters_insert
BEFORE INSERT
ON WorkCenters FOR EACH ROW
BEGIN
    DECLARE rowcount INT;
    
    SELECT COUNT(*) 
    INTO rowcount
    FROM WorkCenterStats;
    
    IF rowcount > 0 THEN
        UPDATE WorkCenterStats
        SET totalCapacity = totalCapacity + new.capacity;
    ELSE
        INSERT INTO WorkCenterStats(totalCapacity)
        VALUES(new.capacity);
    END IF; 
END

-- after insert
CREATE TRIGGER after_members_insert
AFTER INSERT
ON members FOR EACH ROW
BEGIN
    IF NEW.birthDate IS NULL THEN
        INSERT INTO reminders(memberId, message)
        VALUES(new.id,CONCAT('Hi ', NEW.name, ', please update your date of birth.'));
    END IF;
END

-- before update trigger
CREATE TRIGGER before_sales_update
BEFORE UPDATE
ON sales FOR EACH ROW
BEGIN
    DECLARE errorMessage VARCHAR(255);
    SET errorMessage = CONCAT('The new quantity ',
                        NEW.quantity,
                        ' cannot be 3 times greater than the current quantity ',
                        OLD.quantity);
                        
    IF new.quantity > old.quantity * 3 THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = errorMessage;
    END IF;
END

-- after update trigger
CREATE TRIGGER after_sales_update
AFTER UPDATE
ON sales FOR EACH ROW
BEGIN
    IF OLD.quantity <> new.quantity THEN
        INSERT INTO SalesChanges(salesId,beforeQuantity, afterQuantity)
        VALUES(old.id, old.quantity, new.quantity);
    END IF;
END

-- before delete trigger
CREATE TRIGGER before_salaries_delete
BEFORE DELETE
ON salaries FOR EACH ROW
BEGIN
    INSERT INTO SalaryArchives(employeeNumber,validFrom,amount)
    VALUES(OLD.employeeNumber,OLD.validFrom,OLD.amount);
END

-- after delete trigger
CREATE TRIGGER after_salaries_delete
AFTER DELETE
ON Salaries FOR EACH ROW
UPDATE SalaryBudgets 
SET total = total - old.salary
```

### Multiple triggers for same event and time

e.g. multiple UPDATE AFTER triggers

```sql
CREATE TRIGGER trigger_name
{BEFORE|AFTER}{INSERT|UPDATE|DELETE} 
ON table_name FOR EACH ROW 
{FOLLOWS|PRECEDES} existing_trigger_name
BEGIN
    -- statements
END

-- first trigger
CREATE TRIGGER before_products_update 
   BEFORE UPDATE ON products 
   FOR EACH ROW 
BEGIN
     IF OLD.msrp <> NEW.msrp THEN
         INSERT INTO PriceLOgs(product_code,price)
         VALUES(old.productCode,old.msrp);
     END IF;
END

-- second trigger on same action
CREATE TRIGGER before_products_update_log_user
   BEFORE UPDATE ON products 
   FOR EACH ROW 
   FOLLOWS before_products_update
BEGIN
    IF OLD.msrp <> NEW.msrp THEN
	INSERT INTO 
            UserChangeLogs(productCode,updatedBy)
        VALUES
            (OLD.productCode,USER());
    END IF;
END
```

### call proc from trigger

The trigger cannot call:

- a stored procedure that has OUT or INOUT parameters or
- a stored procedure that uses dynamic SQL

```sql
CREATE PROCEDURE Withdraw(
    fromAccountId INT, 
    withdrawAmount DEC(10,2)
)
BEGIN
    IF withdrawAmount <= 0 THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'The withdrawal amount must be greater than zero';
    END IF;
    
    UPDATE accounts 
    SET amount = amount - withdrawAmount
    WHERE accountId = fromAccountId;
END

CREATE PROCEDURE CheckWithdrawal(
    fromAccountId INT,
    withdrawAmount DEC(10,2)
)
BEGIN
    DECLARE balance DEC(10,2);
    DECLARE withdrawableAmount DEC(10,2);
    DECLARE message VARCHAR(255);

    -- get current balance of the account
    SELECT amount 
    INTO balance
    FROM accounts
    WHERE accountId = fromAccountId;
    
    -- Set minimum balance
    SET withdrawableAmount = balance - 25;

    IF withdrawAmount > withdrawableAmount THEN
        SET message = CONCAT('Insufficient amount, the maximum withdrawable is ', withdrawableAmount);
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = message;
    END IF;
END

CREATE TRIGGER before_accounts_update
BEFORE UPDATE
ON accounts FOR EACH ROW
BEGIN
    CALL CheckWithdrawal (
        OLD.accountId, 
        OLD.amount - NEW.amount
    );
END


SHOW TRIGGERS
FROM classicmodels
WHERE table = 'employees';
```

### scheduled events

MySQL Events are tasks that execute according to a specified schedule. Therefore, sometimes MySQL events are referred to as scheduled events.

MySQL Events are named object which contains one or more SQL statement. They are stored in the database and executed at one or more intervals.

For example, you can create an event that optimizes all tables in the database that runs at 1:00 AM every Sunday.

MySQL Events are also known as __**“temporal triggers”**__ because they are triggered by time, not by DML events like normal triggers. MySQL events are similar to a cronjob on Linux or a task scheduler on Windows.

MySQL Event Scheduler manages the schedule and execution of Events.

MySQL Events can be very useful in many cases such as optimizing database tables, cleaning up logs, archiving data, or generating complex reports during off-peak time.

MySQL uses a special thread called event scheduler thread to execute all scheduled events. You can view the status of the event scheduler thread by executing the SHOW PROCESSLIST command:

```sql
CREATE EVENT [IF NOT EXIST] event_name
ON SCHEDULE schedule
DO
event_body

-- schedule examples
1. AT timestamp [+ INTERVAL]
2. EVERY interval STARTS timestamp [+INTERVAL] ENDS timestamp [+INTERVAL]

CREATE EVENT IF NOT EXISTS test_event_01
ON SCHEDULE AT CURRENT_TIMESTAMP
DO
  INSERT INTO messages(message,created_at)
  VALUES('Test MySQL Event 1',NOW());


-- preserve event after expired
CREATE EVENT test_event_02
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
ON COMPLETION PRESERVE
DO
   INSERT INTO messages(message,created_at)
   VALUES('Test MySQL Event 2',NOW());

SHOW EVENTS


```

