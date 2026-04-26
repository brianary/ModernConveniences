# VHS https://github.com/charmbracelet/vhs
Output demo.gif
Hide
Set Shell pwsh
Type "Import-Module ../src/ModernConveniences.psd1"
Enter
# don't start with $data or the history will display later
Type "; $data = 1..5; function Process-Data { Param([Parameter(ValueFromPipeline)][int]$i); Process { Start-Sleep -Seconds 1 } End {Write-Host 'Done'} }"
Enter
Type "Clear-History"
Enter
Type "Clear-Host"
Enter
Show
Type "$data |Show-Progress 'Processing data' |Process-Data"
Enter
Sleep 7s
Type "Get-EnumValues DateTimeKind"
Enter
Sleep 3s
