$env:COMPUTERNAME

#this is how your local powershell session can access the environment variable, but the remote powershell session will not have access to this variable
Write-Output "Hello from $($env:COMPUTERNAME)!"

$variable = Write-Output "Hello from $($env:COMPUTERNAME)!"

$variable

# the remote powershell session will not have access to the variable defined in the local session, but it can still access the environment variable directly
$variableBlock = {
    Write-Output "Hello from $($env:COMPUTERNAME)!"
}

$variableBlock

& $variableBlock

#activate the remote powershell with the following command in the terminal:
Enable-PSRemoting -Force

#To adding a trusted remote machine to the local machine, you can use the following command (replace "RemoteMachineName" with the actual name of the remote machine):
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "RemoteMachineName" -Force
#For example, if you want to add the local machine itself as a trusted host, you can use:
#Set-Item WSMan:\localhost\Client\TrustedHosts -Value "NB-PE0AP4D4-100,192.168.0.1" -Force

#To get all the trusted hosts, you can use the following command:
Get-Item WSMan:\localhost\Client\TrustedHosts

#To execute just one command on a remote machine without entering a remote session, you can use the following command (replace "RemoteMachineName" with the actual name of the remote machine):
Invoke-Command -ComputerName RemoteMachineName -Credential Get-Credential -ScriptBlock { Get-Process }

#then you can use the following command to start a remote powershell session on the local machine (you can also specify a remote machine name instead of localhost):
Enter-PSSession -ComputerName NB-PE0AP4D4-100

#after running the above command, you will be in a remote powershell session, and you can run the following command to see the computer name of the remote session:
$env:COMPUTERNAME

#to exit the remote powershell session, you can use the following command:
Exit-PSSession