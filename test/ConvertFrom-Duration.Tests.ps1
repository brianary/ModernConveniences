<#
.SYNOPSIS
Tests parsing a Timespan from a ISO8601 duration string.
#>

if((Test-Path .changes -Type Leaf) -and
	!@(Get-Content .changes |Get-Item |Select-Object -ExpandProperty Name |
		Where-Object {$_.StartsWith("$(($MyInvocation.MyCommand.Name -split '\.',2)[0]).")})) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	$module = Get-Item "$PSScriptRoot/../src/.publish/*.psd1"
	Import-Module $module -Force
}
Describe 'ConvertFrom-Duration' -Tag ConvertFrom-Duration {
	BeforeEach {
		# see https://pester.dev/docs/usage/modules#-modulename
		Mock Write-Warning -ModuleName ModernConveniences
	}
	Context 'Parses a Timespan from a ISO8601 duration string' `
		-Tag ConvertFromDuration,Convert,ConvertFrom,Duration,TimeSpan {
		It "Should parse '<Duration>' as '<TimeSpan>'" -TestCases @(
			@{ Duration = 'PT1S'; TimeSpan = '0:00:01' }
			@{ Duration = 'PT1M'; TimeSpan = '0:01:00' }
			@{ Duration = 'PT1H'; TimeSpan = '1:00:00' }
			@{ Duration = 'P1D'; TimeSpan = '1.0:00:00' }
			@{ Duration = 'P1W'; TimeSpan = '7.0:00:00' }
			@{ Duration = 'P1M'; TimeSpan = '30.0:00:00'; Warnings = 'Adding month(s) as a mean number of days (30.436875).' }
			@{ Duration = 'P1Y'; TimeSpan = '365.0:00:00'; Warnings = 'Adding year(s) as a mean number of days (365.2425).' }
			@{ Duration = 'PT72H10M'; TimeSpan = '3.00:10:00' }
			@{ Duration = 'P90DT8H'; TimeSpan = '90.08:00:00' }
			@{ Duration = 'P3DT48H90M300S'; TimeSpan = '5.01:35:00' }
			@{ Duration = 'P1Y3M2DT8H20M15S'; TimeSpan = '458.08:20:15'
				Warnings = 'Adding year(s) as a mean number of days (365.2425).',
					'Adding month(s) as a mean number of days (30.436875).' }
			@{ Duration = 'P3Y6M4DT12H30M5S'; TimeSpan = '1283.12:30:05'
				Warnings = 'Adding year(s) as a mean number of days (365.2425).',
					'Adding month(s) as a mean number of days (30.436875).' }
		) {
			Param([string]$Duration,[timespan]$TimeSpan,[string[]]$Warnings = @())
			ConvertFrom-Duration $Duration |Should -BeExactly $TimeSpan
			if($Warnings)
			{
				Should -Invoke -ModuleName ModernConveniences -CommandName Write-Warning `
					-Times ($Warnings.Count) -ParameterFilter {$Message -in $Warnings}
			}
		}
	}
}
AfterAll {
	Remove-Module $module.BaseName -Force
}
