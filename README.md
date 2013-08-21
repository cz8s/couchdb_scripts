Leap Couchdb/Bigcouch scripts
=============================

Issues
------

* dump_db() and restore_db() rely on python-couchdb package, 
  python-couchdb =< 0.8-1 needs to be patched, see
  http://code.google.com/p/couchdb-python/issues/detail?id=194 


Exapmples
=========

Use couchdb functions on command line
-------------------------------------

    . couchdb-scripts-defaults.conf
    . couchdb_functions
    get_dbs $URL 
    restore_db $URL users_replicated $user $pw

