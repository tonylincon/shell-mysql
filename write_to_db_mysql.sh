#!/bin/bash
#
# @file write_to_db_mysql.sh
# @brief wirte data to database in mysql
# @author Mingxing LAI
# @version 0.1
# @date 2013-01-20
#

USER="root"
DATABASE="students"
TABLE="students"
if [ $# -ne 1 ]; then
    echo $0 DATAFILE
    echo
    exit 2
fi
data=$1
while  read line;
do
#   query=`echo $line | awk -F, '{ printf("%s,\"%s\",%s,\"%s\"", $1, $2, $3, $4)}'`
    oldIFS=$IFS
    IFS=,
    values=($line)
    values[1]="\"`echo ${values[1]} | tr ' ' '#' `\""
    values[3]="\"`echo ${values[3]}`\""
    query=`echo ${values[@]} | tr ' #' ', '`
    IFS=$oldIFS
    statement=`echo "INSERT INTO $TABLE VALUES($query);"`
#   echo $statement

mysql -u $USER -p root $DATABASE << EOF
    INSERT INTO $TABLE VALUES($query);
EOF
done < $data
if [[ $? -eq 0 ]]; then
    echo "Wrote data into DB"
fi
