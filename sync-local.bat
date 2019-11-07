/user:admin %username% powershell
powershell -command "Set-ExecutionPolicy Unrestricted -Scope CurrentUser;Set-ExecutionPolicy Unrestricted" 2>> sync.err.log
powershell .\CopyFont2Repository.ps1 2>> sync.err.log
powershell .\file-watcher.ps1 2>> sync.err.log
#