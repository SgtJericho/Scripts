# Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
# Created by Jason Prespolis | 5:57 PM 5/25/2024 | for Windows 10/11 Pro / Enterprise

Date

.\Install_Power_Plan.ps1
.\UpdateOS.ps1
.\UpdateDrivers.ps1
.\W11_Local_Packages.bat
.\W11_Install_Lenovo_Apps.ps1
.\W11_Install_Standard_Package.ps1
.\W11_Install_Registry_Edits.bat
.\W11_Remove_Ads_Settings
.\W11_Install_PrivacySettings.ps1
.\W11_Install_Features.ps1
.\W11_Remove_Ads_Settings.bat
.\Install-EmbeddedProductKey.ps1
.\Clear_Evnt.bat

Date
Shutdown -r -t 900
