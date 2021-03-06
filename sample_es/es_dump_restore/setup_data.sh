#!/bin/bash
# download dataset
wget https://download.elastic.co/demos/kibana/gettingstarted/shakespeare_6.0.json

# create index
curl -X PUT "localhost:9200/shakespeare?pretty" -H 'Content-Type: application/json' -d'
{
 "mappings": {
  "doc": {
   "properties": {
    "speaker": {"type": "keyword"},
    "play_name": {"type": "keyword"},
    "line_id": {"type": "integer"},
    "speech_number": {"type": "integer"}
   }
  }
 }
}
'

# load the dataset
curl -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9200/shakespeare/doc/_bulk?pretty' --data-binary @shakespeare_6.0.json
curl -XGET "localhost:9200/_cat/indices?v&pretty"

# delete the dataset
rm shakespeare_6.0.json

echo "setup done"
