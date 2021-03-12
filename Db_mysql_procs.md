# Mysql Stored Procedures

## Basics

- precompiled SQL
- Compiled when first run and plan stored in cache
- pass parameters
- control flow statements
- call other procs
- modularize code

```sql
DELIMITER $$

CREATE PROCEDURE GetCustomers()
BEGIN
	SELECT 
		customerName, 
		city, 
		state, 
		postalCode, 
		country
	FROM
		customers
	ORDER BY customerName;    
END$$
DELIMITER ;

call GetCustomers();

```

### Advantages / problems

- network traffic reduced
- centalize business logic
- security
- **No debugger available in MySQL like in other products**

### delimiter

- ; is default delimiter in most clients to separate statements and execute each separately
- ; needed to separate statements in proc
- so redefine the delimiter temporarily
- ```DELIMITER $$```
- change delimiter to $$, and use ; in procs, then change back after compile.
- delimiter statements not part of proc definition

## Create

```sql
CREATE PROCEDURE procedure_name(parameter_list)
BEGIN
   statements;
END //

CALL stored_procedure_name(argument_list);

-- Note that you must have the ALTER ROUTINE privilege for the stored procedure to remove it.
DROP procedure IF EXISTS `j1`;

-- IF EXISTS changes error to warning


```

## Parameters

- In MySQL, a parameter has one of three modes: IN,OUT, or INOUT.
- IN: default. mandatory, protected. 
- OUT: can be changed in side the proc. Can't set an initial value outside.
- INOUT: pass to proc and change inside proc.

```sql
-- parameter definition
[IN | OUT | INOUT] parameter_name datatype[(length)]

-- OUT example
CREATE PROCEDURE GetOrderCountByStatus (
	IN  orderStatus VARCHAR(25),
	OUT total INT
)
BEGIN
	SELECT COUNT(orderNumber)
	INTO total
	FROM orders
	WHERE status = orderStatus;
END$$

CALL GetOrderCountByStatus('Shipped',@total);
SELECT @total;

-- INOUT example
CREATE PROCEDURE SetCounter(
	INOUT counter INT,
    IN inc INT
)
BEGIN
	SET counter = counter + inc;
END$$

SET @counter = 1;
CALL SetCounter(@counter,1); -- 2
CALL SetCounter(@counter,1); -- 3
CALL SetCounter(@counter,5); -- 8
SELECT @counter; -- 8
```

## Variables in procs

- scope is inside proc
- scope is inside BEGIN / END
- MySQL allows you to declare two or more variables that share the same name in different scopes. But not good practice
- variables only usable in a stored proc or stored function
- use SET to set value directly, or SELECT .. INTO var 

```sql
DECLARE variable_name datatype(size) [DEFAULT default_value];
DECLARE totalSale DEC(10,2) DEFAULT 0.0;
-- do 2 at once
DECLARE x, y INT DEFAULT 0;

-- assign with SET or SELECT INTO from a query
SET variable_name = value;

DECLARE productCount INT DEFAULT 0;

SET productCount = 3;

SELECT COUNT(*) 
INTO productCount
FROM products;

-- in a proc
DELIMITER $$

CREATE PROCEDURE GetTotalOrder()
BEGIN
	DECLARE totalOrder INT DEFAULT 0;
    
    SELECT COUNT(*) 
    INTO totalOrder
    FROM orders;
    
    SELECT totalOrder;
END$$

DELIMITER ;
```

## Listing procs

lists definer, datetime, comment etc

```sql
SHOW PROCEDURE STATUS [LIKE 'pattern' | WHERE search_condition];
-- for all 
SHOW PROCEDURE STATUS;
SHOW PROCEDURE STATUS WHERE db = 'classicmodels';
SHOW PROCEDURE STATUS LIKE '%Order%'

-- system tables query
SELECT  routine_name
FROM    information_schema.routines
WHERE   routine_type = 'PROCEDURE'
AND     routine_schema = '<database_name>';
```

## IF and CASE

