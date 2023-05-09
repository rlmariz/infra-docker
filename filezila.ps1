docker run -d `
    --name=filezilla `
    --security-opt seccomp=unconfined `
    -e PUID=1000 `
    -e PGID=1000 `
    -e TZ=America/Sao_Paulo `
    -p 3000:3000 `
    -p 3001:3001 `
    -v c:/filezila/confg:/config `
    --restart unless-stopped `
    lscr.io/linuxserver/filezilla:latest