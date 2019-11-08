function insertFont(# Font Name in Registry, ex : Verdana (TrueType)
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String]
        $regkeyname,
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [String]
        $filename,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, Position = 2)]
        [int]
        $status = 1
)
{
    $dbFile = (Resolve-Path $PSScriptRoot\db.sqlite).Path;
    #    $fontDirPath = (Resolve-Path ..\fonts).Path;
    #    $connection = New-SQLiteConnection -DataSource $dbFile;
    #    $shell = New-Object -ComObject Shell.Application;
    #    $fontDir = $shell.namespace($fontDirPath);
    #    return Invoke-SqliteQuery -SQLiteConnection $connection "select * from fonts where regkeyname = '$regkeyname'";
    return Invoke-SqliteQuery -DataSource $dbFile "insert into fonts values(null, '$regkeyname', '$filename', $status)";
}