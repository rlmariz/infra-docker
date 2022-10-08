# Introduction 
TODO: Give a short introduction of your project. Let this section explain the objectives or the motivation behind this project. 

# Getting Started
TODO: Guide users through getting your code up and running on their own system. In this section you can talk about:
1.	Installation process
2.	Software dependencies
3.	Latest releases
4.	API references

# Build and Test
TODO: Describe and show how to build your code and run the tests. 

# Contribute
TODO: Explain how other users and developers can contribute to make your code better. 

If you want to learn more about creating good readme files then refer the following [guidelines](https://docs.microsoft.com/en-us/azure/devops/repos/git/create-a-readme?view=azure-devops). You can also seek inspiration from the below readme files:
- [ASP.NET Core](https://github.com/aspnet/Home)
- [Visual Studio Code](https://github.com/Microsoft/vscode)
- [Chakra Core](https://github.com/Microsoft/ChakraCore)


# Docker Network

sudo \
docker network create \
  --driver=bridge \
  --subnet=172.20.0.0/24 \
  --ip-range=172.20.0.0/24 \
  --gateway=172.20.0.1 \
  net-docker

docker network create --driver=bridge --subnet=172.20.0.0/24 --ip-range=172.20.0.0/24 --gateway=172.20.0.1 net-docker

# Portforwand WSL2
netsh interface portproxy show all
netsh interface portproxy reset

netsh interface portproxy add v4tov4 listenport=1433 listenaddress=0.0.0.0 connectport=1433 connectaddress=ubuntu.wsl

# Problema de troca de ip
https://github.com/shayne/go-wsl2-host

# Automatic Start
 wsl sudo nano /etc/wsl.conf

 [boot]
command="service docker start"
