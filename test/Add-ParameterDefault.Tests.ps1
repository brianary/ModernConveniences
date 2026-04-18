<#
.SYNOPSIS
Tests appending or creating a value to use for the specified cmdlet parameter to use when one is not specified.
#>

return #TODO
if((Test-Path .changes -Type Leaf) -and
	!@(Get-Content .changes |Get-Item |Select-Object -ExpandProperty Name |Where-Object {$_.StartsWith($basename)}))
{return}
BeforeAll {
	Set-StrictMode -Version Latest
	$module = Get-Item "$PSScriptRoot/../src/*.psd1"
	Import-Module $module
}
Describe 'Add-ParameterDefault' -Tag Add-ParameterDefault,Add,ParameterDefault {
	Context 'Appends or creates a value to use for the specified cmdlet parameter to use when one is not specified.' {
		It "Should set a simple default" {
			$initialCount = $PSDefaultParameterValues.Count
			Add-ParameterDefault gcm Type All -Scope Script
			$PSDefaultParameterValues.Count |Should -BeGreaterThan $initialCount `
				-Because 'the number of defaults should increase after adding one'
			$PSDefaultParameterValues.ContainsKey('Get-Command:CommandType') |
				Should -BeTrue -Because 'defaults should be added after looking up cmdlet and param aliases'
			$PSDefaultParameterValues['Get-Command:CommandType'] |Should -BeExactly All
		}
		It "Should set a hashtable default" {
			Add-ParameterDefault Select-Xml Namespace @{svg = 'http://www.w3.org/2000/svg'}
			$PSDefaultParameterValues.ContainsKey('Select-Xml:Namespace') |Should -BeTrue
			$PSDefaultParameterValues['Select-Xml:Namespace'].ContainsKey('svg') |Should -BeTrue
			$PSDefaultParameterValues['Select-Xml:Namespace']['svg'] |Should -BeExactly 'http://www.w3.org/2000/svg'
		}
	}
}
AfterAll {
	Remove-Module $module.BaseName
}
