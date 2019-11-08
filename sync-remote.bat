SET mypath=%~dp0
cd /D %mypath%
REM /user:admin %username% powershell
powershell -command "Set-ExecutionPolicy Unrestricted -Scope CurrentUser;Set-ExecutionPolicy Unrestricted" 2>> sync.err.log
git clean -f -d ./fonts/
git checkout -f
git pull origin master
cmd .\on-received.bat