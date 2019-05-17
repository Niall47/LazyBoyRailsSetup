@echo off
title Device Guard Manager

goto check_Permissions

:check_Permissions
    echo Detecting permissions...

    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
		for /f "delims=hypervisorlaunchtype" %%a in ('bcdedit /v') do set "status=%%a"
			If /I "%status%"=="    A" goto on
			If /I "%status%"=="    off" goto off
    ) else (
        echo Failure: You need to run me as admin.
    )

:off
@echo Device Guard is currently is disabled
@echo This means VMWare should run and Docker is disabled
goto ask

:on
@echo Device Guard is currently is enabled
@echo This means that Docker should run and VMWare is disabled
goto ask

:ask
@echo Should I [D]isable or [E]nable Device Guard?
set INPUT=
set /P INPUT=Type(D or E): %=%
If /I "%INPUT%"=="d" goto disable 
If /I "%INPUT%"=="e" goto enable
goto ask

:disable
@echo Disabling Device Guard & Docker startup launcher
bcdedit /set hypervisorlaunchtype off
REG DELETE HKCU\Software\Microsoft\Windows\CurrentVersion\Run /f /v "Docker for Windows"
@echo Device Guard is now off, please reboot for changes to take effect!
goto reboot

:enable
@echo Enabling Device Guard & Docker startup launcher
bcdedit /set hypervisorlaunchtype Auto
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v "Docker for Windows" /f /t REG_SZ /d "C:\Program Files\Docker\Docker\Docker for Windows.exe"
@echo Device Guard is on, please reboot for changes to take effect!
pause
goto reboot

:reboot
@echo Windows needs to reboot for changes to take effect
@Echo Would you like to reboot? [Y/N]
set INPUT =
set /P INPUT=Type(Y or N): %=%
If /I "%INPUT%"=="y" goto rebooting
If /I "%INPUT%"=="n" goto exit

:rebooting
SHUTDOWN -r -t 5


:exit
pause
exit