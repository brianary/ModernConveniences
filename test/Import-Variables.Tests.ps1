<#
.SYNOPSIS
Tests creating local variables from a data row or dictionary (hashtable).
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Describe 'Import-Variables' -Tag Import-Variables,Import,Variables {
	Context 'Adds variables from object properties' {
		It "The properties of '<InputObject>' are added as variables using parameter call" -TestCases @(
			@{ InputObject = [pscustomobject]@{ Id = 1; Name = 'Something' } }
		) {
			Param([psobject] $InputObject)
			Import-Variables $InputObject
			$InputObject.PSObject.Properties |
				ForEach-Object {
					Get-Variable $_.Name -ErrorAction Ignore |
						Should -BeTrue -Because 'variable should exist'
					Get-Variable $_.Name -ValueOnly |
						Should -BeExactly $_.Value -Because 'variable value should match'
				}
		}
		It "The properties of '<InputObject>' are added as variables using pipeline" -TestCases @(
			@{ InputObject = [pscustomobject]@{ Id = 1; Name = 'Something' } }
		) {
			Param([psobject] $InputObject)
			$InputObject |Import-Variables
			$InputObject.PSObject.Properties |
				ForEach-Object {
					Get-Variable $_.Name -ErrorAction Ignore |
						Should -BeTrue -Because 'variable should exist'
					Get-Variable $_.Name -ValueOnly |
						Should -BeExactly $_.Value -Because 'variable value should match'
				}
		}
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
