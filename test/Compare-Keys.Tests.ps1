<#
.SYNOPSIS
Tests returning the differences between two dictionaries.
#>

if((Test-Path .changes -Type Leaf) -and
	!@(Get-Content .changes |Get-Item |Select-Object -ExpandProperty Name |
		Where-Object {$_.StartsWith("$(($MyInvocation.MyCommand.Name -split '\.',2)[0]).")})) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	$module = Get-Item "$PSScriptRoot/../src/.publish/*.psd1"
	Import-Module $module -Force
	$initialOutputRendering,$PSStyle.OutputRendering = $PSStyle.OutputRendering,'PlainText'
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
	$PSStyle.OutputRendering = $initialOutputRendering
	Remove-Module $module.BaseName -Force
}
