<#
.SYNOPSIS
Tests disabling ANSI terminal colors.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Describe 'Disable-AnsiColor' -Tag Disable-AnsiColor {
	Context 'Disables ANSI terminal colors' -Tag DisableAnsiColor,Disable,AnsiColor {
		It "Sets OutputRendering" {
			Param([string] $OutputRendering)
			$PSStyle.OutputRendering = 'Ansi'
			Disable-AnsiColor
			$PSStyle.OutputRendering |Should -Be 'PlainText'
			Disable-AnsiColor -HostOnly
			$PSStyle.OutputRendering |Should -Be 'Host'
		}
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
