<#
.SYNOPSIS
Tests parsing TSV clipboard data into HTML table data which is copied back to the clipboard.
#>

if((Test-Path .changes -Type Leaf) -and
	!@(Get-Content .changes |Get-Item |Select-Object -ExpandProperty Name |
		Where-Object {$_.StartsWith("$(($MyInvocation.MyCommand.Name -split '\.',2)[0]).")})) {return}
$preamble = @'
Version:0.9{0}
StartHTML:000000185{0}
EndHTML:000000510{0}
StartFragment:000000285{0}
EndFragment:000000478{0}
StartSelection:000000285{0}
'@ -f (' '*6)
BeforeAll {
	Set-StrictMode -Version Latest
	$module = Get-Item "$PSScriptRoot/../src/.publish/*.psd1"
	Import-Module $module -Force
}
#TODO: Need to figure out why the testing fails.
Describe 'Convert-ClipboardTsvToHtml (Windows)' -Tag Convert-ClipboardTsvToHtml -Skip:$true {
	Context 'Parses TSV clipboard data into HTML table data which is copied back to the clipboard' `
		-Tag ConvertClipboardTsvToHtml,Convert,ClipboardTsv,Clipboard,Tsv,Html {
		It "Should convert '<TsvData>' to '<HtmlData>'" -TestCases @(
@{ TsvData = @"
Id`tName
1`tFirst
2`tSecond
3`tThird
"@ -split '\r?\n'; HtmlData = @"
$preamble
EndSelection:000000478
<!DOCTYPE HTML  PUBLIC "-//W3C//DTD HTML 4.0  Transitional//EN">
<html><body><!--StartFragment--><table>
<colgroup><col/><col/></colgroup>
<tr><th>Id</th><th>Name</th></tr>
<tr><td>1</td><td>First</td></tr>
<tr><td>2</td><td>Second</td></tr>
<tr><td>3</td><td>Third</td></tr>
</table><!--EndFragment--></body></html>
"@ }
@{ TsvData = @(
	[pscustomobject]@{ Name = 'New Year''s Day (observed)'; Date = '2023-01-02' }
	[pscustomobject]@{ Name = 'Martin Luther King, Jr Day'; Date = '2023-01-16' }
	[pscustomobject]@{ Name = 'Washington''s Birthday'; Date = '2023-02-20' }
) |ConvertTo-Csv -Delimiter "`t" -UseQuotes AsNeeded; HtmlData = @"
$preamble
EndSelection:000000571
<!DOCTYPE HTML  PUBLIC "-//W3C//DTD HTML 4.0  Transitional//EN">
<html><body><!--StartFragment--><table>
<colgroup><col/><col/></colgroup>
<tr><th>Name</th><th>Date</th></tr>
<tr><td>New Year&#39;s Day (observed)</td><td>2023-01-02</td></tr>
<tr><td>Martin Luther King, Jr Day</td><td>2023-01-16</td></tr>
<tr><td>Washington&#39;s Birthday</td><td>2023-02-20</td></tr>
</table><!--EndFragment--></body></html>
"@ }
		) {
			Param([string[]] $TsvData, [string] $HtmlData)
			Set-Clipboard -Value $TsvData
			Convert-ClipboardTsvToHtml
			$result = Invoke-WindowsPowerShell {"$((Get-Clipboard -Format Text -TextFormatType Html) -join "`r`n")"}
			$result |Should -Be $HtmlData
		}
	}
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
	Remove-Module $module.BaseName -Force
}
