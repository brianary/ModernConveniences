<#
.SYNOPSIS
Tests returning a DateTime object from an ISO week date string.
#>

return #TODO: move Format-Date into test body and loop
if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Describe 'ConvertFrom-IsoWeekDate' -Tag ConvertFrom-IsoWeekDate {
	Context 'Returns a DateTime object from an ISO week date string.' `
		-Tag ConvertFromIsoWeekDate,Convert,ConvertFrom,IsoWeekDate {
		It "ISO week date string '<InputObject>' should return DateTime value '<Result>'" -TestCases @(
			0..300 |ForEach-Object {$date = (Get-Date 2000-01-01).AddDays($_*10); @{
				InputObject = Format-Date -Format Iso8601WeekDate -Date $date
				Result = $date
			}}
		) {
			Param([string]$InputObject,[datetime]$Result)
			ConvertFrom-IsoWeekDate $InputObject |Should -Be $Result
		}
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
