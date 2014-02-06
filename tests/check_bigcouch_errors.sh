#!/bin/bash


WARN=10
CRIT=20
LOG='/opt/bigcouch/var/log/bigcouch.log'

# for debugging: zgrep through old logs
#LOG=/opt/bigcouch/var/log/bigcouch.log.1.gz
#errors=`zcat $LOG | grep 'error' | sed 's/\[.*\] //' | sort`

errors=`grep 'error' $LOG | sed 's/\[.*\] //' | sort `
errors_uniq=`echo -e "$errors" | uniq`

total=`echo -e "$errors" | grep -v '^$' | wc -l`

if [ $total -lt $WARN ]
then
  echo -n "OK"
  exitcode=0
else
  if [ $total -le $CRIT ]
  then
    echo -n "Warning"
    exitcode=1
  else
      echo -n "Critical"
      exitcode=2
  fi
fi

echo -n ": $total errors in total in $LOG."

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
