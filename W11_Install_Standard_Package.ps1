# PowerShell script to download and install specified applications, apply registry edits, and rename the computer
# Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
# Created by Jason Prespolis | 5:57 PM 5/25/2024 | for Windows 10/11 Enterprise

# Define download URLs
# $pcHealthCheckUrl = "https://aka.ms/GetPCHealthCheckApp"
# $pcHealthCheckUrl = "https://download.microsoft.com/download/6/9/5/6952da5f-ecb9-473d-83f7-fb52b88e6fdf/3.9/x64/WindowsPCHealthCheckSetup.msi"
# $logitechUnifyingUrl = "https://support.logi.com/hc/en-us/articles/5316378315287-Logitech-Unifying-Software"
# $logitechUnifyingUrl = "https://download01.logi.com/web/ftp/pub/techsupport/unifying/unifying252.exe"

# Specify installation paths (modify if needed)
$downloadsPath = "$env:USERPROFILE\Downloads"
$pcHealthCheckInstallPath = "$downloadsPath\PC Health Check"
$logitechUnifyingInstallPath = "$downloadsPath\Logitech Unifying"

# Create the Downloads folder if it doesn't exist
if (-not (Test-Path -Path $downloadsPath)) {
    New-Item -ItemType Directory -Path $downloadsPath
}

# Download Windows PC Health Check
# Invoke-WebRequest -Uri $pcHealthCheckUrl -OutFile "$downloadsPath\WindowsPCHealthCheckSetup.msi"

# Download Logitech Unifying Software
# Invoke-WebRequest -Uri $logitechUnifyingUrl -OutFile "$downloadsPath\unifying252.exe"

# Install Windows PC Health Check (if needed)
# Start-Process -Wait -FilePath "$downloadsPath\WindowsPCHealthCheckSetup.msi" -ArgumentList "/QB /D=$pcHealthCheckInstallPath"
Start-Process -Wait -FilePath "$downloadsPath\WindowsPCHealthCheckSetup.msi" "/QB"
# Start-Process -FilePath "WindowsPCHealthCheckSetup.msi" -ArgumentList "/QB" -Wait

# Install Logitech Unifying Software (if needed)
# Start-Process -FilePath "unifying252.exe" -ArgumentList "/S" -Wait
Start-Process -Wait -FilePath "$downloadsPath\unifying252.exe" -ArgumentList "/S /D=$logitechUnifyingInstallPath"

Write-Host "Script completed successfully!"
