#!/bin/bash

. couchdb-scripts-defaults.conf
. couchdb_functions

# create backupdir
[ -d $DUMPDIR ] || mkdir $DUMPDIR

dbs="`get_dbs $URL`"

for db in $dbs
do
  dump_db_to_file ${URL} $db 
done
