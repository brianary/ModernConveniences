<#
.SYNOPSIS
Tests creating a backup as a sibling to a file, with date and time values in the name.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Describe 'Backup-File' -Tag Backup-File {
	BeforeEach {
		Push-Location TestDrive:\
	}
	AfterEach {
		Pop-Location
	}
	Context 'Simple backup' -Tag BackupFile,Backup,File {
		It 'Should create a backup as a sibling to a file, with date and time values in the name' {
			"$(New-Guid)" |Out-File logfile.log
			Backup-File logfile.log
			'logfile.log' |Should -Exist
			$null,$backup = Get-Item logfile*.log |Sort-Object {$_.Name.Length}
			$backup |Should -HaveCount 1 -Because 'another file with a longer name should exist'
			$backup.FullName |Should -Exist -Because 'the file should exist'
			$backup.Name |Should -Match '\Alogfile-\d{14}\.log\z' -Because 'the backup file should include the date & time'
		}
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
