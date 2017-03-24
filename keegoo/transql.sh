#!/bin/bash
original_path=100.98.181.88
orguser=lisha
orgpwd=Lisha654321
orgdb=keegoo6x
target_path=127.0.0.1
taguser=root
tagpwd='4b)^09cA'
tagdb=$1

#set mysql-client default user and password
#mysql_config_editor set --login-path=local --host=localhost --user=root --password

echo "copying online database !"
#export org database into org.sql;
#mysqldump -h${original_path} -u${orguser} -p${orgpwd} ${orgdb} > /opt/org.sql
mysqldump --login-path=online keegoo6x --set-gtid-purged=OFF > /opt/org.sql

sed -i "/\`lisha\`/,+0d" /opt/org.sql

echo "loading $1 database !"
#import org.sql into target database;
#mysql -h${target_path}   -u${taguser} -p${tagpwd} ${tagdb} < /opt/org.sql
mysql --login-path=local ${tagdb} < /opt/org.sql

echo "`du -sh /opt/org.sql` done !"
