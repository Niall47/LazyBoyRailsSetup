Write-Host "Ensuring admin rights..."
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
cd C:\
Write-Host "Running: docker-compose down"
docker-compose down
Write-Host "Success"
Read-Host -Prompt "Press Enter to exit"
