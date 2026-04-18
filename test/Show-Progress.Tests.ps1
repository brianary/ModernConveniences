<#
.SYNOPSIS
Tests performing an operation against each item in a collection of input objects, with a progress bar.
#>

if((Test-Path .changes -Type Leaf) -and
	!@(Get-Content .changes |Get-Item |Select-Object -ExpandProperty Name |Where-Object {$_.StartsWith($basename)}))
{return}
BeforeAll {
	Set-StrictMode -Version Latest
	$module = Get-Item "$PSScriptRoot/../src/*.psd1"
	Import-Module $module
}
Describe 'Show-Progress' -Tag Show-Progress,Show,Progress {
	BeforeEach {
		# see https://pester.dev/docs/usage/modules#-modulename
		Mock Write-Progress -ModuleName ModernConveniences
	}
	Context 'Performs an operation against each item in a collection of input objects, with a progress bar' `
		-Tag Show-Progress,Show,Progress {
		It "Displays progress" {
			1..10 |Show-Progress -Activity 'Processing' |Out-Null
			Should -Invoke -ModuleName ModernConveniences -CommandName Write-Progress -Times 10
		}
	}
}
AfterAll {
	Remove-Module $module.BaseName
}
