wsl --shutdown

wsl --export docker-desktop-data docker-desktop-data.tar

wsl --unregister docker-desktop-data

wsl --import docker-desktop-data d:\wsl\docker-desktop-data docker-desktop-data.tar --version 2