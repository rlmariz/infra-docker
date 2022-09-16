#!/bin/bash
clear;

# Change to the script's directory & create directory
cd $(dirname "$(readlink -f "$0")")
mkdir -p ./zabbix-backup

# Load database name + root password
source ./env_vars/.env_db_mysql

# Delete old Backups
find ./zabbix-backup/* -atime +7 -exec rm {} \;

# Dump Table Definitions
docker-compose exec -T mysql-server mysqldump -u root --password=$MYSQL_ROOT_PASSWORD --no-data $MYSQL_DATABASE > ./zabbix-backup/`date +\%Y\%m\%d-\%H\%M`-$MYSQL_DATABASE-defs.sql

## Dump Content
docker-compose exec -T mysql-server /usr/bin/mysqldump -u root \
      --password=$MYSQL_ROOT_PASSWORD \
      --no-create-info \
      --ignore-table=zabbix.acknowledges \
      --ignore-table=zabbix.alerts \
      --ignore-table=zabbix.auditlog \
      --ignore-table=zabbix.auditlog_details \
      --ignore-table=zabbix.event_recovery \
      --ignore-table=zabbix.event_suppress \
      --ignore-table=zabbix.event_tag \
      --ignore-table=zabbix.events \
      --ignore-table=zabbix.history \
      --ignore-table=zabbix.history_log \
      --ignore-table=zabbix.history_str \
      --ignore-table=zabbix.history_str_sync \
      --ignore-table=zabbix.history_sync \
      --ignore-table=zabbix.history_text \
      --ignore-table=zabbix.history_uint \
      --ignore-table=zabbix.history_uint_sync \
      --ignore-table=zabbix.item_rtdata \
      --ignore-table=zabbix.problem \
      --ignore-table=zabbix.problem_tag \
      --ignore-table=zabbix.task \
      --ignore-table=zabbix.task_acknowledge \
      --ignore-table=zabbix.task_check_now \
      --ignore-table=zabbix.task_close_problem \
      --ignore-table=zabbix.task_remote_command \
      --ignore-table=zabbix.task_remote_command_result \
      --ignore-table=zabbix.trends \
      --ignore-table=zabbix.trends_uint \
      $MYSQL_DATABASE \
      | gzip --rsyncable > ./zabbix-backup/`date +\%Y\%m\%d-\%H\%M`-$MYSQL_DATABASE.sql.gz
