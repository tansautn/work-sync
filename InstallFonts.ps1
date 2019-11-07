function installFonts($fontSourceFolder){
    $ssfFonts = 0x14
    $Shell = New-Object -ComObject Shell.Application
    $SystemFontsFolder = $Shell.Namespace($ssfFonts)
    $FontFiles = Get-ChildItem $fontSourceFolder
    $SystemFontsPath = $SystemFontsFolder.Self.Path
    $newItem = 0;
    foreach($FontFile in $FontFiles) {
        # $FontFile will be copied to this path:
        $targetPath = Join-Path $SystemFontsPath $FontFile.Name
        # So, see if target exists...
        if(Test-Path $targetPath){
            #doing nothing, since font is already installed.
        }else{
            #install the font.
            $newItem++;
            $SystemFontsFolder.CopyHere($FontFile.fullname)
        }
    }
    write-host "Installing Fonts Complete";
    write-host "New Fonts : $newItem";
}
$fontSourceFolder = ".\fonts"
installFonts($fontSourceFolder);