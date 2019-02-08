$WarningPreference = "SilentlyContinue"

$date = Get-Date -Format yyyy'-'MM'-'dd
$time = Get-Date -Format HH':'mm':'ss
$message = "Hello world from PowerShell ! Today is " + $date + " and it's " + $time + " !"
echo $message

#Write-Host -NoNewLine 'Press any key to continue...';
#$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');