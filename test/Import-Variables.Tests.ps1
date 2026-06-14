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
			@{ InputObject = [pscustomobject]@{ "Id$guid" = 1; "Name$guid" = 'Something' } }
		) {
			Param([psobject] $InputObject)
			Import-Variables $InputObject
			$InputObject.PSObject.Properties |
				ForEach-Object {
					Get-Variable $_.Name -ErrorAction Ignore -OutVariable variable |
						Should -BeTrue -Because 'variable should exist'
					$i = 0
					foreach($parent in Get-PSCallStack |Select-Object -Skip 1)
					{
						$where = "$($parent.Command) in $($parent.ScriptName):$($parent.ScriptLineNumber)"
						Get-Variable $_.Name -Scope (++$i) -ErrorAction Ignore |
							Should -Not -BeTrue -Because "'$($_.Name)' variable overshot local scope to $i, $where"
					}
					Get-Variable $_.Name -Scope Local -ErrorAction Ignore |
						Should -BeTrue -Because 'variable should exist in local scope'
					Get-Variable $_.Name -ValueOnly -Scope Local |
						Should -BeExactly $_.Value -Because 'variable value should match'
				}
		}
		$guid = (New-Guid).ToString('N')
		It "should add keys of '<InputObject>' as variables using parameter call" -Skip -TestCases @(
			@{ InputObject = @{ "Id$guid" = 1; "Name$guid" = 'Something' } }
		) {
			Param([psobject] $InputObject)
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
		$guid = (New-Guid).ToString('N')
		It "should add properties of '<InputObject>' as variables using pipeline" -Skip -TestCases @(
			@{ InputObject = [pscustomobject]@{ "Id$guid" = 1; "Name$guid" = 'Something' } }
		) {
			Param([psobject] $InputObject)
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
		$guid = (New-Guid).ToString('N')
		It "should add properties of '<InputObject>' as variables using pipeline" -Skip -TestCases @(
			@{ InputObject = @{ "Id$guid" = 1; "Name$guid" = 'Something' } }
		) {
			Param([psobject] $InputObject)
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
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
