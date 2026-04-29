<#
.SYNOPSIS
Tests selecting named capture group values as note properties from Select-String MatchInfo objects.
#>

if((Test-Path .changes -Type Leaf) -and
	!@(Get-Content .changes |Get-Item |Select-Object -ExpandProperty Name |
		Where-Object {$_.StartsWith("$(($MyInvocation.MyCommand.Name -split '\.',2)[0]).")})) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	$module = Get-Item "$PSScriptRoot/../src/.publish/*.psd1"
	Import-Module $module -Force
}
Describe 'Select-CapturesFromMatches' -Tag Select-CapturesFromMatches {
	Context 'Selects named capture group values as note properties from Select-String MatchInfo objects' `
		-Tag SelectCapturesFromMatches,Select,Captures,Regex {
		It "Should select name '<Name>' and email '<Email>' from '<InputString>' using '<Regex>'" -TestCases @(
			@{ InputString = 'Arthur Dent adent@example.org'; Regex = '^(?<Name>.*?\b)\s*(?<Email>\S+@\S+)$'; Name = 'Arthur Dent'; Email = 'adent@example.org' }
			@{ InputString = 'Tricia McMillan <trillian@example.com>'; Regex = '^(?<Name>.*?\b)\s*<(?<Email>\S+@\S+)>$'; Name = 'Tricia McMillan'; Email = 'trillian@example.com' }
		) {
			Param([string] $InputString, [regex] $Regex, [string] $Name, [string] $Email)
			$captures = $InputString |Select-String $Regex |Select-CapturesFromMatches
			$captures.Name |Should -BeExactly $Name
			$captures.Email |Should -BeExactly $Email
		}
	}
}
AfterAll {
	Remove-Module $module.BaseName -Force
}
