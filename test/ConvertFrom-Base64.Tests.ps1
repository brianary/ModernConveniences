<#
.SYNOPSIS
Tests converting base64-encoded text to bytes or text.
#>

if((Test-Path .changes -Type Leaf) -and
	!@(Get-Content .changes |Get-Item |Select-Object -ExpandProperty Name |
		Where-Object {$_.StartsWith("$(($MyInvocation.MyCommand.Name -split '\.',2)[0]).")})) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	$module = Get-Item "$PSScriptRoot/../src/.publish/*.psd1"
	Import-Module $module -Force
}
Describe 'ConvertFrom-Base64' -Tag ConvertFrom-Base64 {
	Context 'Converts base64-encoded text to bytes or text' -Tag ConvertFromBase64,Convert,ConvertFrom,Base64 {
		It "Should parse a standard base-64 string as parameter" {
			ConvertFrom-Base64 dXNlcm5hbWU6QmFkUEBzc3dvcmQ= -Encoding utf8 |
				Should -BeExactly 'username:BadP@ssword'
		}
		It "Should parse a URI-style base-64 string from pipeline" {
			'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9' |
				ConvertFrom-Base64 -Encoding ascii -UriStyle |
				Should -BeExactly '{"alg":"HS256","typ":"JWT"}'
		}
		It "Should parse a base-64 string from pipeline as a byte array" {
			'77u/dHJ1ZQ0K' |
				ConvertFrom-Base64 |
				Should -BeExactly ([byte[]]@(0xEF,0xBB,0xBF,0x74,0x72,0x75,0x65,0x0D,0x0A))
		}
	}
}
AfterAll {
	Remove-Module $module.BaseName -Force
}
