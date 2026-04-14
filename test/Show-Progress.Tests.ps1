<#
.SYNOPSIS
Tests performing an operation against each item in a collection of input objects, with a progress bar.
#>

$basename = "$(($MyInvocation.MyCommand.Name -split '\.',2)[0])."
$skip = !(Test-Path .changes -Type Leaf) ? $false :
	!@(Get-Content .changes |Get-Item |Select-Object -ExpandProperty Name |Where-Object {$_.StartsWith($basename)})
if($skip) {Write-Information "No changes to $basename" -infa Continue}
$module = Split-Path $PSScriptRoot |Get-ChildItem -Filter *.psd1
Describe 'ForEach-Progress' -Tag Show-Progress,Show,Progress -Skip:$skip {
	BeforeAll {
		Import-Module $module
	}
	Context 'Performs an operation against each item in a collection of input objects, with a progress bar' `
		-Tag ForEachProgress,ForEach,Progress {
		It "Displays progress" {
			Mock Write-Progress {}
			1..10 |Show-Progress -Activity 'Processing' {"$_"} {"$_"}
			Assert-MockCalled -CommandName Write-Progress -Times 10
		}
	}
}.GetNewClosure()
