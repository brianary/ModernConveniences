<#
.SYNOPSIS
Tests comparing the properties of two objects.
#>

$basename = "$(($MyInvocation.MyCommand.Name -split '\.',2)[0])."
$skip = !(Test-Path .changes -Type Leaf) ? $false :
	!@(Get-Content .changes |Get-Item |Select-Object -ExpandProperty Name |Where-Object {$_.StartsWith($basename)})
if($skip) {Write-Information "No changes to $basename" -infa Continue}
$module = Split-Path $PSScriptRoot |Get-ChildItem -Filter *.psd1
Describe 'Compare-Properties' -Tag Compare-Properties -Skip:$skip {
	BeforeAll {
		Import-Module $module
	}
	Context 'Compares the properties of two objects' -Tag CompareProperties,Compare,Properties {
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
}.GetNewClosure()
