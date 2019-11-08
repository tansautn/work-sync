function installFonts($fontSourceFolder){
    $ssfFonts = 0x14
    $Shell = New-Object -ComObject Shell.Application
    $SystemFontsFolder = $Shell.Namespace($ssfFonts)
    $FontRegistry = Get-Item "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts";
    $UserFontRegistry = Get-Item "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts";
    $FontFiles = $Shell.NameSpace((Resolve-Path $fontSourceFolder).Path)
    $SystemFontsPath = $SystemFontsFolder.Self.Path
    $newItem = 0;
    foreach($FontFile in $FontFiles.items()) {
        $type = $FontFiles.getDetailsOf($FontFile,2);
        if(($type -eq "OpenType font file") -or ($type -eq "TrueType font file"))
        {
            $fontname = $FontFiles.getDetailsOf($FontFile,21);
            $fonttype = $type.replace(" font file","");
            $regkeyname = "$fontname ($fonttype)";
            $inSystem = $FontRegistry.GetValue($regkeyname)
            $inUser = $UserFontRegistry.GetValue($regkeyname)
            if(($null -eq $inSystem) -and ($null -eq $inUser)){
                # $FontFile will be copied to this path:
                $targetPath = Join-Path $SystemFontsPath $FontFile.Name
                # So, see if target exists...
                if(Test-Path $targetPath){
                    #doing nothing, since font is already installed.
                }else{
                    #install the font.
                    $newItem++;
                    $SystemFontsFolder.CopyHere($FontFile.Path)
                    write-host "Installing $regkeyname";
                }
            }
        }
        write-host "Install Fonts Complete";
        write-host "New Fonts : $newItem";
        }

}
$fontSourceFolder = ".\fonts"
installFonts($fontSourceFolder);