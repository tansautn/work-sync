function queryFontData(# Font Name in Registry, ex : Verdana (TrueType)
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String]
        $regkeyname)
{
    $dbFile = (Resolve-Path $PSScriptRoot\db.sqlite).Path;
#    $fontDirPath = (Resolve-Path ..\fonts).Path;
#    $connection = New-SQLiteConnection -DataSource $dbFile;
#    $shell = New-Object -ComObject Shell.Application;
#    $fontDir = $shell.namespace($fontDirPath);
#    return Invoke-SqliteQuery -SQLiteConnection $connection "select * from fonts where regkeyname = '$regkeyname'";
    return Invoke-SqliteQuery -DataSource $dbFile "select * from fonts where regkeyname = '$regkeyname'";
}