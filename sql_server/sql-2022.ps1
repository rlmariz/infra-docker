docker run `
    --hostname=SQL2022 `
    --name=sql-2022 `
    --env=MSSQL_SA_PASSWORD=data@2022 `
    --env=TZ=America/Sao_Paulo `
    --env=ACCEPT_EULA=Y `
    --volume=D:/sql-2022:/var/opt/mssql/data `
    --network=bridge `
    -p 1433:1433 `
    --restart=unless-stopped `
    -d mcr.microsoft.com/mssql/server:2022-latest