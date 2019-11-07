$ssfFonts = 0x14
$fontSourceFolder = ".\system"
$Shell = New-Object -ComObject Shell.Application
$SystemFontsFolder = $Shell.Namespace($ssfFonts)
$FontFiles = Get-ChildItem $fontSourceFolder
$SystemFontsPath = $SystemFontsFolder.Self.Path

foreach($FontFile in $FontFiles) {
	# $FontFile will be copied to this path:
	$targetPath = Join-Path $SystemFontsPath $FontFile.Name
	# So, see if target exists...
	if(Test-Path $targetPath){
		#doing nothing, since font is already installed.
	}else{
		#install the font.
		$SystemFontsFolder.CopyHere($FontFile.fullname)
	}
}
write-host "Installing Fonts Complete"; sleep -m 10000
