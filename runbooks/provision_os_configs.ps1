#Written by Jeremy Scarbro - Security Engineer

######################################
#   Provision OS Configurations      #
######################################


#################
#   Variables   #
#################

$NewDirectoryItems = 'c:\Code','c:\Code\DSC','C:\Code\DSC\LCM','C:\Code\DSC\Configurations'

######################################
#   Script to provision all objects  #
######################################

#Create Folders
New-Item -Path $NewDirectoryItems -ItemType Directory