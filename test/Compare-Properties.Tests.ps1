<#
.SYNOPSIS
Tests comparing the properties of two objects.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Describe 'Compare-Properties' -Tag Compare-Properties,Compare,Properties {
	Context 'Compares the properties of two objects' {
		It 'Should find the difference between PSProviders' {
			$diff = Compare-Properties (Get-PSProvider variable) (Get-PSProvider alias) |Sort-Object PropertyName
			$diff.Reference |Should -BeTrue
			$diff.Difference |Should -BeTrue
			$imptype = $diff |Where-Object PropertyName -eq ImplementingType
			$imptype.Value |Should -BeExactly Microsoft.PowerShell.Commands.VariableProvider
			$imptype.DifferentValue |Should -BeExactly Microsoft.PowerShell.Commands.AliasProvider
			$name = $diff |Where-Object PropertyName -eq Name
			$name.Value |Should -BeExactly Variable
			$name.DifferentValue |Should -BeExactly Alias
		}
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
