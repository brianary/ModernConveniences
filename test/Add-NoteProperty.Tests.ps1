<#
.SYNOPSIS
Tests adding a NoteProperty to a PSObject, calculating the value with the object in context.
#>

if((Test-Path .changes -Type Leaf) -and
	!@(Get-Content .changes |Get-Item |Select-Object -ExpandProperty Name |Where-Object {$_.StartsWith($basename)}))
{return}
BeforeAll {
	Set-StrictMode -Version Latest
	$module = Get-Item "$PSScriptRoot/../src/*.psd1"
	Import-Module $module -Force
}
Describe 'Add-NoteProperty' -Tag Add-NoteProperty,Add,NoteProperty {
	Context 'Add a calculated property value' {
		It "Should add a property with a static value calculated when added" {
			$value = [pscustomobject]@{x=8} |Add-NoteProperty bits {[math]::Log2($_.x)} -PassThru
			$value.x = 16 # this should not change the pow property
			$value.bits |Should -Be 3 -Because 'the bits property value should have been determined only when added'
		}
		It "Should add multiple properties with a mix of value types" {
			$value = [pscustomobject]@{x=8} |Add-NoteProperty @{
				bits = {[math]::Log2($_.x)}
				format = {'<{0:X}>' -f ($_.x*4)}
				isNumeric = $true
			} -PassThru
			$value.x = 16 # this should not change the pow property
			$value.bits |Should -Be 3 -Because 'the bits property value should be statically evaluated'
			$value.format |Should -Be '<20>' -Because 'the binary property should be statically evaluated'
			$value.isNumeric |Should -BeTrue -Because 'the isNumeric property should be true'
		}
	}
}
AfterAll {
	Remove-Module $module.BaseName -Force
}
