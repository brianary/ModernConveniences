<#
.SYNOPSIS
Tests performing an operation against each item in a collection of input objects, with a progress bar.
#>

$srcname = "$([io.path]::DirectorySeparatorChar)$(($MyInvocation.MyCommand.Name -split '\.',2)[0]).ps1"
$skip = !(Test-Path .changes -Type Leaf) ? $false :
	!@(Get-Content .changes |Get-Item |Select-Object -ExpandProperty Name |Where-Object {$_.EndsWith($basename)})
if($skip) {Write-Information "No changes to **$srcname" -infa Continue}
$module = Split-Path $PSScriptRoot |Get-ChildItem -Filter *.psd1
Write-Information "Testing **$srcname from $module" -infa Continue
Describe 'Show-Progress' -Tag Show-Progress,Show,Progress -Skip:$skip {
	BeforeAll {
		Import-Module $module
		# see https://pester.dev/docs/usage/modules#-modulename
		Mock Write-Progress -ModuleName ModernConveniences
	}
	Context 'Performs an operation against each item in a collection of input objects, with a progress bar' `
		-Tag Show-Progress,Show,Progress {
		It "Displays progress" {
			1..10 |Show-Progress -Activity 'Processing' |Out-Null
			Should -Invoke -ModuleName ModernConveniences -CommandName Write-Progress -Times 10
		}
	}
	AfterAll {
		Remove-Module $module.BaseName
	}
}.GetNewClosure()
