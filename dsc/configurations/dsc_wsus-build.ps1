configuration wsus_build {
   
    # Target node to apply the configuration
    $NodeName = 'localhost'
    

    # Import the module that defines custom resources
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
    Import-DscResource -ModuleName UpdateServicesDsc
    Import-DscResource -ModuleName 'xPSDesiredStateConfiguration'

    Node $NodeName{

        #------------------#
        # Install Services #
        #------------------#

            # Install the Update Services Role
            xWindowsFeature 'UpdateServices'
            {
                Ensure = 'Present'
                Name = 'UpdateServices'
            }

            # Install the IIS Management Console
            xWindowsFeature 'IISMgmtConsole'
            {
                Ensure = 'Present'
                Name = 'Web-Mgmt-Console'
            }

            xWindowsFeature 'UpdateServicesRSAT'
            {
                Ensure = 'Present'
                Name = 'UpdateServices-RSAT'
                IncludeAllSubFeature =  $True
            }
            UpdateServicesServer 'UpdateServices'
            {
                DependsOn = @(
                    '[xWindowsFeature]UpdateServices'
                )
                Ensure = 'Present'
                ContentDir = 'C:\WSUS'
                Languages = @('en')
                Products = @(
                    '*'
                )
                Classifications = @(
                    'E6CF1350-C01B-414D-A61F-263D14D133B4', #CriticalUpdates
                    'E0789628-CE08-4437-BE74-2495B842F43B', #DefinitionUpdates
                    '0FA1201D-4330-4FA8-8AE9-B877473B6441', #SecurityUpdates
                    '68C5B0A3-D1A6-4553-AE49-01D3A7827828', #ServicePacks
                    '28BC880E-0592-4CBF-8F95-C79B17911D5F' #UpdateRollUps
                )
                SynchronizeAutomatically = $true
                SynchronizeAutomaticallyTimeOfDay = '12:00:00'
            }
            UpdateServicesCleanup 'UpdateCleanup'
            {
                DependsOn = @(
                    '[xWindowsFeature]UpdateServices'
                )
                Ensure = 'Present'
                DeclineSupersededUpdates = $true
                DeclineExpiredUpdates = $true
                CleanupObsoleteUpdates = $true
                CompressUpdates = $true
                CleanupObsoleteComputers = $true
                CleanupUnneededContentFiles = $true
                CleanupLocalPublishedContentFiles = $true
                TimeOfDay = '02:00:00'
            }
    }
}

wsus_build -ConfigurationData $NodeName
