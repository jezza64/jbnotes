# Python API integration

## Rest API

Rest uses HTTP for comms with web services

- Representational state transfer.
- stateless, so session state stored on client side
- client server so client does UI, server does data storage, independent
- cacheable, so clients can cache server responses to speed up
- like a datasource on the internet

general integration Steps

1. get API key: Generally register and get a key. Add API key to each request for identity.
2. Test (can do directly on the rapid api page)
3. write app.

(newer: GraphQL. Created by Facebook, GraphQL is a very flexible query language for APIs, where the clients decide exactly what they want to fetch from the server instead of the server deciding what to send.)

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

Use to limit data retrieved.

Generally, parameters given as key/value pairs in the URL after the end point and a question mark, e.g. https://httpbin.org/get?key=val. To add a query parameter to a given URL, you have to add a question mark (?) before the first query parameter. If you want to have multiple query parameters in your request, then you can split them with an ampersand (&).

```python
# random users api
>>> requests.get("https://randomuser.me/api/").json()
{'results': [{'gender': 'male', 'name':
{'title': 'Mr', 'first': 'Silvijn', 'last': 'Van Bekkum'},
'location': {'street': {'number': 2480, 'name': 'Hooijengastrjitte'},
'city': 'Terherne', 'state': 'Drenthe',
'country': 'Netherlands', 'postcode': 59904...}

# add params for gender and nation
>>> requests.get("https://randomuser.me/api/?gender=female&nat=de").json()
{'results': [{'gender': 'female', 'name':
{'title': 'Ms', 'first': 'Marita', 'last': 'Hertwig'},
'location': {'street': {'number': 1430, 'name': 'Waldstraße'},
'city': 'Velden', 'state': 'Rheinland-Pfalz',
'country': 'Germany', 'postcode': 30737...}

# To avoid having to rebuild the URL over and over again, you can use the params attribute to send in a dictionary of all query parameters to append to a URL:

>>> query_params = {"gender": "female", "nat": "de"}
>>> requests.get("https://randomuser.me/api/", params=query_params).json()
{'results': [{'gender': 'female', 'name':
{'title': 'Ms', 'first': 'Janet', 'last': 'Weyer'},
'location': {'street': {'number': 2582, 'name': 'Meisenweg'},
'city': 'Garding', 'state': 'Mecklenburg-Vorpommern',
'country': 'Germany', 'postcode': 56953...}
```

Requests allows dictionary of strings with `params` keyword

```python
# set up a dict with the filters to apply in the api
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

custom headers normally defined with X-...
see in response.request.headers

### Response object

get returns response in text attribute: r.text  
automatically decoded, or set the response.encoding param.  
binary content in r.content attribute
The Content-type header has this info.

```python
# text example
t = r.text

>>> response = requests.get("https://api.thedogapi.com/v1/breeds/1")
>>> response.headers.get("Content-Type")
'application/json; charset=utf-8'
>>> response.content
b'{"weight":{"imperial":"6 - 13","metric":"3 - 6"}...'


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

# handling e.g. json
>>> response = requests.get("https://api.thedogapi.com/v1/breeds/1")
>>> response.headers.get("Content-Type")
'application/json; charset=utf-8'
>>> response.json()
{'weight': {'imperial': '6 - 13', 'metric': '3 - 6'},
'height': {'imperial': '9 - 11.5', 'metric': '23 - 29'}
...}
>>> response.json()["name"]
'Affenpinscher'

# handling image
>>> response = requests.get("http://placegoat.com/200/200")
>>> response
<Response [200]>
>>> response.headers.get("Content-Type")
'image/jpeg'
>>> file = open("goat.jpeg", "wb")
>>> file.write(response.content)
>>> file.close()
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

### authentication

API keys are easy, OAuth is harder.

### API keys

Typically sent as request header or parameter  
Identify you as a user.

#### OAuth

generally comes on web sites with "continue with... " or "open with" google, facebook etc

Here’s a step-by-step breakdown of what will happen if you click Continue With Facebook:

1. The Spotify app will ask the Facebook API to start an authentication flow. To do this, the Spotify app will send its application ID (client_id) and a URL (redirect_uri) to redirect the user after success or error.
2. You’ll be redirected to the Facebook website and asked to log in with your credentials. The Spotify app won’t see or have access to these credentials. This is the most important benefit of OAuth.
3. Facebook will show you all the data the Spotify app is requesting from your profile and ask you to accept or reject sharing that data.
4. If you accept giving Spotify access to your data, then you’ll be redirected back to the Spotify app, already logged in.

When going through step 4, Facebook will provide Spotify with a special credential (access_token) that can be used repeatedly to fetch your information. This specific Facebook login token is valid for sixty days, but other apps might have different expiration periods. If you’re curious, then Facebook has a settings page that you can check to see which apps have been given your Facebook access token.

Now, from a more technical standpoint, here are the things you need to know when consuming APIs using OAuth:

1. You need to create an application that will have an ID (app_id or client_id) and a secret (app_secret or client_secret).
2. You need to have a redirect URL (redirect_uri), which the API will use to send information to you.
3. You’ll get a code as the result of the authentication, which you need to exchange for an access token.

There are a few variations to the above, but generally speaking, most OAuth flows will have steps similar to these.

Tip: When you’re just testing things out and you need some sort of redirect URL to get a code, you can use a service called httpbin.

More specifically, you can use https://httpbin.org/anything as a redirect URL, as it’ll simply output whatever it gets as an input. You can test it yourself by navigating to that URL.

More details on https://realpython.com/python-api/
