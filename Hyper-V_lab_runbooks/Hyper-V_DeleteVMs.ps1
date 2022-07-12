#Written by Jeremy Scarbro - Security Engineer

###########################
#   Delete Hyper-V VM's   #
###########################


##########################################
#                Variables               # 
#                                        #
#    Can add multiple VM's as Strings    # 
#                                        #
##########################################


$VM = Get-VM -Name 'WSUS-LAB'
$VMName = 'WSUS-LAB'


####################################
#       Script to remove VM        #
####################################


Stop-VM -VM $VM -Force
Get-VMSnapshot -VMName $VMName | Select-Object -ExpandProperty HardDrives | ForEach-Object { Get-VHD $_.Path | Select-Object Path } | Remove-item -Force -Verbose
Get-VMHardDiskDrive -VMName $VMName | Select-Object Path | Remove-item -Force -Verbose
Remove-VM $VM -Force -Verbose