<#
.SYNOPSIS
Tests Enables ANSI terminal colors.
#>

if((Test-Path .changes -Type Leaf) -and
	!@(Get-Content .changes |Get-Item |Select-Object -ExpandProperty Name |
		Where-Object {$_.StartsWith("$(($MyInvocation.MyCommand.Name -split '\.',2)[0]).")})) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	$module = Get-Item "$PSScriptRoot/../src/.publish/*.psd1"
	Import-Module $module -Force
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
	Remove-Module $module.BaseName -Force
}
