<#
.SYNOPSIS
Tests replacing the name of each environment variable embedded in the specified string with the string equivalent of the value of the variable, then returns the resulting string.
#>

if((Test-Path .changes -Type Leaf) -and
	!@(Get-Content .changes |Get-Item |Select-Object -ExpandProperty Name |
		Where-Object {$_.StartsWith("$(($MyInvocation.MyCommand.Name -split '\.',2)[0]).")})) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	$module = Get-Item "$PSScriptRoot/../src/.publish/*.psd1"
	Import-Module $module -Force
}
Describe 'Expand-EnvironmentVariables' -Tag Expand-EnvironmentVariables {
	Context 'Replaces the name of each environment variable embedded in the specified string with the string equivalent of the value of the variable, then returns the resulting string' `
		-Tag ExpandEnvironmentVariables,Expand,EnvironmentVariables,EnvVar {
		It "Expands '<String>' to '<Result>'" -TestCases @(Get-ChildItem env: |
			Where-Object Key -ine PATH |
			ForEach-Object {@{ String = "/_/[%$($_.Key)%]\_\"; Result = "/_/[$($_.Value)]\_\" }}
		) {
			Param([string] $String, [string] $Result)
			Expand-EnvironmentVariables $String |Should -Be $Result -Because 'parameter should work'
			$String |Expand-EnvironmentVariables |Should -Be $Result -Because 'pipeline should work'
		}
	}
}
AfterAll {
	Remove-Module $module.BaseName -Force
}
