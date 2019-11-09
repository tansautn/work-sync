SET mypath=%~dp0
cd /D %mypath%
REM /user:admin %username% powershell
REM powershell -command "Set-ExecutionPolicy Unrestricted -Scope CurrentUser;Set-ExecutionPolicy Unrestricted" 2>> receive.err.log
powershell %mypath%InstallFonts.ps1 >> receive.log 2>> receive.err.log