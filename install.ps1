# Execute as Administrator, in folder containing Pbx_simple.exe and config.json
$ErrorActionPreference = 'Stop'
$root = 'C:\Pbx_simple'
New-Item -ItemType Directory -Path $root -Force | Out-Null
Copy-Item "$PSScriptRoot\Pbx_simple.exe" "$root\Pbx_simple.exe" -Force
if (!(Test-Path "$root\config.json")) {
    if (Test-Path "$PSScriptRoot\config.json") { Copy-Item "$PSScriptRoot\config.json" "$root\config.json" }
    else { Copy-Item "$PSScriptRoot\config.example.json" "$root\config.json"; Write-Warning 'Change passwords in C:\Pbx_simple\config.json before starting.'; exit 1 }
}
New-NetFirewallRule -DisplayName 'Pbx_simple SIP UDP 5060' -Direction Inbound -Protocol UDP -LocalPort 5060 -Action Allow -Profile Private -ErrorAction SilentlyContinue | Out-Null
$action=New-ScheduledTaskAction -Execute "$root\Pbx_simple.exe" -Argument '-config "C:\Pbx_simple\config.json"' -WorkingDirectory $root
$trigger=New-ScheduledTaskTrigger -AtStartup
$settings=New-ScheduledTaskSettingsSet -RestartCount 10 -RestartInterval (New-TimeSpan -Minutes 1) -ExecutionTimeLimit (New-TimeSpan -Seconds 0)
Register-ScheduledTask -TaskName 'Pbx_simple' -Action $action -Trigger $trigger -Settings $settings -User 'SYSTEM' -RunLevel Highest -Force | Out-Null
Start-ScheduledTask -TaskName 'Pbx_simple'
Write-Host 'Installed. Get-ScheduledTask -TaskName Pbx_simple'
