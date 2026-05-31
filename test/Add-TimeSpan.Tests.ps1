<#
.SYNOPSIS
Tests adding a timespan to DateTime values.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Describe 'Add-TimeSpan' -Tag Add-TimeSpan {
	Context 'Adds a timespan to DateTime values.' -Tag AddTimeSpan,Add,TimeSpan {
		It "Should add '<TimeSpan>' to a '<DateTime>' pipeline value and return '<Result>'" -TestCases @(
			@{ TimeSpan = '00:00:30'; DateTime = '2000-01-01'; Result = '2000-01-01T00:00:30' }
			@{ TimeSpan = '00:00:59'; DateTime = '2020-12-31T23:59:00'; Result = '2020-12-31T23:59:59' }
			@{ TimeSpan = '00:00:30'; DateTime = '2010-07-01T00:00:00'; Result = '2010-07-01T00:00:30' }
			@{ TimeSpan = '7'; DateTime = '2000-01-01T00:00:00'; Result = '2000-01-08T00:00:00' }
			@{ TimeSpan = '100'; DateTime = '2020-12-31T23:59:00'; Result = '2021-04-10T23:59:00' }
			@{ TimeSpan = '60'; DateTime = '2010-07-01T00:00:00'; Result = '2010-08-30T00:00:00' }
			@{ TimeSpan = 7; DateTime = '2000-01-01T00:00:00'; Result = '2000-01-01T00:00:00.0000007' }
			@{ TimeSpan = 100; DateTime = '2020-12-31T23:59:00'; Result = '2020-12-31T23:59:00.00001' }
			@{ TimeSpan = 60; DateTime = '2010-07-01T00:00:00'; Result = '2010-07-01T00:00:00.000006' }
		) {
			Param($TimeSpan,[datetime]$DateTime,[datetime]$Result)
			$DateTime |Add-TimeSpan $TimeSpan |Should -Be $Result
		}
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
