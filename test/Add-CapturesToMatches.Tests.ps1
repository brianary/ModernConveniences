<#
.SYNOPSIS
Tests adding named capture group values as note properties to Select-String MatchInfo objects.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Describe 'Add-CapturesToMatches' -Tag Add-CapturesToMatches,Select-Xml {
	Context 'Add to regex selection' -Tag AddCapturesToMatches,Add,Captures,Xml {
		It "Value '<Text>' should add '<Name>' and '<Email>'" -TestCases @(
			@{ Text = 'Arthur Dent adent@example.org'; Name = 'Arthur Dent'; Email = 'adent@example.org' }
			@{ Text = 'Tricia McMillan trillian@example.com'; Name = 'Tricia McMillan'; Email = 'trillian@example.com' }
		 ) {
			Param([string]$Text,[string]$Name,[string]$Email)
			$result = $Text |Select-String '^(?<Name>.*?\b)\s*(?<Email>\S+@\S+)$' |Add-CapturesToMatches
			$result.Name |Should -BeExactly $Name -Because 'the name capture should be added'
			$result.Email |Should -BeExactly $Email -Because 'the email capture should be added'
		}
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
