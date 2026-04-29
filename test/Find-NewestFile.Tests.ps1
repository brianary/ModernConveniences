<#
.SYNOPSIS
Tests finding the most recent file.
#>

if((Test-Path .changes -Type Leaf) -and
	!@(Get-Content .changes |Get-Item |Select-Object -ExpandProperty Name |
		Where-Object {$_.StartsWith("$(($MyInvocation.MyCommand.Name -split '\.',2)[0]).")})) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	$module = Get-Item "$PSScriptRoot/../src/.publish/*.psd1"
	Import-Module $module -Force
}
Describe 'Find-NewestFile' -Tag Find-NewestFile {
	Context 'Finds the most recent file' -Tag FindNewestFile,Find,NewestFile {
		It "Gets most recent file" {
			0..4 |ForEach-Object {
				'test' |Out-File "TestDrive:/test$_.txt"
				(Get-Item "TestDrive:/test$_.txt").LastWriteTime =
					(Get-Item "TestDrive:/test$_.txt").LastWriteTime.AddMinutes(-$_)
			}
			Get-Item TestDrive:/test*.txt |Find-NewestFile |Should -BeLike '*test0.txt'
		}
	}
}
AfterAll {
	Remove-Module $module.BaseName -Force
}
