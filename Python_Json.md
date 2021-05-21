# Python Json

- [Python Json](#python-json)
  - [basics](#basics)

## basics

- JSON (javascript object notation)
- Good for storing and exchanging structured data
- XML and YAML are alternates
- Good for API transfer, or storing in a document database.
- Good for machines and humans

```json
{
    "firstName": "Jane",
    "lastName": "Doe",
    "hobbies": ["running", "sky diving", "singing"],
    "age": 35,
    "children": [
        {
            "firstName": "Alice",
            "age": 6
        },
        {
            "firstName": "Bob",
            "age": 8
        }
    ]
}
```

supports primitive types (strings, numbers) and nested lists, objects.


encoding to JSON is called serialization, before store or send over network  
encoding is writing objects to serialized
decoding is reading serialized to memory structures  
mapping of datatypes, may not get back exactly what you send  

dump(): writes JSON to files
dumps(): writes JSON to string
load(): reads JSON into python objects

```python
import json
import requests

response = requests.get("https://jsonplaceholder.typicode.com/todos")
# load into memory
todos1 = json.loads(response.text)
todos2 = response.json() // easier version

```
