#!/bin/bash
myhost=101.200.183.74
myuser=root
mypwd="zentao789&*("
mybase0=keegoo
mybase5=keegoo_online_backup0716
mybase6=kee_dev_0718
mysqldump -h${myhost} -u${myuser} -p${mypwd} -d ${mybase6}  > /opt/kee_str.sql
mysqldump -h${myhost} -u${myuser} -p${mypwd} -t ${mybase5} --complete-insert  > /opt/keegoo_rest_data.sql
sed -i "/INSERT INTO \`eduservice\`/d" /opt/keegoo_rest_data.sql
sed -i "/eduservicesku/d" /opt/keegoo_rest_data.sql
sed -i "/^\/$/s/$/**\//" /opt/keegoo_rest_data.sql
mysqldump -h${myhost} -u${myuser} -p${mypwd} ${mybase5} --complete-insert  eduservice  > /opt/keegoo_eduservice.sql
mysqldump -h${myhost} -u${myuser} -p${mypwd} ${mybase5} --complete-insert  eduservicesku  > /opt/keegoo_eduservicesku.sql
echo "DROP DATABASE IF EXISTS ${mybase0};" > tmp.sql
echo "create database ${mybase0};" >> tmp.sql
mysql -h${myhost} -u${myuser} -p${mypwd} < tmp.sql
rm -rf tmp.sql
mysql -h${myhost} -u${myuser} -p${mypwd} ${mybase0} < /opt/kee_str.sql
mysql -h${myhost} -u${myuser} -p${mypwd} ${mybase0} < /opt/keegoo_rest_data.sql 
echo "load /opt/keegoo_eduservice.sql"
mysql -h${myhost} -u${myuser} -p${mypwd} ${mybase0} < /opt/keegoo_eduservice.sql
echo "load /opt/keegoo_eduservicesku.sql"
mysql -h${myhost} -u${myuser} -p${mypwd} ${mybase0} < /opt/keegoo_eduservicesku.sql
echo "load /opt/upto6.sql"
mysql -h${myhost} -u${myuser} -p${mypwd} ${mybase0} < /opt/upto6.sql
