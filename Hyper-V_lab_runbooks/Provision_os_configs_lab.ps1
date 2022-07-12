#Written by Jeremy Scarbro - Security Engineer

##############################
#   Provision DEV-DC001      #
##############################


#################
#   Variables   #
#################


$NewDirectoryItems = 'c:\Code','c:\Code\DSC','C:\Code\DSC\LCM','C:\Code\DSC\Configurations'
$Hostname = 'WSUS-LAB' 
$IPAddress = '192.168.0.100'
$PrefixLength = '24'
$DefaultGateway = '192.168.0.1'
$DNSServer = '192.168.86.1'
#$AlternateDNSServer = '10.131.64.41'

######################################
#   Script to provision all objects   #
######################################


#Enable IPV4 Port communication
netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol=icmpv4:8,any dir=in action=allow

#Create Folders
New-Item -Path $NewDirectoryItems -ItemType Directory

#Change IP Address
New-NetIPAddress -IPAddress $IPAddress -PrefixLength $PrefixLength -DefaultGateway $DefaultGateway -InterfaceAlias Ethernet

#Change DNS
Set-DnsClientServerAddress -ServerAddresses $DNSServer -InterfaceAlias Ethernet

#Rename Computer
Rename-computer -NewName $Hostname -Restart