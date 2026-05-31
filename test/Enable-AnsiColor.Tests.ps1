<#
.SYNOPSIS
Tests Enables ANSI terminal colors.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Describe 'Enable-AnsiColor' -Tag Enable-AnsiColor {
	Context 'Enables ANSI terminal colors.' -Tag EnableAnsiColor,Enable,AnsiColor {
		It "Sets OutputRendering" {
			Param([string] $OutputRendering)
			$PSStyle.OutputRendering = 'PlainText'
			Enable-AnsiColor -HostOnly
			$PSStyle.OutputRendering |Should -Be 'Host'
			Enable-AnsiColor
			$PSStyle.OutputRendering |Should -Be 'Ansi'
		}
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
