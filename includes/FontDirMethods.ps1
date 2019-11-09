function FontDirObject(# Font Name in Registry, ex : Verdana (TrueType)
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String]
        $fontDirPath){
    $path = (Resolve-Path $fontDirPath).Path;
    if(Test-Path $path){
        $shell = New-Object -ComObject Shell.Application;
        $fontDir = $shell.namespace($path);
        $dir = $fontDir.items() | Select-Object
        foreach ($file in $dir){
            $type = $fontDir.getDetailsOf($file,2);
            if(($type -eq "OpenType font file") -or ($type -eq "TrueType font file") -or ($type -eq "Font file"))
            {
                $fontname = $fontDir.getDetailsOf($file,21).replace("'","`'");
                $fonttype = $type.replace(" font file","");
                $regkeyname = "$fontname ($fonttype)";
                $file | Add-Member -MemberType NoteProperty -Name isFontFile -Value $true -Force
                $file | Add-Member -MemberType NoteProperty -Name RegKeyName -Value $regkeyname -Force
                $file | Add-Member -MemberType NoteProperty -Name FontType -Value $fonttype -Force
                $file | Add-Member -MemberType NoteProperty -Name FontName -Value $fontname -Force
            }else{
                $file | Add-Member -MemberType NoteProperty -Name isFontFile -Value $false -Force
            }
        }
        return $dir;
    }else{
        throw "Can't pasre source path $fontDirPath. Might it does not exist !";
    }
}

function getFontDirObject(){
    return FontDirObject "$PSScriptRoot\..\fonts";
}

function findFontInRegistry(# Font Name without type
[Parameter(Mandatory = $false, ValueFromPipeline = $true, Position = 0)]
[ValidateNotNullOrEmpty()]
[String]
$fontname){
    $FontRegistry = Get-Item "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts";
    $UserFontRegistry = Get-Item "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts";
    $types = @(" (TrueType)"," (OpenType)","");
    foreach($type in $types){
        $inSystem = $FontRegistry.GetValue("$fontname$type");
        if($null -ne $inSystem){
            return $inSystem;
        }
        $inUser = $UserFontRegistry.GetValue("$fontname$type");
        if($null -ne $inUser){
            return $inUser;
        }
    }
    return $false;
}