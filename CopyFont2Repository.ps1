function processPath($srcFonts){
    $newItem = 0;
    $dest = ".\fonts";
    $collection = Get-ChildItem -Path $srcFonts;
    foreach($FontFile in $collection) {
        # $FontFile will be copied to this path:
        $targetPath = Join-Path $dest $FontFile.Name
        $srcPath = Join-Path $srcFonts $FontFile.Name
        # So, see if target exists...
        if(Test-Path $targetPath){
            #doing nothing, since font is already installed.
        }else{
            #install the font.
            Copy-Item $srcPath $targetPath
            $newItem++;
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