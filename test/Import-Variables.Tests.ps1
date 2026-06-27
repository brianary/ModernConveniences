<#
.SYNOPSIS
Tests creating local variables from a data row or dictionary (hashtable).
#>

return #TODO: Find a way to test this within a Pester test.
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
			Import-Variables $InputObject -db
			$callstack = @(Get-PSCallStack)
			foreach($prop in $InputObject.PSObject.Properties)
			{
				Get-Variable $prop.Name -ErrorAction Ignore -OutVariable variable |
					Should -BeTrue -Because 'variable should exist'
				# for($i = 1; $i -lt $callstack.Count; $i++)
				# {
				# 	$where = "$($callstack[$i].Command) in $($callstack[$i].ScriptName):$($callstack[$i].ScriptLineNumber)"
				# 	Get-Variable $prop.Name -Scope "$i" -ErrorAction Ignore |
				# 		Should -Not -BeTrue -Because "'$($prop.Name)' variable overshot local scope to $i, $where"
				# }
				Get-Variable $prop.Name -Scope Local -ErrorAction Ignore |
					Should -BeTrue -Because 'variable should exist in local scope'
				Get-Variable $prop.Name -ValueOnly -Scope Local |
					Should -BeExactly $prop.Value -Because 'variable value should match'
			}
		}
		$guid = (New-Guid).ToString('N')
		It "should add keys of '<InputObject>' as variables using parameter call" -Skip -TestCases @(
			@{ InputObject = @{ "Id_$guid" = 1; "Name_$guid" = 'Something' } }
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
			@{ InputObject = [pscustomobject]@{ "Id_$guid" = 1; "Name_$guid" = 'Something' } }
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
			@{ InputObject = @{ "Id_$guid" = 1; "Name_$guid" = 'Something' } }
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
