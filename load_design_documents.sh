#!/bin/sh

for file in `find /srv/leap/couchdb/designs -type f -name \*.json`
do
    db=`basename $file .json`
    /usr/local/bin/couch-doc-update --host 127.0.0.1:5984 --db $db --id _security --data '{}' --file $file
done
