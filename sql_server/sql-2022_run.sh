docker run -d \
    --network bridge \
    -e TZ=America/Sao_Paulo \
    -e ACCEPT_EULA=Y \
    -e MSSQL_SA_PASSWORD=data@2012 \
    -p 1433:1433 \
    -v /mnt/d/sql-2022:/var/opt/mssql/data \
    --name sql-2022 \
    --hostname SQL2022 \
    --restart unless-stopped \
    mcr.microsoft.com/mssql/server:2022-latest