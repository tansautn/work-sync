/user:admin %username% powershell
powershell -command "Set-ExecutionPolicy Unrestricted -Scope CurrentUser;Set-ExecutionPolicy Unrestricted" 2>> receive.err.log
powershell .\InstallFonts.ps1 2>> receive.err.log