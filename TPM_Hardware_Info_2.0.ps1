## Created by Jason Prespolis 8/21/23 ##
#######################################

# How to check Secure Boot Configuration 
# HKEY_LOCAL_MACHINE \ System \ CurrentControlSet \ Control \ SecureBoot \ State

# UEFISecureBootEnabled    REG_DWORD    0x1

#0 = Disabled
#1 = Enabled

#Set-ExecutionPolicy RemoteSigned
#Powershell.exe -Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

Get-CimInstance -ClassName Win32_Processor; Get-CimInstance -Class CIM_ComputerSystem -ErrorAction Stop | Select-Object Manufacturer, Model, SystemSKUNumber;
Get-CimInstance -ClassName Win32_BIOS | Select-Object -Property Manufacturer,Name,ReleaseDate,SerialNumber;
Write-Host 'The Motherboards Firmware is:'$env:firmware_type;
# UEFISecureBootEnable
REG QUERY HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\SecureBoot\State
Get-ItemProperty `
-Path hklm:\System\CurrentControlSet\Control\SecureBoot\State ` | 
Select-Object UEFISecureBootEnabled

wmic partition get name,size,type;
Get-TPM 

#Get-ComputerInfo | Select-Object OSName, OSVersion, OsHardwareAbstractionLayer; Get-Disk; wmic partition get name,size,type;