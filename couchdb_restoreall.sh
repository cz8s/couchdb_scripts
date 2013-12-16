#!/bin/bash

. couchdb_scripts_defaults.conf
. couchdb_functions

#dumpdir=/tmp/restore  # only for debugging
[ -z $dumpdir ] && dumpdir='/var/backups/couchdb'

dbs=`find $dumpdir -type f '!' -name '*_security'`

for db in $dbs
do
  db_name=`basename $db`

  if [[ " $EXCLUDE_DBS " == *\ $db_name\ * ]]
  then 
    echo "NOT restoring $db_name, cause it is in the list of excluded DBs"
  else
    echo "Restoring $db_name"
    restore_db ${URL} $db_name $dumpdir
  fi
  echo
done
