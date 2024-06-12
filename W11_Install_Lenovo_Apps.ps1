# PowerShell script to download and install Lenovo Commercial Vantage / System Update / Diagnostics 
# Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
# Created by Jason Prespolis | 5:57 PM 5/25/2024 | for Windows 10/11 Enterprise

# Define download URLs
$commercialVantageUrl = "https://download.lenovo.com/pccbbs/thinkvantage_en/metroapps/Vantage/LenovoCommercialVantage_10.2401.29.0.zip"
$systemUpdateUrl = "https://download.lenovo.com/pccbbs/thinkvantage_en/system_update_5.08.02.25.exe"
$diagnosticsUrl = "https://download.lenovo.com/pccbbs/thinkvantage_en/ldiag_5.11.0_windows_x64.exe"

# Specify installation paths (modify if needed)
$downloadsPath = "$env:USERPROFILE\Downloads"
$vantageInstallPath = "$downloadsPath\Lenovo Commercial Vantage"
$systemUpdateInstallPath = "$downloadsPath\Lenovo System Update"
$diagnosticsInstallPath = "$downloadsPath\Lenovo Diagnostics"

# Create the Downloads folder if it doesn't exist
if (-not (Test-Path -Path $downloadsPath)) {
    New-Item -ItemType Directory -Path $downloadsPath
}

# Download Lenovo System Update
# Invoke-WebRequest -Uri $systemUpdateUrl -OutFile "$downloadsPath\LenovoSystemUpdate.exe"

# Download Lenovo Diagnostics
# Invoke-WebRequest -Uri $diagnosticsUrl -OutFile "$downloadsPath\ldiag_5.11.0_windows_x64.exe"

# Download Lenovo Commercial Vantage
# Invoke-WebRequest -Uri $commercialVantageUrl -OutFile "$downloadsPath\LenovoCommercialVantage_10.2401.29.0.zip"

# Install Lenovo System Update
Start-Process -Wait -FilePath "$downloadsPath\LenovoSystemUpdate.exe" -ArgumentList "/Silent /D=$systemUpdateInstallPath"

# Install Lenovo Diagnostics
Start-Process -Wait -FilePath "$downloadsPath\ldiag_5.11.0_windows_x64.exe" -ArgumentList "/Silent /D=$diagnosticsInstallPath"

# Testing Below #
#################

# Define the URL and the destination paths
$url = "https://download.lenovo.com/pccbbs/thinkvantage_en/metroapps/Vantage/LenovoCommercialVantage_10.2401.29.0.zip"
$destinationZip = "$env:USERPROFILE\Downloads\LenovoCommercialVantage_10.2401.29.0.zip"
$extractPath = "$env:USERPROFILE\Downloads\extracted"

# Download the file
Invoke-WebRequest -Uri $url -OutFile $destinationZip

# Create the directory if it doesn't exist
if (-not (Test-Path -Path $extractPath)) {
    New-Item -ItemType Directory -Path $extractPath
}

# Extract the zip file
# Expand-Archive -LiteralPath $destinationZip -DestinationPath $extractPath

# Run the batch file
$batchFilePath = Join-Path -Path $extractPath -ChildPath "setup-commercial-vantage.bat"
if (Test-Path -Path $batchFilePath) {
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c $batchFilePath" -Wait
} else {
    Write-Host "The batch file does not exist at the path: $batchFilePath"
}

Write-Host "Lenovo Apps installed successfully!"
