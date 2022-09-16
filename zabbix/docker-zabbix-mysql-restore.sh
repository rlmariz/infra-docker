#!/bin/bash

# Check package availability
command -v pv >/dev/null 2>&1 || { echo "[Error] Please install pv [apt-get install pv]"; exit 1; }

# Load database name + root password
source ./env_vars/.env_db_mysql

# Find latest definition
latestd1=$(ls -1t ./zabbix-backup/*-defs.sql | head -1)
latestd2=$(ls -1t ./zabbix-backup/*-defs.sql | head -n2 | tail -n1)
latestd3=$(ls -1t ./zabbix-backup/*-defs.sql | head -n3 | tail -n1)

# Select dump
echo "Which content dump should be used for restoring?"
select resultd in $latestd1 $latestd2 $latestd3
do
    [ $resultd ] && break
done

# Find latest content
latest1=$(ls -1t ./zabbix-backup/*.sql.gz | head -1)
latest2=$(ls -1t ./zabbix-backup/*.sql.gz | head -n2 | tail -n1)
latest3=$(ls -1t ./zabbix-backup/*.sql.gz | head -n3 | tail -n1)

# Select dump
echo "Which content dump should be used for restoring?"
select result in $latest1 $latest2 $latest3
do
    [ $result ] && break
done

# Get the size of the uncompressed sql file
size=$(gzip -l $result | awk 'FNR==2{print $2}')

# Wait
while ! (docker-compose exec mysql-server /usr/bin/mysqladmin -u root --password=${MYSQL_ROOT_PASSWORD} ping --silent)
do
	sleep 15
	echo "Wait for DB to initialize"
done

# Restore Defs
cat $resultd | docker-compose exec -T mysql-server \
	/usr/bin/mysql -u root --password=${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE}

# Restore
echo "Starting restore now."
gunzip --keep --stdout $result | pv --size $size | docker-compose exec -T mysql-server \
	/usr/bin/mysql -u root --password=${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE}