MySQL also does not allow you to have empty statements in the THEN or ELSE clause. If you don’t want to handle the logic in the ELSE clause while preventing MySQL from raising an error in case no search_condition is true, you can use an empty BEGIN END  block in the ELSE clause.

error on CASE if no match and no else

IF-ELSE vs CASE is personal preference

```sql
-- IF THEM
IF condition THEN 
   statements;
END IF;

-- IF THEN ELSE
IF condition THEN
   statements;
ELSE
   else-statements;
END IF;

-- IF THEN ELSEIF THEN ELSE
IF condition THEN
   statements;
ELSEIF elseif-condition THEN
   elseif-statements;
...
ELSE
   else-statements;
END IF;

-- CASE
CASE case_value
   WHEN when_value1 THEN statements
   WHEN when_value2 THEN statements
   ...
   [ELSE else-statements]
END CASE;

-- searched case, for complex matches like ranges
CASE
    WHEN search_condition1 THEN statements
    WHEN search_condition1 THEN statements
    ...
    [ELSE else-statements]
END CASE;

-- search case example
    CASE 
		WHEN waitingDay = 0 THEN 
			SET pDeliveryStatus = 'On Time';
        WHEN waitingDay >= 1 AND waitingDay < 5 THEN
			SET pDeliveryStatus = 'Late';
		WHEN waitingDay >= 5 THEN
			SET pDeliveryStatus = 'Very Late';
		ELSE
			SET pDeliveryStatus = 'No Information';
	END CASE;	
```

## Loops

```sql
-- labels are optional 
[begin_label:] LOOP
    statement_list

    IF condition THEN
        -- immediate exit
        LEAVE [label];
    END IF;

    IF condition THEN
        -- like continue, go to next iteration
        ITERATE [label];
    END IF;

END LOOP [end_label]

-- example
DROP PROCEDURE LoopDemo;

DELIMITER $$
CREATE PROCEDURE LoopDemo()
BEGIN
	DECLARE x  INT;
	DECLARE str  VARCHAR(255);
        
	SET x = 1;
	SET str =  '';
        
	loop_label:  LOOP
		IF  x > 10 THEN 
			LEAVE  loop_label;
		END  IF;
            
		SET  x = x + 1;
		IF  (x mod 2) THEN
			ITERATE  loop_label;
		ELSE
			SET  str = CONCAT(str,x,',');
		END  IF;
	END LOOP;
	SELECT str;
END$$

DELIMITER ;

-- While
[begin_label:] WHILE search_condition DO
    statement_list
END WHILE [end_label]

-- repeat: repeat until search condition is true
-- always runs at least once
[begin_label:] REPEAT
    statement
UNTIL search_condition
END REPEAT [end_label]

-- LEAVE to exit
LEAVE label;

-- exit an SP with LEAVE, works if Leave with the outermost label.
CREATE PROCEDURE sp_name()
sp: BEGIN
    IF condition THEN
        LEAVE sp;
    END IF;
    -- other statement
END

-- The LEAVE causes the current loop specified by the label to be terminated. If a loop is enclosed within another loop, you can break out of both loops with a single LEAVE statement.
```

## Cursors

- handle a result set inside a proc
- read only
- non scrollable (only read in the order of the statement, no jumping)
- asensitive. (directly uses the underlying data, so takes locks)
- use in procs, triggers, stored functions

```sql
DELIMITER $$
CREATE PROCEDURE createEmailList (
	INOUT emailList varchar(4000)
)
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
	DECLARE emailAddress varchar(100) DEFAULT "";

	-- declare cursor for employee email
	DEClARE curEmail 
		CURSOR FOR 
			SELECT email FROM employees;

	-- declare NOT FOUND handler
	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;

	OPEN curEmail;

	getEmail: LOOP
		FETCH curEmail INTO emailAddress;
		IF finished = 1 THEN 
			LEAVE getEmail;
		END IF;
		-- build email list
		SET emailList = CONCAT(emailAddress,";",emailList);
	END LOOP getEmail;
	CLOSE curEmail;

END$$
DELIMITER ;
```

