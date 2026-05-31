<#
.SYNOPSIS
Tests converting an integer Unix (POSIX) time (seconds since Jan 1, 1970) into a DateTime value.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Describe 'ConvertFrom-EpochTime' -Tag ConvertFrom-EpochTime {
	Context 'Converts an integer Unix (POSIX) time (seconds since Jan 1, 1970) into a DateTime value' `
		-Tag ConvertFromEpochTime,ConvertFrom,Convert,EpochTime {
		It "Epoch time '<EpochTime>' is converted to '<Result>'" -TestCases @(
			@{ EpochTime = 946684800; Result = '2000-01-01' }
			@{ EpochTime = 1012615322; Result = '2002-02-02T02:02:02' }
			@{ EpochTime = 1645568542; Result = '2022-02-22T22:22:22' }
			@{ EpochTime = 0; Result = '1970-01-01' }
			@{ EpochTime = 663486600; Result = '1991-01-10T05:50' }
		) {
			Param([int] $EpochTime, [datetime] $Result)
			$EpochTime |ConvertFrom-EpochTime |Should -BeExactly $Result
		}
	}

}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
