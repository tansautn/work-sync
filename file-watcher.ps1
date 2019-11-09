$isChange = $false;
$cmMsg = "Update files at $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")";
$dbupdate = git ls-files -d -m -o --exclude-standard --no-empty-directory .\includes\sqllite
$dbupdate
if($dbupdate){
    $isChange = $true;
    git add ./includes/sqllite/db.sqlite
}
#$changes = git status -u -s ./fonts/
#$changes = git ls-files -c -o --exclude-standard --no-empty-directory .\fonts\
$changes = git ls-files -d -m -o --exclude-standard --no-empty-directory .\fonts\
if($changes){
    $isChange = $true;
    $arr = $changes.split("`r`n");
    $arr.Count
    if($arr.Count -gt 0){
        foreach ($filePath in $arr){
            Write-Host "Adding file $filePath to git repository"
            git add $filePath;
            $cmMsg = "$cmMsg`r`n$filePath";
        }
    }
}
if($isChange -eq $true){
        Write-Host commit changes
        git commit -m "$cmMsg" --author "Zuko <tansautn@gmail.com>"
        Write-Host "pulling changes from remote"
        git pull origin master
        Write-Host push changes
        git push origin master --set-upstream
        Write-Host "push complete"
}

