<#
.SYNOPSIS
Tests creating local variables from a data row or dictionary (hashtable).
#>

if((Test-Path .changes -Type Leaf) -and
	!@(Get-Content .changes |Get-Item |Select-Object -ExpandProperty Name |
		Where-Object {$_.StartsWith("$(($MyInvocation.MyCommand.Name -split '\.',2)[0]).")})) {return}
$PesterPreference = [PesterConfiguration]::Default
$PesterPreference.Debug.WriteDebugMessages = $true
BeforeAll {
	Set-StrictMode -Version Latest
	$module = Get-Item "$PSScriptRoot/../src/.publish/*.psd1"
	Import-Module $module -Force
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
	Remove-Module $module.BaseName -Force
}
