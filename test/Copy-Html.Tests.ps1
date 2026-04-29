<#
.SYNOPSIS
Tests copying objects as an HTML table.
#>

if((Test-Path .changes -Type Leaf) -and
	!@(Get-Content .changes |Get-Item |Select-Object -ExpandProperty Name |
		Where-Object {$_.StartsWith("$(($MyInvocation.MyCommand.Name -split '\.',2)[0]).")})) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	$module = Get-Item "$PSScriptRoot/../src/.publish/*.psd1"
	Import-Module $module -Force
}
$linuxClip = $IsLinux ? (Get-Command wl-copy,xclip -Type Application -ErrorAction Ignore) : $false
Describe 'Copy-Html' -Tag Copy-Html,Copy,HTML,Clipboard -Skip:$(!$linuxClip) {
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
			Param([psobject[]] $InputObject, [object] $Result)
			$InputObject |Copy-Html Id,Name
			(Get-Clip -AsHtml |Out-String) -replace '\r' |
				Should -BeLike ($Result -replace '\r') -Because 'pipeline should work'
			Copy-Html Id,Name -InputObject $InputObject
			(Get-Clip -AsHtml |Out-String) -replace '\r' |
				Should -BeLike ($Result -replace '\r') -Because 'parameter should work'
		}
	}

}
AfterAll {
	Remove-Module $module.BaseName -Force
}
