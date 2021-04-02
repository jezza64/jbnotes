# Python Json

JSON (javascript object notation)
Good for storing and exchanging structured data
XML and YAML are alternates
Good for API transfer, or storing in a document database. 
Good for machines and humans

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

import json: library

encoding to JSON is serialization.
dump(): writes JSON to files
dumps() writes JSON to string

