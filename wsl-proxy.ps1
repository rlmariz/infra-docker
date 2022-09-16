# http://get-carbon.org/Import-Carbon.ps1.html
.\Carbon\Carbon\Import-Carbon.ps1

# check if you are in administration mode, if not, ask for authorization
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
	$arguments = "& '" + $myinvocation.mycommand.definition + "'"
	Start-Process powershell -Verb runAs -ArgumentList $arguments
	Break
}

# wsl.exe ubuntu dir
# wsl -t ubuntu
# wsl.exe -d ubuntu

# get wsl intern ip
$wsl_host  = $(wsl hostname -I);
$wsl_hosts = $wsl_host.Split(" ");

# here you specify the ports for the proxy
$ports = @(1433);

# reset all interfaces
Invoke-Expression "netsh interface portproxy reset";
for ( $i = 0; $i -lt $ports.length; $i++ ) {
	$port = $ports[$i];
	$wsladdress = $wsl_hosts[0];
	Invoke-Expression "netsh interface portproxy add v4tov4 listenport=$port listenaddress=0.0.0.0 connectport=$port connectaddress=$wsladdress";
	Set-CHostsEntry -IPAddress $wsladdress -HostName 'ubuntu' -Description "WSL Ubuntu Distro"
}
Invoke-Expression "netsh interface portproxy show v4tov4";