# Crypto on Python

- [Crypto on Python](#crypto-on-python)
  - [Google sheet pricing functions](#google-sheet-pricing-functions)
  - [HMAC](#hmac)
  - [example api](#example-api)
  - [Crypto SQL data sets](#crypto-sql-data-sets)

## Google sheet pricing functions

https://medium.com/coinmonks/how-to-value-your-stocks-crypto-portfolio-in-google-sheets-22bb7b42c39d

## HMAC

HMAC is an algorithm that generates a hash of the message using a cryptographic hash function and a secret cryptographic key.

It can be used to check data for integrity and authenticity. It lets us calculate message authenticity and integrity using a shared key between two parties without the use of complex public key infrastructure involving certificates.

hashlib library has hmac module.

```python
import hashlib

print("List of Available Algorithms to Construct Secure Hash/Message Digest : {}".format(hashlib.algorithms_available))
print("\nList of Algorithms Guaranteed to Work : {}".format(hashlib.algorithms_guaranteed))
print("\nList of Algorithms that May Work : {}".format(hashlib.algorithms_available.difference(hashlib.algorithms_guaranteed)))

# Generate message authentication code based on input key
import hmac
message = "Welcome to JB."
key= "abracadabra"
hmac1 = hmac.new(key=key.encode(), msg=message.encode(), digestmod=hashlib.sha256)
message_digest1 = hmac1.digest()

print("{} - Message Digest 1 : {}".format(hmac1.name, message_digest1))
```

## example api

https://python-binance.readthedocs.io/en/latest/_modules/binance/client.html


## Crypto SQL data sets

SQL query against a public dataset of Ethereum node data such as Google BigQuery's bigquery-public-data.crypto_ethereum.transactions dataset.

```sql
DECLARE halfway int64;
DECLARE block_count int64;
DECLARE max_block int64;

-- Querying for the amount of blocks in the preset time range. This will allow block_count to be compared against a given minimum block amount.
SET (block_count, max_block) = (SELECT AS STRUCT (MAX(number) - MIN(number)), MAX(number) FROM `bigquery-public-data.crypto_ethereum.blocks` WHERE timestamp BETWEEN TIMESTAMP(@t2) AND TIMESTAMP(@t1));

CREATE TEMP TABLE cum_gas (
  gas_price int64,
  cum_sum int64
);

-- If the minimum threshold of blocks is met, query on a time range
IF block_count >= @B THEN
INSERT INTO cum_gas (
  SELECT
    gas_price,
    SUM(gas_used) OVER (ORDER BY gas_price) AS cum_sum
  FROM (
    SELECT
      gas_price,
      SUM(receipt_gas_used) AS gas_used
    FROM
      `bigquery-public-data.crypto_ethereum.transactions`
    WHERE block_timestamp 
    BETWEEN TIMESTAMP(@t2)
    AND TIMESTAMP(@t1)  
    GROUP BY
      gas_price));
ELSE -- If a minimum threshold of blocks is not met, query for the minimum amount of blocks
INSERT INTO cum_gas (
  SELECT
    gas_price,
    SUM(gas_used) OVER (ORDER BY gas_price) AS cum_sum
  FROM (
    SELECT
      gas_price,
      SUM(receipt_gas_used) AS gas_used
    FROM
      `bigquery-public-data.crypto_ethereum.transactions`
    WHERE block_number 
    BETWEEN (max_block - @B)
    AND max_block
    GROUP BY
      gas_price));
END IF;

SET halfway = (SELECT DIV(MAX(cum_sum),2) FROM cum_gas);

SELECT cum_sum, gas_price FROM cum_gas WHERE cum_sum > halfway ORDER BY gas_price LIMIT 1;```

