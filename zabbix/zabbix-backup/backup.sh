#!/bin/bash
clear;

# Load database name + root password
source ./env_vars/.env_db_mysql

# Delete old Backups
find ./zabbix-backup/* -atime +7 -exec rm {} \;

# Dump Table Definitions
docker-compose exec -T mysql-server mysqldump -u root --password=zabbix --no-data zabbix > ./zabbix-backup/zabbix-defs.sql

## Dump Content
docker-compose exec -T mysql-server /usr/bin/mysqldump -u root --password=zabbix --no-create-info zabbix | gzip --rsyncable > ./zabbix-backup/zabbix.sql.gz

docker-compose exec -T mysql-server mysql -u root -p --password=zabbix -f zabbix < ./zabbix-backup/zabbix-defs.sql

mysql -u root -p --password=zabbix -f zabbix < /backup/zabbix-defs.sql