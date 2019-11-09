. $PSScriptRoot\autoload.ps1
function processPath($srcFonts){
    $newItem = 0;
    $dest = (Resolve-Path $PSScriptRoot\fonts).Path;
    $collection = FontDirObject $srcFonts;
    foreach($FontFile in $collection) {
    #$srcPath = Join-Path $srcFonts $FontFile.Name
        if($FontFile.Name -like "*'*"){
            Write-Host $FontFile.Name " - invalid file name";
            Continue;
        }
        if($true -eq $FontFile.isFontFile){
            $exist = queryFontData $FontFile.regkeyname;
#            $FontFile.regkeyname
            #$FontFile.Name;
            #$FontFile.Name | Get-Member;
            if($FontFile.Name -contains "'"){
                 Write-Host $FontFile.Name;
                 Write-Host "cut me di"
                 Continue;
            }
            if($null -eq $exist){
                try{
                    insertFont $FontFile.regkeyname $FontFile.Name 1
                    $srcPath = Join-Path $srcFonts $FontFile.Name
                    $targetPath = Join-Path $dest $FontFile.Name
                    #                (Test-Path $targetPath)
                    if((Test-Path $targetPath) -eq $false){
                        Copy-Item $FontFile.Path $targetPath
                        $newItem++;
                    }

                }catch{
                    Write-Error "Exception : $_.Exception.ItemName - $_.Exception.Message";
                }
            }else{
                #doing nothing, since font is already copied.
                #                write-host $FontFile.name
#                write-host $FontFile.regkeyname
            }
        }else{
#            Write-Host $FontFile.Name;
#            Write-Host $FontFile.Type;
#            Write-Host $FontFile.Path;
#            $FontFile | Get-Member;
#            exit;
        }
    }
    Write-Host "Copy from $srcFonts complete. Count $newItem new files."
#    Start-Sleep 1000
}
$sysDir = $env:SystemRoot;
$sysFonts = "$sysDir\Fonts";
$localUsr = $env:LOCALAPPDATA
processPath $sysFonts
processPath "$localUsr\Microsoft\Windows\Fonts"