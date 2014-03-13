#!/bin/sh -e

SHARDSDIR='/opt/bigcouch/var/lib/'
NETRC='/etc/couchdb/couchdb.netrc'
SIZE='1M'

#shards=`find ${SHARDSDIR}/shards/ -name '*5a66957c1c93aa637d241484912c61f8*' -size +${SIZE}`
shards=`find ${SHARDSDIR}/shards/ -type f -size +${SIZE}`

echo
echo "Disk usage before: `df -h $SHARDSDIR`" 
echo 

for i in $shards
do
  shard=`echo $i | sed "s/^.*shards\///" | cut -d'/' -f 1`
  db=`basename $i .couch`
  #echo $shard    
  #echo $db
  echo -n "compacting ${i}:"
  curl -X POST --netrc-file $NETRC -H "Content-Type: application/json" "http://127.0.0.1:5986/shards%2F${shard}%2F${db}/_compact"
  sleep 1
done

echo
echo "Disk usage after: `df -h $SHARDSDIR`" 
echo 

echo "$0 ran successful"
