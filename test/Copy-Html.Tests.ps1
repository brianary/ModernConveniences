<#
.SYNOPSIS
Tests copying objects as an HTML table.
#>

$basename = "$(($MyInvocation.MyCommand.Name -split '\.',2)[0])."
$skip = !$IsWindows -or (!(Test-Path .changes -Type Leaf) ? $false :
	!@(Get-Content .changes |Get-Item |Select-Object -ExpandProperty Name |Where-Object {$_.StartsWith($basename)}))
if($skip) {Write-Information "No changes to $basename" -infa Continue}
$module = Split-Path $PSScriptRoot |Get-ChildItem -Filter *.psd1
Describe 'Copy-Html' -Tag Copy-Html -Skip:$skip {
	BeforeAll {
		Import-Module $module
	}
	Context 'Copies objects as an HTML table' -Tag Copy-Html,Copy,Html {
		It "Should copy objects as HTML" -TestCases @(
			@{ InputObject = '[{Id: 1, Name: "First"}, {Id: 2, Name: "Second"}, {Id: 3, Name: "Third"}]' |ConvertFrom-Json
				Result = @'
*<tr><th>Id</th><th>Name</th></tr>
<tr><td align="right">1</td><td>First</td></tr>
<tr><td align="right">2</td><td>Second</td></tr>
<tr><td align="right">3</td><td>Third</td></tr>
</table>*
'@ }
		) {
			Param([object] $InputObject, [object] $Result)
			$InputObject |Copy-Html Id,Name
			powershell -nol -noni -nop -c "Get-Clipboard -TextFormatType Html" |Out-String |
				Should -BeLikeExactly $Result -Because 'pipeline should work'
			Copy-Html Id,Name -InputObject $InputObject
			powershell -nol -noni -nop -c "Get-Clipboard -TextFormatType Html" |Out-String |
				Should -BeLikeExactly $Result -Because 'parameter should work'
		}
	}

}.GetNewClosure()
