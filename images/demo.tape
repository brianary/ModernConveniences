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
Sleep 2s
Type "Write-Info 'Completed ' -ForegroundColor Cyan -NoNewline ; Write-Info '#1' -fg Blue"
Enter
Sleep 2s
Type "17179869184 |Format-ByteUnits"
Enter
Sleep 2s
Type "Get-RandomBytes 16 |Format-Hex"
Enter
Sleep 2s
Type "Test-Administrator"
Enter
Sleep 2s
Type "Format-Permutations 'srv-{0}-{1}' dev,test,prod (1..3)"
Enter
Sleep 2s
Type "'📟️ pager' |ConvertTo-SafeEntities"
Enter
Sleep 2s
