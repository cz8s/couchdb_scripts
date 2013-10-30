#!/bin/bash

. couchdb_scripts_defaults.conf
. couchdb_functions


dbs="`get_dbs $URL`"

for db in $dbs
do
  $CURL -X DELETE "${URL}/${db}"
done
