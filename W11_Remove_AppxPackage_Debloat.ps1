# Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
# Created by Jason Prespolis | 5:57 PM 5/25/2024 | for Windows 10/11 Enterprise

<#
This script de-bloats unwanted apps from Windows Windows 10/11.
To keep certain apps and prevent them from being moved 
insert a '#' at the beginning of the line 
and it will be skipped.
#>

Clear-Host
Write-Host "Running Remove bloatware apps from Windows 10/11..."
Start-Sleep -s 2

IF ( ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) ) {
    Write-Host "Administration privileges have been granted.`n"
    Start-Sleep -s 2
    Clear-Host
} ELSE {
    Write-Host "Requesting administration privileges..."
    Start-Sleep -s 2
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit
}

# Apps
Write-Host "Removing bloatware apps...`n"
Start-Sleep -s 2

$AppNames = @(
    "Microsoft.BingWeather"
    #"Microsoft.DesktopAppInstaller"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.HEIFImageExtension"
    "Microsoft.Messaging"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    #"Microsoft.MicrosoftStickyNotes"
    "Microsoft.MixedReality.Portal"
    "Microsoft.Office.OneNote"
    #"Microsoft.OneConnect"
    "Microsoft.People"
    #"Microsoft.Print3D"
    "Microsoft.ScreenSketch"
    "Microsoft.SkypeApp"
    "Microsoft.StorePurchaseApp"
    "Microsoft.VP9VideoExtensions"
    "Microsoft.Wallet"
    "Microsoft.WebMediaExtensions"
    "Microsoft.WebpImageExtension"
    "Microsoft.WindowsAlarms"
    "microsoft.windowscommunicationsapps"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.WindowsMaps"
    "Microsoft.WindowsStore"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxApp"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxGamingOverlay"
    "Microsoft.XboxIdentityProvider"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.YourPhone"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
)

foreach ($app in $AppNames) {
    Write-Host "Attempting to remove $app... " #-NoNewline

    Try{
        Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage
        # | Select-Object Name -ExpandProperty Name
        Get-AppXProvisionedPackage -Online | Where-Object DisplayName -EQ $app | Remove-AppxProvisionedPackage -Online -AllUsers
        # | Select-Object DisplayName -ExpandProperty DisplayName
        Write-Host "Done" -ForegroundColor Green -ErrorAction Stop
    }
    Catch{
        Write-Host "Failed" -ForegroundColor Red
    }
}

Write-Host "Apps removed"
Write-Host "A total of $($error.count) errors were found`n"
Start-Sleep -s 2

# Restore all apps
#Get-AppxPackage -AllUsers | Foreach {
#    Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"
#}

Get-AppxProvisionedPackage -Online | Out-GridView -PassThru | Remove-AppxProvisionedPackage -Online
Get-AppxPackage -AllUsers | Format-List -Property PackageFullName,PackageUserInformation.