## Error handling

- Use HANDLER to handle errors and warnings, exit or continue.
- `DECLARE action HANDLER FOR condition_value statement;`
- action is CONTINUE or EXIT
- Condition value:
  - error code
  - SQLSTATE value (SQLWARNING, SQLERROR, SQLEXCEPTION)
  - named condition

In case you have multiple handlers that handle the same error, MySQL will call the most specific handler to handle the error first based on the following rules:

### handler precedence

- An error always maps to a MySQL error code because in MySQL it is the most specific.
- An SQLSTATE may map to many MySQL error codes, therefore, it is less specific.
- An SQLEXCEPTION or an SQLWARNING is the shorthand for a class of SQLSTATES values so it is the most generic.
- Based on the handler precedence rules,  MySQL error code handler, SQLSTATE handler and SQLEXCEPTION takes the first, second and third precedence.

### handler examples

```sql
-- proc exit on error
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
    ROLLBACK;
    SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
END;

-- continue when not found
DECLARE CONTINUE HANDLER FOR NOT FOUND 
SET RowNotFound = 1;

-- duplicate key error
DECLARE CONTINUE HANDLER FOR 1062
SELECT 'Error, duplicate key occurred';


-- example in proc
CREATE PROCEDURE InsertSupplierProduct(
    IN inSupplierId INT, 
    IN inProductId INT
)
BEGIN
    -- exit if the duplicate key occurs
    DECLARE EXIT HANDLER FOR 1062
    BEGIN
 	SELECT CONCAT('Duplicate key (',inSupplierId,',',inProductId,') occurred') AS message;
    END;
    
    -- insert a new row into the SupplierProducts
    INSERT INTO SupplierProducts(supplierId,productId)
    VALUES(inSupplierId,inProductId);
    
    -- return the products supplied by the supplier id
    SELECT COUNT(*) 
    FROM SupplierProducts
    WHERE supplierId = inSupplierId;
    
END$$

DELIMITER ;


-- named error handler
-- can specify an error number but this is messy
CREATE PROCEDURE TestProc()
BEGIN

    DECLARE EXIT HANDLER FOR 1146 
    SELECT 'Please create table abc first' Message; 
        
    SELECT * FROM abc;
END$$

-- Better to use a named error condition
CREATE PROCEDURE TestProc()
BEGIN
    DECLARE TableNotFound CONDITION for 1146 ; 

    DECLARE EXIT HANDLER FOR TableNotFound 
	SELECT 'Please create table abc first' Message; 
    SELECT * FROM abc;
END$$
```

## SIGNAL statement

- use SIGNAL and RESIGNAL to raise errors in a proc back to the caller.
- Return info with SET, name value pairs.
- Use RESIGNAL if in a handler, or SIGNAL normally.
- Set can return MESSAGE_TEXT, MYSQL_ERRORNO etc

```sql
SIGNAL SQLSTATE | condition_name;
SET condition_information_item_name_1 = value_1,
    condition_information_item_name_1 = value_2, etc;


-- example, raise a simple error
-- 45000 is a general error state for user defined errors 
CREATE PROCEDURE AddOrderItem(
		     in orderNo int,
			 in productCode varchar(45),
			 in qty int, 
             in price double, 
             in lineNo int )
BEGIN
	DECLARE C INT;

	SELECT COUNT(orderNumber) INTO C
	FROM orders 
	WHERE orderNumber = orderNo;

	-- check if orderNumber exists
	IF(C != 1) THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Order No not found in orders table';
	END IF;
	-- more code below
	-- ...
END

-- to change an error in a HANDLER, use RESIGNAL
CREATE PROCEDURE Divide(IN numerator INT, IN denominator INT, OUT result double)
BEGIN
	DECLARE division_by_zero CONDITION FOR SQLSTATE '22012';

	DECLARE CONTINUE HANDLER FOR division_by_zero 
	RESIGNAL SET MESSAGE_TEXT = 'Division by zero / Denominator cannot be zero';
	-- 
	IF denominator = 0 THEN
		SIGNAL division_by_zero;
	ELSE
		SET result := numerator / denominator;
	END IF;
END
```

