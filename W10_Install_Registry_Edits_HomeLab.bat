@echo off

:: Created by Jason Prespolis | 10:25 AM 5/26/2024 | Windows 10/11 Enterprise

:: Echo Disabling_Local_Accounts
Net User Administrator /active:No
Net User DefaultAccount /active:No
Net User Guest /active:No

:: Echo Set RegisteredOwner and RegisteredOrganization
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "RegisteredOwner" /t REG_SZ /d "Scooby-Doo" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "RegisteredOrganization" /t REG_SZ /d "Mystery Incorporated" /f

:: Echo Disable rotating lock screen and subscribed content
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f

:: Echo Add SecurityHealth and WlanPrelogon entries
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /t REG_EXPAND_SZ /d "%windir%\system32\SecurityHealthSystray.exe" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "WlanPrelogon" /t REG_SZ /d "start ms-availablenetworks:" /f

:: Echo Disable Cortana
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f

:: Echo Enable Network icon on Lock and Sign-in screen
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /V DontDisplayNetworkSelectionUI /T REG_DWORD /D 0 /F

:: Echo Disable_ads_on_lock_screen
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V RotatingLockScreenEnabled /T REG_DWORD /D 0 /F
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V RotatingLockScreenOverlayEnabled /T REG_DWORD /D 0 /F
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V SubscribedContent-338387Enabled /T REG_DWORD /D 0 /F

:: Echo Bitlocker Values XTS256
:: ECHO This command modifies the registry value for Operating System Drive (OS) encryption method.
:: ECHO It sets the EncryptionMethodWithXtsOs value to 7, which corresponds to XTS-AES 256-bit encryption.
:: ECHO XTS (XOR-encrypt-XOR) mode with the Advanced Encryption Standard (AES) algorithm is used for this encryption.

reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /V EncryptionMethodWithXtsOs /T REG_DWORD /D 7 /F
reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE /V EncryptionMethodWithXtsFdv" /T REG_DWORD /D 7 /F
reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /V EncryptionMethodWithXtsRdv /T REG_DWORD /D 7 /F

:: ECHO Remove_Ads_Settings - Disable sync provider notifications in File Explorer
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d 0 /f

:: ECHO Remove_Ads_Settings - Disable fun facts, tips, and tricks on the lock screen
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f

:: ECHO Remove_Ads_Settings - Disable suggestions for getting the most out of Windows
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v "ScoobeSystemSettingEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f

:: ECHO Remove_Ads_Settings - Disable personalized ads using the advertising ID
reg DELETE HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo\ /v Id /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f

:: ECHO Remove_Ads_Settings - Disable recommendations for tips, shortcuts, and new apps on the Start Menu
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_IrisRecommendations" /t REG_DWORD /d 0 /f

:: ECHO Disable the Windows welcome experience after updates
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f

:: ECHO Disable Microsoft account-related notifications on the Start Menu
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_AccountNotifications" /t REG_DWORD /d 0 /f

:: ECHO Disable Microsoft online speech recognition
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "AllowInputPersonalization" /t REG_DWORD /d 0 /f

:: Privacy - Disable "Required diagnostic data"
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection /v AllowTelemetry /t REG_DWORD /d 0 /f

:: Privacy - Disable "Tailored experiences"
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableTailoredExperiencesWithDiagnosticData" /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CloudContent" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d 0 /f

:: ECHO Privacy - Disable Diagnostic Tracking Service
sc config DiagTrack start= disabled
sc stop DiagTrack

:: ECHO Privacy - Disable Connected User Experiences and Telemetry Service
sc config dmwappushservice start= disabled
sc stop dmwappushservice

:: ECHO Privacy - Disable Customer Experience Improvement Program
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f

:: ECHO Start button alignment – 0 = Left
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 0 /f


:: 3:54 PM 5/26/2024

:: Privacy - Echo Privacy option 'Let Windows track app launches to improve start and search results' has been disabled.
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackProgs /t REG_DWORD /d 0 /f

:: Privacy - "Let websites provide locally relevant content by accessing my language.
REG ADD "HKCU\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d 1 /f

:: Privacy - "Suggested content in the Settings app has been disabled."
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338393Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353694Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353696Enabled /t REG_DWORD /d 0 /f

:: Privacy - Disable Online Speech Recognition
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Speech\Settings" /v "AllowOnlineSpeechRecognition" /t REG_DWORD /d 0 /f

:: ECHO Privacy - Disable sending Speech, inking, & typing data collection information to Microsoft
reg add HKCU\SOFTWARE\Microsoft\InputPersonalization\ /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f
reg add HKCU\SOFTWARE\Microsoft\InputPersonalization\ /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f
reg add HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore\ /v HarvestContacts /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d 0 /f

:: Privacy - Set "Feedback frequency" to "Never"
REG ADD "HKCU\Software\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f

:: Privacy - Disable "Activity history" privacy option
REG ADD "HKLM\Software\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f
REG ADD "HKLM\Software\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d 0 /f

:: Privacy -  Disable "Allow access to location on this device"
REG ADD "HKLM\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f

:: Privacy -  Disable "Allow apps to access your location"
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f

:: Privacy -  Disable "Allow desktop apps to access your location"
REG ADD "HKLM\Software\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessLocation" /t REG_DWORD /d 0 /f

:: Privacy -Disable "Allow access to user notification on this device"
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_NOTIFICATIONS" /t REG_DWORD /d 0 /f

:: Privacy -Disable "Allow apps to access your notification"
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d 0 /f

:: Privacy -Disable "Allow access to account info on this device"
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /v "Value" /t REG_SZ /d "Deny" /f

:: Privacy -Disable "Allow apps to access your account info"
REG ADD "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d 0 /f
REG ADD "HKLM\Software\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f
REG ADD "HKLM\Software\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d 0 /f

:: Privacy -Disable "Allow apps to access your contacts"
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /v "Value" /t REG_SZ /d "Deny" /f

:: Privacy -Disable "Allow access to calendar on this device"
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /v "Value" /t REG_SZ /d "Deny" /f

:: Privacy -Disable "Allow apps to access your calendar"
REG ADD "HKLM\Software\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCalendar" /t REG_DWORD /d 2 /f

echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!
echo Registry edits applied successfully!