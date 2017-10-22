#!bin/bash

# In case you use the provided ParseJSON.java code for preprocessing the wikipedia dataset,
# uncomment the following two commands to compile and execute your modified code in this script.
#
javac ParseJSON.java
java ParseJSON

# TASK 2A:
# Create and index the documents using the default standard analyzer
curl -H "Content-Type: application/json" -XPOST 'localhost:9200/task2a/wikipage/_bulk?pretty&refresh' --data-binary "@data/out.txt"



# TASK 2B:
# Create and index with a whitespace analyzer
curl -XPUT 'localhost:9200/task2b?pretty' -H 'Content-Type: application/json' -d'
{
  "mappings": {
    "wikipage" : {
      "_all" : {"type": "string", "analyzer": "whitespace"},
      "properties" : {
        "abstract" : {
          "type" :    "string",
          "analyzer": "whitespace"
        },
        "url" : {
          "type" :   "string",
          "analyzer": "whitespace"
        },
        "title" : {
          "type" :   "string",
          "analyzer": "whitespace"
        },
        "sections" : {
          "type" :   "string",
          "analyzer": "whitespace"
        }
      }
    }
  }
}
'

curl -H "Content-Type: application/json" -XPOST 'localhost:9200/task2b/wikipage/_bulk?pretty&refresh' --data-binary "@data/out.txt"


# TASK 2C:
# Create and index with a custom analyzer as specified in Task 2C
