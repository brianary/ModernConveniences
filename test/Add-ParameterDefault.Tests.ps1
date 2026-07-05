<#
.SYNOPSIS
Tests appending or creating a value to use for the specified cmdlet parameter to use when one is not specified.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Describe 'Add-ParameterDefault' -Tag Add-ParameterDefault,Add,ParameterDefault {
	Context 'Appends or creates a value to use for the specified cmdlet parameter to use when one is not specified.' {
		It "Should set a simple default" {
			function Trace-GcmDefault
			{
				[CmdletBinding()] Param()
				Add-ParameterDefault gcm Type All
				$PSDefaultParameterValues.ContainsKey('Get-Command:CommandType') |
					Should -BeTrue -Because 'defaults should be added after looking up cmdlet and param aliases'
				$PSDefaultParameterValues['Get-Command:CommandType'] |Should -BeExactly All
				Remove-Variable PSDefaultParameterValues -Scope Local -ErrorAction Ignore
			}
			Trace-GcmDefault
		}
		It "Should set a hashtable default" {
			function Add-HashtableDefault
			{
				[CmdletBinding()] Param()
				Add-ParameterDefault Select-Xml Namespace @{'___' = 'urn:ietf:rfc:2648'}
				$PSDefaultParameterValues.ContainsKey('Select-Xml:Namespace') |Should -BeTrue
				$PSDefaultParameterValues['Select-Xml:Namespace'].ContainsKey('___') |Should -BeTrue
				$PSDefaultParameterValues['Select-Xml:Namespace']['___'] |Should -BeExactly 'urn:ietf:rfc:2648'
				Remove-Variable PSDefaultParameterValues -Scope Local -ErrorAction Ignore
			}
			Add-HashtableDefault
		}
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
