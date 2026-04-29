<#
.SYNOPSIS
Tests disabling ANSI terminal colors.
#>

if((Test-Path .changes -Type Leaf) -and
	!@(Get-Content .changes |Get-Item |Select-Object -ExpandProperty Name |
		Where-Object {$_.StartsWith("$(($MyInvocation.MyCommand.Name -split '\.',2)[0]).")})) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	$module = Get-Item "$PSScriptRoot/../src/.publish/*.psd1"
	Import-Module $module -Force
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
	Remove-Module $module.BaseName -Force
}
