<#
.SYNOPSIS
Tests copying objects as an HTML table.
#>

if(!$IsWindows) {return}
if((Test-Path .changes -Type Leaf) -and
	!@(Get-Content .changes |Get-Item |Select-Object -ExpandProperty Name |Where-Object {$_.StartsWith($basename)}))
{return}
BeforeAll {
	Set-StrictMode -Version Latest
	$module = Get-Item "$PSScriptRoot/../src/*.psd1"
	Import-Module $module
}
Describe 'Copy-Html' -Tag Copy-Html,Copy,HTML {
	Context 'Copies objects as an HTML table' {
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

}
AfterAll {
	Remove-Module $module.BaseName
}
