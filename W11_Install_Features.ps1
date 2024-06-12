# Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
# Created by Jason Prespolis | 5:57 PM 5/25/2024 | for Windows 10/11 Enterprise

# Install .NET Framework 3.5
Enable-WindowsOptionalFeature -Online -FeatureName NetFx3 -All

# Install .NET Framework 4.x (replace 'x' with the specific version you need)
Enable-WindowsOptionalFeature -Online -FeatureName NetFx4 -All

# Install Windows Media Player
Enable-WindowsOptionalFeature -Online -FeatureName WindowsMediaPlayer -All

# Install Microsoft Print to PDF
Enable-WindowsOptionalFeature -Online -FeatureName PrintToPDF

# Install Microsoft XPS Document Writer
Enable-WindowsOptionalFeature -Online -FeatureName Printing-XPSServices-Features

# Install Remote Differential Compression API Support
Enable-WindowsOptionalFeature -Online -FeatureName RDC

# Install SMB Direct
Enable-WindowsOptionalFeature -Online -FeatureName SMBDirect

# Install Work Folders Client
Enable-WindowsOptionalFeature -Online -FeatureName WorkFolders-Client

# Get-SmbServerConfiguration | Select EnableSMB2Protocol

# The output of the command retrieves the list of all features and displays the FeaturesName and Status (either Enable or Disabled) for all of the features in the running operating system.

# Get-WindowsOptionalFeature -Online
Get-WindowsOptionalFeature -Online >Installed_Features_List.txt

# List Only Enabled Optional Features in the Running Operating System
Get-WindowsOptionalFeature -Online | Where {$_.state -eq 'Enabled'} | Select FeatureName >Enabled_Features_List.txt
Get-WindowsOptionalFeature -Online | Where {$_.state -eq 'Enabled'} | Select FeatureName
Notepad Enabled_Features_List.txt

# List Only Disabled Optional Features in the Running Operating System
Get-WindowsOptionalFeature -Online | Where {$_.state -eq 'Disabled'} | Select FeatureName >Disabled_Features_List.txt
# Get-WindowsOptionalFeature -Online | Where {$_.state -eq 'Disabled'} | Select FeatureName
Notepad Disabled_Features_List.txt
