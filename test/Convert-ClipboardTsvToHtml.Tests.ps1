<#
.SYNOPSIS
Tests parsing TSV clipboard data into HTML table data which is copied back to the clipboard.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
$linuxClip = $IsLinux ? (Get-Command wl-copy,xclip -Type Application -ErrorAction Ignore) : $false
Describe 'Convert-ClipboardTsvToHtml (Linux)' -Tag Convert-ClipboardTsvToHtml -Skip:$(!$linuxClip) {
	Context 'Parses TSV clipboard data into HTML table data which is copied back to the clipboard' `
		-Tag ConvertClipboardTsvToHtml,Convert,ClipboardTsv,Clipboard,Tsv,Html {
		It "Should convert '<TsvData>' to '<HtmlData>'" -TestCases @(
@{ TsvData = @"
Id`tName
1`tFirst
2`tSecond
3`tThird
"@ -split '\r?\n'; HtmlData = @"
<table>
<colgroup><col/><col/></colgroup>
<tr><th>Id</th><th>Name</th></tr>
<tr><td>1</td><td>First</td></tr>
<tr><td>2</td><td>Second</td></tr>
<tr><td>3</td><td>Third</td></tr>
</table>
"@ }
@{ TsvData = @(
	[pscustomobject]@{ Name = 'New Year''s Day (observed)'; Date = '2023-01-02' }
	[pscustomobject]@{ Name = 'Martin Luther King, Jr Day'; Date = '2023-01-16' }
	[pscustomobject]@{ Name = 'Washington''s Birthday'; Date = '2023-02-20' }
) |ConvertTo-Csv -Delimiter "`t" -UseQuotes AsNeeded; HtmlData = @"
<table>
<colgroup><col/><col/></colgroup>
<tr><th>Name</th><th>Date</th></tr>
<tr><td>New Year&#39;s Day (observed)</td><td>2023-01-02</td></tr>
<tr><td>Martin Luther King, Jr Day</td><td>2023-01-16</td></tr>
<tr><td>Washington&#39;s Birthday</td><td>2023-02-20</td></tr>
</table>
"@ }
		) {
			Param([string[]] $TsvData, [string] $HtmlData)
			Set-Clip -Value $TsvData
			Get-Clip |Should -BeExactly $TsvData
			Convert-ClipboardTsvToHtml
			(Get-Clip |Out-String).Trim() -replace '\r' |Should -Be ($HtmlData -replace '\r')
		}
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
