<#
======================================================================================================
 
 Created on:    04.08.2023
 Version:       0.1  
 Function:      Detect setting in Lenovo BIOS

  This script is provided As Is
 Compatible with Windows 10 and later

Reference powershell command to change the Lenovo BOIS setting as below:
    (gwmi -class Lenovo_SetBiosSetting –namespace root\wmi).SetBiosSetting("SecureBoot,Enable")
    (gwmi -class Lenovo_SetBiosSetting –namespace root\wmi).SetBiosSetting("Secure Boot,Enable")
    (gwmi -class Lenovo_SaveBiosSettings -namespace root\wmi).SaveBiosSettings()
    (gwmi -class Lenovo_SetBiosSetting –namespace root\wmi).SetBiosSetting("SecurityChip,Active")
    (gwmi -class Lenovo_SetBiosSetting –namespace root\wmi).SetBiosSetting("Security Chip 2.0,Enable")
    (gwmi -class Lenovo_SetBiosSetting –namespace root\wmi).SetBiosSetting("Security Chip 1.2,Active")
    (gwmi -class Lenovo_SetBiosSetting –namespace root\wmi).SetBiosSetting("VirtualizationTechnology,Enable")
    (gwmi -class Lenovo_SetBiosSetting –namespace root\wmi).SetBiosSetting("VTdFeature,Enable")
    (gwmi -class Lenovo_SetBiosSetting –namespace root\wmi).SetBiosSetting("CSM,Disable")
    (gwmi -class Lenovo_SetBiosSetting –namespace root\wmi).SetBiosSetting("PhysicalPresenceForTpmClear,Enable")
    (gwmi -class Lenovo_SetBiosSetting –namespace root\wmi).SetBiosSetting("PhysicalPresenceForTpmProvision,Enable")
### Step 5 Save BIOS setting ###
### Show Current BIOS result ###
    gwmi -class Lenovo_BiosSetting -namespace root\wmi | Where-Object {$_.CurrentSetting.split(",",[StringSplitOptions]::RemoveEmptyEntries) -eq "SecureBoot"} | Format-List CurrentSetting 
    gwmi -class Lenovo_BiosSetting -namespace root\wmi | Where-Object {$_.CurrentSetting.split(",",[StringSplitOptions]::RemoveEmptyEntries) -eq "SecurityChip"} | Format-List CurrentSetting 
    gwmi -class Lenovo_BiosSetting -namespace root\wmi | Where-Object {$_.CurrentSetting.split(",",[StringSplitOptions]::RemoveEmptyEntries) -eq "PhysicalPresenceForTpmProvision"} | Format-List CurrentSetting 
    gwmi -class Lenovo_BiosSetting -namespace root\wmi | Where-Object {$_.CurrentSetting.split(",",[StringSplitOptions]::RemoveEmptyEntries) -eq "PhysicalPresenceForTpmClear"} | Format-List CurrentSetting 
    gwmi -class Lenovo_BiosSetting -namespace root\wmi | Where-Object {$_.CurrentSetting.split(",",[StringSplitOptions]::RemoveEmptyEntries) -eq "VirtualizationTechnology"} | Format-List CurrentSetting 
    gwmi -class Lenovo_BiosSetting -namespace root\wmi | Where-Object {$_.CurrentSetting.split(",",[StringSplitOptions]::RemoveEmptyEntries) -eq "VTdFeature"} | Format-List CurrentSetting
======================================================================================================

#>

[String]$Manufacturer = (Get-CimInstance -ClassName Win32_ComputerSystem).Manufacturer

If ($Manufacturer -eq "LENOVO")
{

    $BIOS = (Get-WmiObject -Class Lenovo_BiosSetting -Namespace root\wmi).CurrentSetting | Where-Object {$_ -like "SecureBoot*"} | Sort-Object
    
    If ($BIOS -ne "SecureBoot,Enable")
        {
            write-host "BIOS Settings NOT compliant"
            exit 1
        }
        else 
        {
            write-host "BIOS Settings OK"  
            exit 0  
        }
}
