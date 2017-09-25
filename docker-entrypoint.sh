#!/bin/sh

env

"$@" &
SQLSERVERPID=$!

sleep 20

for f in /docker-entrypoint-initdb.d/*; do
    case "$f" in
        *.sh)     echo "$0: running $f"; . "$f" ;;
        *.sql)    echo "$0: running $f"; /opt/mssql-tools/bin/sqlcmd -S 127.0.0.1,1433 -U sa -P $SA_PASSWORD -i "$f"; echo ;;
#        *.sql.gz) echo "$0: running $f"; gunzip -c "$f" | "${mysql[@]}"; echo ;;
        *)        echo "$0: ignoring $f" ;;
    esac
    echo
done

kill $SQLSERVERPID
sleep 20

"$@"
