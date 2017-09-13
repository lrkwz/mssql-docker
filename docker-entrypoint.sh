#!/bin/sh

env

"$@" &
SQLSERVERPID=$!

sleep 20

for f in /docker-entrypoint-initdb.d/*; do
    case "$f" in
        *.sh)     echo "$0: running $f"; . "$f" ;;
#        *.sql)    echo "$0: running $f"; "${mysql[@]}" < "$f"; echo ;;
#        *.sql.gz) echo "$0: running $f"; gunzip -c "$f" | "${mysql[@]}"; echo ;;
        *)        echo "$0: ignoring $f" ;;
    esac
    echo
done

kill $SQLSERVERPID
sleep 20

"$@"
