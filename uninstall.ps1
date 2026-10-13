# Execute as Administrator
Stop-ScheduledTask -TaskName 'Pbx_simple' -ErrorAction SilentlyContinue
Unregister-ScheduledTask -TaskName 'Pbx_simple' -Confirm:$false -ErrorAction SilentlyContinue
Get-NetFirewallRule -DisplayName 'Pbx_simple SIP UDP 5060' -ErrorAction SilentlyContinue | Remove-NetFirewallRule
Write-Host 'Task and firewall exception removed; config remains at C:\Pbx_simple'
