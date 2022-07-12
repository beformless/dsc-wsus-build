#Written by Jeremy Scarbro - Security Engineer

#######################
#   Checkpoint VM's   #
#######################


#################
#   Variables   #
#################


#$VMNames = @("DEV-DC001", "DEV-DC002")
$VMName = 'WSUS-LAB'
$CheckpointName = 'Start_Demo_LCM'

########################
#   Create Checkoint   #
########################

#Multiple Snapshots
#Checkpoint-vm -name $VMNames -SnapshotName $CheckpointName

#Single Snapshot
Checkpoint-vm -name $VMName -SnapshotName $CheckpointName