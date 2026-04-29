<#
.SYNOPSIS
Tests converting an object to an ordered dictionary of properties and values.
#>

if((Test-Path .changes -Type Leaf) -and
	!@(Get-Content .changes |Get-Item |Select-Object -ExpandProperty Name |
		Where-Object {$_.StartsWith("$(($MyInvocation.MyCommand.Name -split '\.',2)[0]).")})) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	$module = Get-Item "$PSScriptRoot/../src/.publish/*.psd1"
	Import-Module $module -Force
}
Describe 'ConvertTo-OrderedDictionary' -Tag ConvertTo-OrderedDictionary {
	Context 'Converts an object to an ordered dictionary of properties and values.' `
		-Tag ConvertToOrderedDictionary,Convert,ConvertTo,OrderedDictionary,Dictionary {
		It "Should convert an IO.FileInfo object into a dictionary" {
			$source = Get-ChildItem -File -Force |Select-Object -First 1
			$file = $source |ConvertTo-OrderedDictionary
			$file |Should -BeOfType Collections.IDictionary
			$file.Contains('Name') |Should -BeTrue -Because 'the dictionary should include a Name key'
			$file['Name'] |Should -BeOfType string
			$file['Name'] |Should -Be $source.Name
			$file.Contains('Length') |Should -BeTrue -Because 'the dictionary should include a Length key'
			$file['Length'] |Should -BeOfType long
			$file.Contains('Mode') |Should -BeTrue -Because 'the dictionary should include a Mode key'
			$file['Mode'] |Should -BeOfType string
			$file.Contains('VersionInfo') |Should -BeTrue -Because 'the dictionary should include a VersionInfo key'
			$file['VersionInfo'] |Should -BeOfType Diagnostics.FileVersionInfo
			$file['VersionInfo'].FileName |Should -BeOfType string
			$file.Contains('CreationTime') |Should -BeTrue -Because 'the dictionary should include a CreationTime key'
			$file['CreationTime'] |Should -BeOfType datetime
		}
	}

}
AfterAll {
	Remove-Module $module.BaseName -Force
}
