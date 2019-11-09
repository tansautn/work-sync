SET mypath=%~dp0
cd /D %mypath%
REM /user:admin %username% powershell
powershell -command "Set-ExecutionPolicy Unrestricted -Scope CurrentUser;Set-ExecutionPolicy Unrestricted" >> sync.log 2>> sync.err.log
powershell %mypath%CopyFont2Repository.ps1 >> sync.log 2>> sync.err.log
powershell %mypath%file-watcher.ps1 >> sync.log 2>> sync.err.log
REM timeout /T -1