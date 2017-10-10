#!/bin/bash
#
# @file read_db_mysql.sh
# @brief read data from mysql
# @author Mingxing LAI
# @version 0.1
# @date 2013-01-20
#

USER="root"
DATABASE="students"
TABLE="students"

#用tail 去掉表头
depts=`mysql -u $USER $DATABASE <<EOF | tail -n +2
SELECT DISTINCT dept FROM $TABLE;
EOF`

for d in $depts; do
    echo Department: $d
    result="`mysql -u $USER $DATABASE << EOF
    set @i:=0;
    SELECT @i:=@i+1 as rank, name, mark FROM students WHERE dept="$d" ORDER BY mark DESC;
EOF`"

echo "$result"
echo
done
