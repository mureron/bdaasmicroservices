#!/usr/bin/env bash

URL=$1 # IP_ELASTIC:PORT
INDEX="quijote"

# Create mapping type
curl -XPUT "$URL/$INDEX?pretty" -H 'Content-Type: application/json' -d'
{
  "mappings": {
    "doc": { 
      "properties": { 
        "message": {"type": "text"},  
        "timestamp": {"type": "date"}
      }
    }
  }
}'

IFS=$'\n'
for l in $(cat data/quijote.txt)
do
    echo "$l"
    DATA="{\"timestamp\": \"$(date -u '+%FT%T')\",\"message\": \"$l\"}"
    echo $DATA
    curl -XPOST "$URL/$INDEX/doc?" -H 'Content-Type: application/json' -d"$DATA" 
    sleep 1
done