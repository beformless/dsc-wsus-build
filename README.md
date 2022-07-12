# wsus-build

# https://docs.microsoft.com/en-us/windows-server/administration/windows-server-update-services/get-started/windows-server-update-services-wsus

# https://github.com/dsccommunity/UpdateServicesDsc

# Written by Jeremy Scarbro - Security Engineer

- Step by step guide to lab a WSUS build 

	- Make sure all DSC Resource modules are available and up to date on your local machine.  DSC Resources live in "C:\Program Files\WindowsPowerShell\Modules"
	- Your DSC Configuration will show which DSC Resources are needed
		- For this lab you need the resources below
			- PSDesiredStateConfiguration - This Resource is built in and does not need to be replaced
			- UpdateServicesDSC
			- xPSDesiredStateConfiguration
	- Download official DSC Resources from https://github.com/PowerShell/DscResources 
		- I recommend cloning the official DSC repository onto your system to obtain the latest DSC Resource updates
		- The official repository will link to the updated and maintained modules within https://github.com/dsccommunity
	- Run all scripts from an Administrative Terminal
        
1. Copy Needed DSC Modules from local box to WSUS Server (Manual)
	- Directory Location = "C:\Program Files\WindowsPowerShell\Modules"
		- UpdateServicesDSC
		- xPSDesiredStateConfiguration

2.  Run provision_os_config.ps1 on the WSUS Server 

3.  Validate DSC Config - Optional Step if you would like to adjust or update DSC Configuration (Manual and Automated)
	- From your local box validate DSC configuration 
		- Edit "dsc_wsus_build.ps1"
			- Run "dsc_wsus_build.ps1" if a new DSC Configuration is needed
		
4.  Stage Windows Server for WSUS Build (Manual)
	- Copy "localhost.meta.mof" to the directory "C:\Code\DSC\LCM" on the WSUS server
	- Copy the directory "wsus_build" to the directory "C:\Code\DSC\Configurations" on the WSUS Server

5.  Run LCM Configuration to change LCM setting, "Reboot If Needed" to True (Automated)
	- From an Administrative PowerShell Terminal on the WSUS server, run the command, "Set-dsclocalconfigurationmanager -path c:\Code\DSC\LCM -Verbose"

6.  Run the DSC Configuration to Configure and Build the WSUS Service (Automated)
	- From an Administrative PowerShell Terminal on the WSUS server, run the command, "Start-dscconfiguration -path C:\Code\DSC\Configurations\wsus_build -wait -verbose"

7.  On the WSUS Server, launch Windows Server Update Services, go to Update Files and Languages, select Do not store update files locally; computers install from microsoft update.  Apply and OK

8.  On the WSUS Server, launch Windows Server Update Services, go to Products and Classifications, from the Products tab, choose the Products you would like to include

09.  Setup email notifications

10.  Adjust Group Policy to point to our new WSUS server

11.  In order to view Reports install the prerequisites below
	- http://go.microsoft.com/fwlink/?LinkID=239644&clcid=0x409 - 
    - - Microsoft® System CLR Types for Microsoft® SQL Server® 2012
	- https://www.microsoft.com/en-us/download/details.aspx?id=35747
	- - MICROSOFT® REPORT VIEWER 2012 RUNTIME



