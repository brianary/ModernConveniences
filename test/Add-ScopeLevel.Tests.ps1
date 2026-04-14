<#
.SYNOPSIS
Tests conversion of a scope level to account for another call stack level.
#>

$basename = "$(($MyInvocation.MyCommand.Name -split '\.',2)[0])."
$skip = !(Test-Path .changes -Type Leaf) ? $false :
	!@(Get-Content .changes |Get-Item |Select-Object -ExpandProperty Name |Where-Object {$_.StartsWith($basename)})
if($skip) {Write-Information "No changes to $basename" -infa Continue}
$module = Split-Path $PSScriptRoot |Get-ChildItem -Filter *.psd1
Describe 'Add-ScopeLevel' -Tag Add-ScopeLevel,Add,ScopeLevel -Skip:$skip {
	BeforeAll {
		Import-Module $module
	}
	Context 'Convert a scope level to account for another call stack level.' -Tag AddScopeLevel,Add,ScopeLevel {
		It 'Should calculate local scope' {
			Add-ScopeLevel Local |Should -BeExactly '1' -Because 'local is zero scope'
		}
		It 'Should calculate a numeric scope' {
			1..8 |ForEach-Object {Add-ScopeLevel $_ |Should -BeExactly "$($_+1)"}
		}
		It 'Should calulate global scope' {
			Add-ScopeLevel Global |Should -BeExactly Global -Because 'global is the top scope'
		}
	}
}.GetNewClosure()
