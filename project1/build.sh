#!/bin/bash

# In case you use the provided ParseJSON.java code for preprocessing the wikipedia dataset,
# uncomment the following two commands to compile and execute your modified code in this script.
#
echo 'compiling ParseJSON.java...'
javac ParseJSON.java
echo "Runing ParseJSON..."
java ParseJSON

# TASK 2A:
# Create and index the documents using the default standard analyzer
echo 'Task 2A...'
curl -H "Content-Type: application/json" -XPOST 'localhost:9200/task2a/wikipage/_bulk?pretty&refresh' --data-binary "@data/out.txt"



# TASK 2B:
# Create and index with a whitespace analyzer
echo 'Task 2B...'
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
echo 'Task 2C...'
curl -XPUT 'localhost:9200/task2c?pretty' -H 'Content-Type: application/json' -d'
{
    "settings": {
        "analysis": {
            "filter": {
                "my_stopwords": {
                    "type":       "stop",
                    "stopwords":  "_english_"
                },
                "my_snow": {
                    "type": "snowball",
                    "language": "English"
                }
            },
            "analyzer": {
                "my_analyzer": {
                    "type":         "custom",
                    "char_filter":  "html_strip",
                    "tokenizer":    "standard",
                    "filter":       [ "asciifolding", "lowercase", "my_stopwords", "my_snow" ]
            }}
}}}
'
curl -XPUT 'localhost:9200/task2c/_mapping/wikipage?pretty' -H 'Content-Type: application/json' -d'
{
    "_all" : {
        "type" : "string",
        "analyzer" : "my_analyzer"
    },
    "properties" : {
        "abstract" : {
            "type" : "string",
            "analyzer": "my_analyzer"
        },
        "url" : {
            "type" : "string",
            "analyzer": "my_analyzer"
        },
        "title" : {
            "type" : "string",
            "analyzer": "my_analyzer"
        },
        "sections" : {
            "type" : "string",
            "analyzer": "my_analyzer"
        }
    }
}
'

curl -H "Content-Type: application/json" -XPOST 'localhost:9200/task2c/wikipage/_bulk?pretty&refresh' --data-binary "@data/out.txt"
