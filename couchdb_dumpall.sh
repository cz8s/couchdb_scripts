#!/bin/bash

# dump_db() and restore_db() rely on python-couchdb package, 
# python-couchdb =< 0.8-1 needs to be patched, see
# http://code.google.com/p/couchdb-python/issues/detail?id=194 

. couchdb-scripts-defaults.conf
. couchdb_functions

# create backupdir
[ -d $DUMPDIR ] || mkdir $DUMPDIR

dbs="`get_dbs $URL`"
#dbs='tickets'  # for debugging

for db in $dbs
do
  dump_db ${URL} $db $user $pw

done
