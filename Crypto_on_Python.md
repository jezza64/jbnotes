# Crypto on Python

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

