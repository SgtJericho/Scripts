# Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
# Created by Jason Prespolis | 5:57 PM 5/25/2024 | for Windows 10/11 Enterprise

# Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned

# Disable Location Service
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy" -Name "LocationEnabled" -Value 0

# Disable Call History
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy" -Name "CallHistoryInking" -Value 0

# Disable Share & Sync with Other Devices
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy" -Name "SyncWithDevices" -Value 0

# Disable Radios (Bluetooth, Wi-Fi, etc.)
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy" -Name "Radios" -Value 0

# Disable Microsoft Consumer Experience
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Value 0

# Disable Spotlight
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "RotatingLockScreenEnabled" -Value 0

# Change Diagnostics and Usage Data Setting Full to Basic
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Value 1

# Feedback Automatically Send Feedback to Microsoft change to Never
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t "REG_DWORD" /d "0" /f
reg delete "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /f
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Value 0

# Disable the following Privacy Setting for windows 11 via Powershell script

reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t "REG_DWORD" /d "0" /f
reg delete "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /f

reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location"
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy"
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
reg query "HKEY_CURRENT_USER\Software\Microsoft\Siuf\Rules"