<#
.SYNOPSIS
Tests returning the differences between two dictionaries.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
	$PSStyle.OutputRendering = 'PlainText'
}
Describe 'Compare-Keys' -Tag Compare-Keys {
	Context 'Returns the differences between two dictionaries' -Tag CompareKeys,Compare,Keys {
		$space = ' '
		It "Comparing '<ReferenceDictionary>' to '<DifferenceDictionary>' (including equal keys) should yield '<Result>'" -TestCases @(
			@{
				ReferenceDictionary = @{ A = 1; B = 2; C = 3 }
				DifferenceDictionary = @{ D = 6; C = 4; B = 2 }
				Result = @"
Key    Action ReferenceValue DifferenceValue
---    ------ -------------- ---------------
A     Deleted              1$space
B   Unchanged              2 2
C    Modified              3 4
D       Added                6
"@
			}
		) {
			Param([Collections.IDictionary]$ReferenceDictionary,[Collections.IDictionary]$DifferenceDictionary,[string]$Result)
			(Compare-Keys -ReferenceDictionary $ReferenceDictionary -DifferenceDictionary $DifferenceDictionary -IncludeEqual |
				Sort-Object Key |
				Out-String) -replace '\r' |
				ForEach-Object {$_.Trim()} |
				Should -BeExactly ($Result -replace '\r')
		}
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
	$PSStyle.OutputRendering = 'Ansi'
}
