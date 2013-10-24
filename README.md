Leap Couchdb/Bigcouch scripts
=============================

Todo
====

* move from curl to wget, because it's faster

Prerequisites
=============

use a  ./~.netrc file for authentication:

    machine 127.0.0.1 login admin password YOUR_PW 

Examples
========

Use couchdb functions on command line
-------------------------------------

    . couchdb-scripts-defaults.conf
    . couchdb_functions

    # get all db names
    get_dbs $URL 

    # delete db
    delete_db $URL users

    # dump db "users" to stdout
    dump_db $URL users

    # Dump db "users" to default backupdir 
    dump_db_to_file $URL users
    
    # restore db "users" from default backupdir
    restore_db $URL users 

