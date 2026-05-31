<#
.SYNOPSIS
Tests selecting named capture group values as note properties from Select-String MatchInfo objects.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
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
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
