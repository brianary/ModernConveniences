<#
.SYNOPSIS
Tests encoding text as XML/HTML, escaping all characters outside 7-bit ASCII.
#>

if((Test-Path .changes -Type Leaf) -and
	!@(Get-Content .changes |Get-Item |Select-Object -ExpandProperty Name |Where-Object {$_.StartsWith($basename)}))
{return}
BeforeAll {
	Set-StrictMode -Version Latest
	$module = Get-Item "$PSScriptRoot/../src/*.psd1"
	Import-Module $module -Force
}
Describe 'ConvertTo-SafeEntities' -Tag ConvertTo-SafeEntities,ConvertTo,Convert,SafeEntities,Entities,HTML,XML {
	Context 'Encode text as XML/HTML, escaping all characters outside 7-bit ASCII' {
		It "Should convert '<Value>' to '<Result>'" -TestCases @(
			@{ Value = "$([Text.Rune]0x1F4A1) File $([char]0x2192) Save"; Result = '&#x1F4A1; File &#x2192; Save' }
			@{ Value = "$([char]0xD83D)$([char]0xDCA1) File $([char]0x2192) Save"; Result = '&#x1F4A1; File &#x2192; Save' }
			@{ Value = "ETA: $([char]0xBD) hour"; Result = 'ETA: &#xBD; hour' }
			@{ Value = "$([Text.Rune]0x1F41B) fix bug"; Result = '&#x1F41B; fix bug' }
			@{ Value = "$([char]0xD83D)$([char]0xDC1B) fix bug"; Result = '&#x1F41B; fix bug' }
			@{ Value = "$([Text.Rune]0x1F9EA) new test"; Result = '&#x1F9EA; new test' }
			@{ Value = "$([char]0xD83E)$([char]0xDDEA) new test"; Result = '&#x1F9EA; new test' }
		) {
			Param([string] $Value, [string] $Result)
			$Value |ConvertTo-SafeEntities |Should -BeExactly $Result -Because 'pipeline should work'
			ConvertTo-SafeEntities $Value |Should -BeExactly $Result -Because 'parameter should work'
		}
	}
}
AfterAll {
	Remove-Module $module.BaseName -Force
}
