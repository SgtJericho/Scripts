# Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
# Created by Jason Prespolis | 5:44 AM 6/13/2024 | for Windows 10/11 Pro / Enterprise

Date

.\Install_Power_Plan.ps1
.\UpdateOS.ps1
.\UpdateDrivers.ps1
.\W11_Local_Packages.bat
.\W11_Install_Lenovo_Apps.ps1
.\W11_Install_Standard_Package.ps1
.\W10_Install_Registry_Edits_HomeLab.bat
.\W11_Remove_Ads_Settings.bat
.\W11_Install_PrivacySettings.ps1
.\W11_Remove_Ads_Settings.bat
.\Remove_Internet_Explorer
.\Install-EmbeddedProductKey.ps1
.\UpdateOS.ps1
.\UpdateDrivers.ps1
.\W11_Install_Features.ps1
.\W11_Remove_AppxPackage_Debloat.ps1
.\Clear_Evnt.bat

Date
Shutdown -r -t 900