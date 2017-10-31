#!/bin/bash

QUERY=$1

curl -XGET 'localhost:9200/task1a/_search?pretty' -H 'Content-Type: application/json' -d'
{
  "query": {
    "bool": {
      "should": [
        { 
            "match": { 
                "title": "'$QUERY'"
            }
        },
        {
            "match": { 
                "abstract": "'$QUERY'"
            }
        }
      ]
    }
  }
}
'
