# Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
# Created by Jason Prespolis | 5:57 PM 5/25/2024 | for Windows 10/11 Enterprise

[CmdletBinding()]
Param ()

# // Get embedded product key
$Key = (Get-WmiObject SoftwareLicensingService).OA3xOriginalProductKey

If ($Key) {
    Write-Host -ForegroundColor Green "Installing embedded product key"
    Invoke-Command -ScriptBlock {& 'cscript.exe' "$env:windir\system32\slmgr.vbs" '/ipk' "$($Key)"}
    Start-Sleep -Seconds 5

    Write-Host -ForegroundColor Green "Activating embedded product key"
    Invoke-Command -ScriptBlock {& 'cscript.exe' "$env:windir\system32\slmgr.vbs" '/ato'}
    Start-Sleep -Seconds 5
}

Else {
    Write-Host -ForegroundColor Red 'No embedded product key found.'
}
