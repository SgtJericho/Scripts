﻿# Check for available updates
# Created by Jason Prespolis | 6:33 PM 5/11/2024 | for Windows 11 Enterprise

# https://www.hexnode.com/mobile-device-management/help/powershell-script-to-update-drivers-on-windows-devices/
$UpdateSvc = New-Object -ComObject Microsoft.Update.ServiceManager
$UpdateSvc.AddService2("7971f918-a847-4430-9279-4a52d1efe18d",7,"")
$Session = New-Object -ComObject Microsoft.Update.Session
$Searcher = $Session.CreateUpdateSearcher() 

$Searcher.ServiceID = '7971f918-a847-4430-9279-4a52d1efe18d'
$Searcher.SearchScope =  1 # MachineOnly
$Searcher.ServerSelection = 3 # Third Party
          
$Criteria = "IsInstalled=0 and Type='Driver'"
Write-Host('Searching Driver-Updates...') -Fore Green     
$SearchResult = $Searcher.Search($Criteria)          
$Updates = $SearchResult.Updates
if([string]::IsNullOrEmpty($Updates)){
  Write-Host "No pending driver updates."
}
else{
  #Show available Drivers...
  $Updates | select Title, DriverModel, DriverVerDate, Driverclass, DriverManufacturer | fl
  $UpdatesToDownload = New-Object -Com Microsoft.Update.UpdateColl
  $updates | % { $UpdatesToDownload.Add($_) | out-null }
  Write-Host('Downloading Drivers...')  -Fore Green
  $UpdateSession = New-Object -Com Microsoft.Update.Session
  $Downloader = $UpdateSession.CreateUpdateDownloader()
  $Downloader.Updates = $UpdatesToDownload
  $Downloader.Download()
  $UpdatesToInstall = New-Object -Com Microsoft.Update.UpdateColl
  $updates | % { if($_.IsDownloaded) { $UpdatesToInstall.Add($_) | out-null } }

  Write-Host('Installing Drivers...')  -Fore Green
  $Installer = $UpdateSession.CreateUpdateInstaller()
  $Installer.Updates = $UpdatesToInstall
  $InstallationResult = $Installer.Install()
  if($InstallationResult.RebootRequired) { 
  Write-Host('Reboot required! Please reboot now.') -Fore Red
  } else { Write-Host('Done.') -Fore Green }
  $updateSvc.Services | ? { $_.IsDefaultAUService -eq $false -and $_.ServiceID -eq "7971f918-a847-4430-9279-4a52d1efe18d" } | % { $UpdateSvc.RemoveService($_.ServiceID) }
}