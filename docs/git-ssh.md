1)create key 
ssh-keygen -C "rlmariz@gmail.com"

2)Add the public key to Azure DevOps

3)edit nano ~/.ssh/config:

Host ssh.dev.azure.com
    HostName ssh.dev.azure.com
    User git
    IdentityFile ~/.ssh/id_rsa
    IdentitiesOnly yes
    PubkeyAcceptedAlgorithms +ssh-rsa
    HostkeyAlgorithms +ssh-rsa

3)Test the connection by running the following command: ssh -T git@ssh.dev.azure.com. If everything is working correctly, you'll receive a response which says: remote: Shell access is not supported.