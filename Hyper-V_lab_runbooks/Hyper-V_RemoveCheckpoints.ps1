#Written by Jeremy Scarbro - Security Engineer

###########################
#   Remove VM Checkpoints #
###########################


#################
#   Variables   #
#################


$VMNames = 'WSUS-LAB'
$CheckpointName = 'vanilla'


########################
#   Remove SnapShots   #
########################


Remove-VMSnapshot -vmname $VMNames -Name $CheckpointName