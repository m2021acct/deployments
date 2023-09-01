$logFolder = "C:\Windows\Temp\IT-Diagnostics"
$logFolder | Remove-Item –force –Recurse -EA 'SilentlyContinue'
$($logFolder + '.zip') | Remove-Item –force –Recurse -EA 'SilentlyContinue'
New-Item -ItemType directory -Path $logFolder -EA 'SilentlyContinue'

# Get specific event IDs
get-winevent -FilterHashtable @{"ProviderName"="Microsoft-Windows-Security-Auditing";Id=4624,4625,4776} -ErrorAction SilentlyContinue | Format-List -Property * | Out-String | Out-File $($logFolder + '\Security.log') -Append
get-winevent -logname Microsoft-Windows-RemoteDesktopServices-RdpCoreTS/Operational -ErrorAction SilentlyContinue | Format-List -Property * | Out-String | Out-File $($logFolder + '\RemoteDesktopServices-RdpCoreTS-Operational.log') -Append
get-winevent -logname Microsoft-Windows-RemoteDesktopServices-SessionServices/Operational -ErrorAction SilentlyContinue | Format-List -Property * | Out-String | Out-File $($logFolder + '\RemoteDesktopServices-SessionServices-Operational.log') -Append

Start-Sleep 5

Compress-Archive -Force -Path $logFolder -DestinationPath $($logFolder + '.zip')
# get "C:\Windows\Temp\IT-Diagnostics.zip"
# $logFolder | Remove-Item –force –Recurse -EA 'SilentlyContinue'
# $($logFolder + '.zip') | Remove-Item –force –Recurse -EA 'SilentlyContinue'
