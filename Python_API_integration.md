# Python API integration

## Rest API

Rest uses HTTP for comms with web services

- stateless, so session state stored on client side
- client server so client does UI, server does data storage, independent
- cacheable, so clients can cache server responses to speed up
- like a datasource on the internet

general integration Steps

1. get API key: Generally register and get a key. Add API key to each request for identity.
2. Test (can do directly on the rapid api page)
3. write app.

## Http request methods

Get: select. retrieve info, most common.
Post: insert. add new data to the server
Put: update existing info.
Delete

## Endpoints

A specific address where you get certain data. Name corresponds to the function generally.
RapidAPI service is an API hub marketplace providing thousands of APIs. https://rapidapi.com/
Endpoint e.g. https://rapidapi.com/alexnormand/api/dino-ipsum

## Python libraries

Python 2: unirest
Python 3: requests library is the de facto standard. httpclient is another.

## request library

Response is a powerful object for inspecting results

- headers and contents
- dictionary with JSON response
- response status

```python
import requests
response = requests.get('https://google.com/')
print(response)
>> <Response [200]>
```

### main methods

```python
r = requests.get('https://api.github.com/events')
r = requests.post('https://httpbin.org/post', data = {'key':'value'})
r = requests.put('https://httpbin.org/put', data = {'key':'value'})
r = requests.delete('https://httpbin.org/delete')
r = requests.head('https://httpbin.org/get')
r = requests.options('https://httpbin.org/get')
```

### passing parameters in request

Genreally, parameers given as key/value pairs in the URL after a question mark, e.g. httpbin.org/get?key=val.

Requests allows dictionary of strings with `params` keyword

```python
payload = {'key1': 'value1', 'key2': 'value2'}
r = requests.get('https://httpbin.org/get', params=payload)

print(r.url)
>>> https://httpbin.org/get?key2=value2&key1=value1

# also pass a list of strings by value
payload = {'key1': 'value1', 'key2': ['value2', 'value3']}
r = requests.get('https://httpbin.org/get', params=payload)
print(r.url)
>>> https://httpbin.org/get?key1=value1&key2=value2&key2=value3
```

### Response object

get returns response in text attribute.
r.text
automatically decoded, or set teh response.encoding param. 

binary content in r.content attribute

```python
# text example
t = r.text

# binary example
from PIL import Image
from io import BytesIO
i = Image.open(BytesIO(r.content))

# JSON example, built in decoder
import requests
r = requests.get('https://api.github.com/events')
r.json()
>>> [{'repository': {'open_issues': 0, 'url': 'https://github.com/...

# raw content
r.raw
```

### more complex requests

```python
payload = {'key1': 'value1', 'key2': 'value2'}

r = requests.post("https://httpbin.org/post", data=payload)
print(r.text)
{
  ...
  "form": {
    "key2": "value2",
    "key1": "value1"
  },
  ...
}
```

### status codes

- 200: ok
- 204: success but No content
- 301: moved permanently to this address
- 400: Bad request
- 401: Unauthorized
- 403: forbidden
- 404: not found
- 500: server error

>print(response.status_code)

also get cookies, response headers etc.

### sessions

Allows you to persist parameters across requests. 
Persists cookies across all requests in teh session
use connection pooling which is faster than getting a new connection each call.

```python
# to persist cokokies across requests:
s = requests.Session()

s.get('https://httpbin.org/cookies/set/sessioncookie/123456789')
r = s.get('https://httpbin.org/cookies')

print(r.text)
# '{"cookies": {"sessioncookie": "123456789"}}'


# Sessions can also be used to provide default data to the request methods. This is done by providing data to the properties on a Session object:
s = requests.Session()
s.auth = ('user', 'pass')
s.headers.update({'x-test': 'true'})

# both 'x-test' and 'x-test2' are sent
s.get('https://httpbin.org/headers', headers={'x-test2': 'true'})
```