## Stored Functions

Returns a single value. Like a user defined expression.
IN parameters only.
Non-deterministic by default, which means same input produces different answers. 

```sql
CREATE FUNCTION function_name(
    param1,
    param2,…
)
RETURNS datatype
[NOT] DETERMINISTIC
BEGIN
 -- statements
END $$

-- example
CREATE FUNCTION CustomerLevel(
	credit DECIMAL(10,2)
) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE customerLevel VARCHAR(20);

    IF credit > 50000 THEN
		SET customerLevel = 'PLATINUM';
    ELSEIF (credit >= 50000 AND 
			credit <= 10000) THEN
        SET customerLevel = 'GOLD';
    ELSEIF credit < 10000 THEN
        SET customerLevel = 'SILVER';
    END IF;
	-- return the customer level
	RETURN (customerLevel);
END;

-- calling function
SELECT 
    customerName, 
    CustomerLevel(creditLimit)
FROM
    customers
ORDER BY 
    customerName;

DROP FUNCTION [IF EXISTS] function_name;

-- listing
SHOW FUNCTION STATUS

SELECT 
    routine_name
FROM
    information_schema.routines
WHERE
    routine_type = 'FUNCTION'
        AND routine_schema = 'classicmodels';

```

## Stored object access control

- In MySQL, stored routines (stored procedures and functions), triggers, events, and views execute within a security context which determines their privileges.
- MySQL uses DEFINER and SQL SECURITY characteristics to control these privileges.
- When you define a stored routine such as a stored procedure or function, you can optionally specify the DEFINER attribute, which is the name of a MySQL account
  
```sql
CREATE [DEFINER=user] PROCEDURE spName(parameter_list)
```

- If you skip the DEFINER attribute, the default is the current user account.
- You can specify any account in the DEFINER attribute if you have the SUPER or SET_USER_ID privilege.
- As of MySQL 8.0.16, you must have the SYSTEM_USER privilege in order to set the DEFINER attribute for a stored object to a user account that has the SYSTEM_USER privilege.

Stored routines (stored procedures and functions) and views can include an SQL SECURITY clause with a value of DEFINER or INVOKER:

```sql
CREATE [DEFINER=user] PROCEDURE spName(parameter_list) SQL SECURITY [DEFINER | INVOKER]
```

When you use the SQL SECURITY DEFINER for a stored object, it will execute in definer security context with the privilege of the user specified in by the DEFINER attribute. In case the invoker has the least privilege and the definer has most privileges, the invoker can perform operations above its privilege within the stored object.

If you use the SQL SECURITY INVOKER for a stored routine or view, it will operate within the privileges of the invoker.

Code language: SQL (Structured Query Language) (sql)
In this stored procedure, the definer is root@localhost that is the superuser which has all privileges.

The SQL Security is set to the definer. It means that any user account which calls this stored procedure will execute with all privileges of the definer i.e., root@localhost user account.

```sql
-- example defining and running as high level user
CREATE DEFINER = root@localhost PROCEDURE InsertMessage( 
    msg VARCHAR(100)
)
SQL SECURITY DEFINER
BEGIN
    INSERT INTO messages(message)
    VALUES(msg);
END
```

## Show warnings and errors

if warnings or errors, display more detailed info with SHOW WARNINGS.

MySQL uses the max_error_count system variable to control the maximum number of warnings, errors and notes for that server can store.

The SHOW ERRORS is a diagnostic statement that displays information for errors.

```sql
-- warnings
SHOW WARNINGS;

-- to get count
SHOW COUNT(*) WARNINGS;
SELECT @@warning_count;

-- show max count parameter
SHOW VARIABLES LIKE 'max_error_count';

-- Errors
SHOW ERRORS [LIMIT [offset,] row_count];

SHOW COUNT(*) ERRORS;


```
