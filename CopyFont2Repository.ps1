. $PSScriptRoot\autoload.ps1
function processPath($srcFonts){
    $newItem = 0;
    $dest = (Resolve-Path $PSScriptRoot\fonts).Path;
    $collection = FontDirObject $srcFonts;
    foreach($FontFile in $collection) {
        if($true -eq $FontFile.isFontFile){
            $exist = queryFontData $FontFile.regkeyname;
            $FontFile.regkeyname
            $exist;
            if($null -eq $exist){
                insertFont "$FontFile.regkeyname" $FontFile.Name 1
                $targetPath = Join-Path "$dest" $FontFile.Name
                $srcPath = Join-Path "$srcFonts" $FontFile.Name
                if((Test-Path $targetPath) -eq $false){
                    Copy-Item $srcPath $targetPath
                    $newItem++;
                }
            }else{
                #doing nothing, since font is already copied.
                #                write-host $FontFile.name
#                write-host $FontFile.regkeyname
            }
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