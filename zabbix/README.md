sudo docker-compose up -d

sudo ./docker-zabbix-mysql-dump.sh

sudo apt-get install pv

sudo ./docker-zabbix-mysql-restore.sh

chmod -R 777 ./mysql-data

mysqladmin -u root --password=zabbix drop zabbix

mysqladmin -u root -p --password=zabbix create zabbix

mysql -u root -p --password=zabbix -f zabbix < /backup/20220720-1627-zabbix-defs.sql
mysql -u root -p --password=zabbix -f zabbix < /backup/20220720-1628-zabbix.sql


sudo docker run --name zabbix-agent --privileged -d zabbix/zabbix-agent:latest


# -p 50601:9000 \
# docker run -d -p 50601:9000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
# docker run -d -p 50601:8000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
sudo docker stop zabbix-agent
sudo docker rm zabbix-agent

sudo \
docker run -d \
-p 10050:10050 \
--net net-docker \
--ip 172.20.0.7 \
-e ZBX_SERVER_HOST=179.179.17.175 \
--name=zabbix-agent \
--restart=unless-stopped \
zabbix/zabbix-agent:latest

sudo docker cp zabbix-agent:/etc/zabbix/. .


-----------azure

docker run -it mcr.microsoft.com/azure-cli

az login 

erro no login:
https://bytemeta.vip/repo/Azure/azure-cli/issues/20152
https://github.com/microsoft/WSL/issues/5256

sudo nano /etc/resolv.conf
nameserver 8.8.8.8

az group create --name Conteiners --location eastus2

sudo docker commit zabbix-mysql zabbix-mysql_26072022
sudo docker login --username databelli --password p@cwin32_
sudo docker tag zabbix-mysql_26072022 databelli/zabbix-mysql:26072022
sudo docker push databelli/zabbix-mysql:26072022