# check if you are in administration mode, if not, ask for authorization
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
	$arguments = "& '" + $myinvocation.mycommand.definition + "'"
	Start-Process powershell -Verb runAs -ArgumentList $arguments
	Break
}

.\Carbon\Import-Carbon.ps1

Set-CHostsEntry -IPAddress 10.2.3.55 -HostName 'myserver' -Description "myserver's IP address"