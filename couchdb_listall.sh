#!/bin/bash

. couchdb_scripts_defaults.conf
. couchdb_functions


dbs="`get_dbs $URL`"
#dbs='tickets'  # for debugging

for db in $dbs
do
  $CURL -X GET "${URL}/${db}"
done
