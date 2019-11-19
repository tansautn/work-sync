$cfgGit = $(git config --global --get user.email);
if($cfgGit -eq $null){
    Write-Host "Set user email git config";
    git config --global user.email "tansautn@gmail.com"
}
$cfgGit2 = $(git config --global --get user.name);
if($cfgGit2 -eq $null){
    Write-Host "Set user name git config";
    git config --global user.name "Zuko"
}

if (Get-Module -ListAvailable -Name PSSQLite) {
    Import-Module PSSQLite
}
else {
    if($PSVersionTable.PSVersion.Major -gt 4){
        Write-Host "Intsalling PS SQLite Module. This will take a few minutes";
        Install-Module PSSQLite -Force -Confirm
    }else{
        Write-Error "Powershell version < 5, could not process auto install. Issue Zuko for manual installing"
        exit
    }
}
. (Resolve-Path $PSScriptRoot\includes\FontDirMethods.ps1).Path
. (Resolve-Path $PSScriptRoot\includes\sqllite\query-font-data.ps1).Path
. (Resolve-Path $PSScriptRoot\includes\sqllite\insert-font-data.ps1).Path