#!/bin/bash

# script for recreating all dbs
# useful after a node gets added or removed from the cluster
# because there's no automatic rebalancing of bigcouch atm (2013/08)
# One workaround is to recreate all dbs and restore from a backup, 
# then all current cluster nodes get recognized
#
# For each db the following main steps are processed:
# 1. replicate db to tmp_db
# 2. delete db, create db
# 3. replicate tmp_db to db

# concurrent replication might cause stalled tasks, see #https://leap.se/code/issues/3506,
# so we use slower, sequential replication here

. couchdb-scripts-defaults.conf
. couchdb_functions


dbs="`get_dbs $URL`"
dbs='users_replicated'  # for debugging

# concurrent replication might cause stalled tasks, see #https://leap.se/code/issues/3506
for db in $dbs
do
  tmpdb="${TMPPREFIX}_${db}"

  echo -e "\n\n\nRecreating db $db\n------------------------------\n"

  # cleaning potential leftovers from past replications
  task="${db}_${tmpdb}"
  doc_exists $URL $db $task && ( echo -e "\nDeleting old backup replication task \"$task\" "; delete_doc ${BACKEND_URL} "_replicator" ${task} )
  doc_exists $URL $db ${tmpdb}_${db} && ( echo -e "\nDeleting old restore replication task \"${tmpdb}_${db}\" "; delete_doc ${BACKEND_URL} "_replicator" ${tmpdb}_${db} )   
  db_exists $URL $tmpdb && ( echo -e "\nDeleting old backup db $tmpdb"; delete_db $URL $tmpdb )

  # backup, delete, restore
  echo -e "\nReplicating $db to $tmpdb"
  replicate_db ${auth_url} ${BACKEND_URL} $db $tmpdb

  echo -e "\nDeleting $db"
  delete_db $URL $db

  echo -e "\nRestoring $db"
  replicate_db $auth_url ${BACKEND_URL} $tmpdb $db


  # clean up
  echo -e "\nDeleting backup db $tmpdb"
  delete_db $URL $tmpdb

  echo -e "\nDeleting backup replication task \"$task\" "
  delete_doc ${BACKEND_URL} "_replicator" ${task}

  echo -e "\nDeleting restore replication task \"${tmpdb}_${db}\" "
  delete_doc ${BACKEND_URL} "_replicator" ${tmpdb}_${db}
done
