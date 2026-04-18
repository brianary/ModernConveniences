<#
.SYNOPSIS
Tests comparing the properties of two objects.
#>

if((Test-Path .changes -Type Leaf) -and
	!@(Get-Content .changes |Get-Item |Select-Object -ExpandProperty Name |Where-Object {$_.StartsWith($basename)}))
{return}
BeforeAll {
	Set-StrictMode -Version Latest
	$module = Get-Item "$PSScriptRoot/../src/*.psd1"
	Import-Module $module
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
	Remove-Module $module.BaseName
}
