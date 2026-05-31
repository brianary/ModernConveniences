<#
.SYNOPSIS
Tests performing an operation against each item in a collection of input objects, with a progress bar.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
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
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
