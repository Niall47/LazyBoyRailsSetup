Write-Host "Ensuring admin rights..."
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

$void = docker info 2>$null

If($?){
	cd C:\
	Write-Host "Running: docker-compose build"
	docker-compose build
	cd ..
	Write-Host "Running: docker-compose up -d"
	docker-compose up -d
	Read-Host -Prompt "Press Enter to exit"
} Else {
	Write-Host "Docker is not running. You amateur!"
}
(Read-Host 'Press Enter to continue...')