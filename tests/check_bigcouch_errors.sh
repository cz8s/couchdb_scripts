#!/bin/bash


WARN=1
CRIT=5
STATUS[0]='OK'
STATUS[1]='Warning'
STATUS[2]='Critical'
CHECKNAME='Bigcouch_Log'

LOG='/opt/bigcouch/var/log/bigcouch.log'

# for debugging: zgrep through old logs
#LOG=/opt/bigcouch/var/log/bigcouch.log.1.gz
#errors=`zcat $LOG | grep 'error' | sed 's/\[.*\] //' | sort`

errors=`grep 'error' $LOG | sed 's/\[.*\] //' | sort `
errors_uniq=`echo -e "$errors" | uniq`

total=`echo -e "$errors" | grep -v '^$' | wc -l`

if [ $total -lt $WARN ]
then
  exitcode=0
else
  if [ $total -le $CRIT ]
  then
    exitcode=1
  else
      exitcode=2
  fi
fi

echo -n "$exitcode $CHECKNAME errors=$total ${STATUS[exitcode]}: $total errors in total in $LOG."

if [ ! $total -eq 0 ]
then

  echo -e "$errors_uniq" | while read -r line
  do 
    count=`echo -e "$errors" | grep "$line" | wc -l`
    echo -n " $count occurrences of \"$line\"."
  done
fi

echo

exit $exitcode
