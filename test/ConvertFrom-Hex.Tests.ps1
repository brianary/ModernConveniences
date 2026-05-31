<#
.SYNOPSIS
Tests converting a string of hexadecimal digits into a byte array.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Describe 'ConvertFrom-Hex' -Tag ConvertFrom-Hex {
	Context 'Convert a string of hexadecimal digits into a byte array' -Tag ConvertFromHex,Convert,ConvertFrom,Hex {
		It "The value '<Value>' should return '<Result>'" -TestCases @(
			@{ Value = 'EF BB BF'; Result = 0xEF,0xBB,0xBF }
			@{ Value = 'c0ffee'; Result = 0xC0,0xFF,0xEE }
			@{ Value = '0x25504446'; Result = 0x25,0x50,0x44,0x46 }
		) {
			Param([string]$Value,[byte[]]$Result)
			ConvertFrom-Hex $Value |Should -BeExactly $Result -Because 'the parameter should work'
			$Value |ConvertFrom-Hex |Should -BeExactly $Result -Because 'pipeline input should work'
		}
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
