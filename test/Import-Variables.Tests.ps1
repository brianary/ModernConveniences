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
		$guid = (New-Guid).ToString('N')
		It "should add properties of '<InputObject>' as variables using parameter call" -TestCases @(
			@{ InputObject = [pscustomobject]@{ "Id_$guid" = 1; "Name_$guid" = 'Something' } }
		) {
			Param([psobject] $InputObject)
			function Trace-ImportObjectParameter
			{
				[CmdletBinding()] Param([psobject] $InputObject)
				Import-Variables $InputObject
				foreach($prop in $InputObject.PSObject.Properties)
				{
					Get-Variable $prop.Name -ErrorAction Ignore |
						Should -BeTrue -Because 'variable should exist'
					Get-Variable $prop.Name -Scope Local -ErrorAction Ignore |
						Should -BeTrue -Because 'variable should exist in local scope'
					Get-Variable $prop.Name -ValueOnly -Scope Local |
						Should -BeExactly $prop.Value -Because 'variable value should match'
				}
			}
			Trace-ImportObjectParameter $InputObject
			foreach($propname in $InputObject.PSObject.Properties.Name)
			{
				Get-Variable $propname -ErrorAction Ignore |Should -BeNullOrEmpty
			}
		}
		$guid = (New-Guid).ToString('N')
		It "should add keys of '<InputObject>' as variables using parameter call" -TestCases @(
			@{ InputObject = @{ "Id_$guid" = 1; "Name_$guid" = 'Something' } }
		) {
			Param([psobject] $InputObject)
			function Trace-ImportHashtableParameter
			{
				[CmdletBinding()] Param([psobject] $InputObject)
				Import-Variables $InputObject
				$InputObject.GetEnumerator() |
					ForEach-Object {
						Get-Variable $_.Name -ErrorAction Ignore |
							Should -BeTrue -Because 'variable should exist'
						Get-Variable $_.Name -Scope Local -ErrorAction Ignore |
							Should -BeTrue -Because 'variable should exist in local scope'
						Get-Variable $_.Name -ValueOnly -Scope Local |
							Should -BeExactly $_.Value -Because 'variable value should match'
					}
			}
			Trace-ImportHashtableParameter $InputObject
			foreach($key in $InputObject.Keys)
			{
				Get-Variable $key -ErrorAction Ignore |Should -BeNullOrEmpty
			}
		}
		$guid = (New-Guid).ToString('N')
		It "should add properties of '<InputObject>' as variables using pipeline" -TestCases @(
			@{ InputObject = [pscustomobject]@{ "Id_$guid" = 1; "Name_$guid" = 'Something' } }
		) {
			Param([psobject] $InputObject)
			function Trace-ImportObjectPipeline
			{
				[CmdletBinding()] Param([psobject] $InputObject)
				$InputObject |Import-Variables
				$InputObject.PSObject.Properties |
					ForEach-Object {
						Get-Variable $_.Name -ErrorAction Ignore |
							Should -BeTrue -Because 'variable should exist'
						Get-Variable $_.Name -Scope Local -ErrorAction Ignore |
							Should -BeTrue -Because 'variable should exist in local scope'
						Get-Variable $_.Name -ValueOnly -Scope Local |
							Should -BeExactly $_.Value -Because 'variable value should match'
					}
			}
			Trace-ImportObjectPipeline $InputObject
			foreach($propname in $InputObject.PSObject.Properties.Name)
			{
				Get-Variable $propname -ErrorAction Ignore |Should -BeNullOrEmpty
			}
		}
		$guid = (New-Guid).ToString('N')
		It "should add properties of '<InputObject>' as variables using pipeline" -TestCases @(
			@{ InputObject = @{ "Id_$guid" = 1; "Name_$guid" = 'Something' } }
		) {
			Param([psobject] $InputObject)
			function Trace-ImportHashtablePipeline
			{
				[CmdletBinding()] Param([psobject] $InputObject)
				$InputObject |Import-Variables
				$InputObject.GetEnumerator() |
					ForEach-Object {
						Get-Variable $_.Name -ErrorAction Ignore |
							Should -BeTrue -Because 'variable should exist'
						Get-Variable $_.Name -Scope Local -ErrorAction Ignore |
							Should -BeTrue -Because 'variable should exist in local scope'
						Get-Variable $_.Name -ValueOnly -Scope Local |
							Should -BeExactly $_.Value -Because 'variable value should match'
					}
			}
			Trace-ImportHashtablePipeline $InputObject
			foreach($key in $InputObject.Keys)
			{
				Get-Variable $key -ErrorAction Ignore |Should -BeNullOrEmpty
			}
		}
		$guid = (New-Guid).ToString('N')
		It "should add properties of '<InputObject>' as private variables using parameter call" -TestCases @(
			@{ InputObject = [pscustomobject]@{ "Id_$guid" = 1; "Name_$guid" = 'Something' } }
		) {
			Param([psobject] $InputObject)
			function Test-PrivateVariable
			{
				[CmdletBinding()] Param([string] $VarName)
				return [bool](Get-Variable $VarName -ErrorAction Ignore)
			}
			function Trace-ImportObjectParameterPrivate
			{
				[CmdletBinding()] Param([psobject] $InputObject)
				Import-Variables $InputObject -Private
				foreach($prop in $InputObject.PSObject.Properties)
				{
					Get-Variable $prop.Name -ErrorAction Ignore |
						Should -BeTrue -Because 'variable should exist'
					Get-Variable $prop.Name -Scope Local -ErrorAction Ignore |
						Should -BeTrue -Because 'variable should exist in local scope'
					Get-Variable $prop.Name -ValueOnly -Scope Local |
						Should -BeExactly $prop.Value -Because 'variable value should match'
				}
				Test-PrivateVariable $prop.Name |
					Should -BeFalse -Because 'private variable should not be visible within child scopes'
			}
			Trace-ImportObjectParameterPrivate $InputObject
			foreach($propname in $InputObject.PSObject.Properties.Name)
			{
				Get-Variable $propname -ErrorAction Ignore |Should -BeNullOrEmpty
			}
		}
		$guid = (New-Guid).ToString('N')
		It "should add properties of '<InputObject>' as global variables using parameter call" -TestCases @(
			@{ InputObject = [pscustomobject]@{ "Id_$guid" = 1; "Name_$guid" = 'Something' } }
		) {
			Param([psobject] $InputObject)
			function Trace-ImportObjectParameter
			{
				[CmdletBinding()] Param([psobject] $InputObject)
				Import-Variables $InputObject -Global
				foreach($prop in $InputObject.PSObject.Properties)
				{
					Get-Variable $prop.Name -ErrorAction Ignore |
						Should -BeTrue -Because 'variable should exist'
					Get-Variable $prop.Name -Scope Global -ErrorAction Ignore |
						Should -BeTrue -Because 'variable should exist in global scope'
					Get-Variable $prop.Name -ValueOnly -Scope Global |
						Should -BeExactly $prop.Value -Because 'variable value should match'
				}
			}
			Trace-ImportObjectParameter $InputObject
			foreach($propname in $InputObject.PSObject.Properties.Name)
			{
				Get-Variable $propname -ErrorAction Ignore |
					Should -BeTrue -Because 'variable should still exist'
				Get-Variable $propname -Scope Global -ErrorAction Ignore |
					Should -BeTrue -Because 'variable should still exist in global scope'
				Get-Variable $propname -ValueOnly -Scope Global |
					Should -BeExactly $InputObject.$propname -Because 'variable value should still match'
				Remove-Variable $propname -Scope Global
			}
		}
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
