docker run -d \
    --network bridge \
    -e TZ=America/Sao_Paulo \
    -e ACCEPT_EULA=Y \
    -e MSSQL_SA_PASSWORD=data@2019 \
    -p 51433:1433 \
    -v /mnt/d/sql-2019:/var/opt/mssql/data \
    --name sql-2019 \
    --hostname SQL2019 \
    --restart unless-stopped \
    mcr.microsoft.com/mssql/server:2019-latest