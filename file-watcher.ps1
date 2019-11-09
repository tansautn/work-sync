$dbupdate = git ls-files -d -m -o --exclude-standard --no-empty-directory .\includes\sqlite\
$dbupdate
if($dbupdate){
    git add .\includes\sqlite\ --all
}
#$changes = git status -u -s ./fonts/
#$changes = git ls-files -c -o --exclude-standard --no-empty-directory .\fonts\
$changes = git ls-files -d -m -o --exclude-standard --no-empty-directory .\fonts\
if($changes){
    $arr = $changes.split("`r`n");
    $arr.Count
    if($arr.Count -gt 0){
        $cmMsg = "Update files at $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")";
        foreach ($filePath in $arr){
            Write-Host "Adding file $filePath to git repository"
            git add $filePath;
            $cmMsg = "$cmMsg`r`n$filePath";
        }
        Write-Host commit changes
        git commit -m "$cmMsg" --author "Zuko <tansautn@gmail.com>"
        Write-Host "pulling changes from remote"
        git pull origin master
        Write-Host push changes
        git push origin master --set-upstream
        Write-Host "push complete"
    }
}

