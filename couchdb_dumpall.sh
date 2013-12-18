#!/bin/bash

. couchdb_scripts_defaults.conf
. couchdb_functions

echo "excluding $EXCLUDE_DBS"

# remove old content and create fresh backupdir
[ -d $DUMPDIR ] && rm -rf $DUMPDIR
mkdir $DUMPDIR

dbs="`get_dbs $URL`"

for db in $dbs
do
  # check if db is in the list of DBs to be excluded
  [[ " $EXCLUDE_DBS " == *\ $db\ * ]] || dump_db_to_file ${URL} $db 
done
