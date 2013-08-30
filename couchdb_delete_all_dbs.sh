#!/bin/bash

. couchdb-scripts-defaults.conf
. couchdb_functions


dbs="`get_dbs $URL`"
#dbs='tickets'  # for debugging

for db in $dbs
do
  $CURL -X DELETE "${URL}/${db}"
done
