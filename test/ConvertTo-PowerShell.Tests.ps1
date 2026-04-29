<#
.SYNOPSIS
Tests serializing complex content into PowerShell literals.
#>

[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingConvertToSecureStringWithPlainText','',
Justification='These are tests.')] Param()
if((Test-Path .changes -Type Leaf) -and
	!@(Get-Content .changes |Get-Item |Select-Object -ExpandProperty Name |
		Where-Object {$_.StartsWith("$(($MyInvocation.MyCommand.Name -split '\.',2)[0]).")})) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	$module = Get-Item "$PSScriptRoot/../src/.publish/*.psd1"
	Import-Module $module -Force
}
Describe 'ConvertTo-PowerShell' -Tag ConvertTo-PowerShell {
	Context 'Serializes complex content into PowerShell literals.' -Tag ctps,ConvertToPowerShell,Convert,ConvertTo,PowerShell {
		It "Should convert '<Value>' into idiomatic numeric literal '<Result>'" -TestCases @(
			@{ Value = 0x0; Result = '0' }
			@{ Value = 0x1; Result = '1' }
			@{ Value = 0x7; Result = '7' }
			@{ Value = 0xFKB; Result = '15KB' }
			@{ Value = 9E0; Result = '9' }
			@{ Value = 1E0; Result = '1' }
			@{ Value = 4E0LGB; Result = '4LGB' }
			@{ Value = 1E0Y; Result = '1y' }
			@{ Value = 2E2UY; Result = '200uy' }
			@{ Value = 3E1SKB; Result = '30sKB' }
			@{ Value = 6E1USKB; Result = '60usKB' }
			@{ Value = 3E0UGB; Result = '3uGB' }
			@{ Value = 15E3ULPB; Result = '15000ulPB' }
		) {
			Param($Value, [string] $Result)
			$Value |ConvertTo-PowerShell |Should -BeExactly $Result
		}
		It "Should convert JSON '<Value>' into PowerShell literals" -TestCases @(
			@{ Value = 'null'; Result = '$null' }
			@{ Value = '7'; Result = '7L' }
			@{ Value = '"Don''t Panic!"'; Result = "'Don''t Panic!'" }
			@{ Value = '"2000-01-01T00:00:00"'; Result = "[datetime]'2000-01-01T00:00:00'" }
			@{ Value = '[6,9,42]'; Result = "@(`r`n`t6L`r`n`t`t9L`r`n`t`t42L`r`n)" } #TODO: fix indents
			@{ Value = '{}'; Result = "[pscustomobject]@{`r`n`r`n}" }
			@{ Value = '{"a":1,"b":2,"c":{"d":"2017-03-22T20:59:31","e":null}}'; Result = @'
[pscustomobject]@{
	a = 1L
			b = 2L
			c = [pscustomobject]@{
		d = [datetime]'2017-03-22T20:59:31'
			e = $null
	}
}
'@ } #TODO: fix indents
		) {
			Param([string] $Value, [string] $Result)
			$expression = ConvertFrom-Json $Value -NoEnumerate |ConvertTo-PowerShell
			($expression -replace '\r') |Should -BeExactly ($Result -replace '\r')
			Invoke-Expression $expression |ConvertTo-Json -Compress |Should -BeExactly ($Value -replace '\r')
		}
	}
	#TODO: Fix this test.
	Context 'Serializes secure strings secured with a generated key' -Tag ctpsGenerateKey -Skip:$true {
		It "Should generate PowerShell for secure '<Value>', using a generated zero key" -TestCases @(
			@{ Value = 'Test' }
			@{ Value = 'Lorem ipsum dolor' }
		) {
			Param([string] $Value)
			$expression = ConvertTo-SecureString $Value -AsPlainText -Force |
				ConvertTo-PowerShell -GenerateKey |
				Out-String
			$expression |Should -BeLike '*ConvertTo-SecureString*'
			Invoke-Expression $expression |ConvertFrom-SecureString -AsPlainText |Should -BeExactly $Value
		}
	}
	Context 'Serialize secure strings secured with a provided password' -Tag ctpsSecureKey {
		It "Should generate PowerShell for secure '<Value>', using password '<Secret>'" -TestCases @(
			@{ Value = 'Test'; Secret = 'P@ssw0rd' }
			@{ Value = 'Lorem ipsum dolor'; Secret = '$w0rdf1sh' }
		) {
			Param([string] $Value, [string] $Secret)
			$secureKey = ConvertTo-SecureString $Secret -AsPlainText -Force
			$expression = ConvertTo-SecureString $Value -AsPlainText -Force |
				ConvertTo-PowerShell -SecureKey $secureKey |
				Out-String
			$expression |Should -BeLike '*Rfc2898DeriveBytes*'
			$expression |Should -BeLike '*GetBytes*'
			$expression |Should -BeLike '*ConvertTo-SecureString*'
		}
	}
	Context 'Serialize secure strings secured with a credential' -Tag ctpsCredential {
		It "Should generate PowerShell for secure '<Value>', using credential '<Name>' : '<Secret>'" -TestCases @(
			@{ Value = 'Test'; Name = 'user'; Secret = 'P@ssw0rd!' }
			@{ Value = 'Lorem ipsum dolor'; Name = 'apikey'; Secret = '$w0rdF1sh' }
		) {
			Param([string] $Value, [string] $Name, [string] $Secret)
			$credential = New-Object pscredential $Name,(ConvertTo-SecureString $Secret -AsPlainText -Force)
			$expression = ConvertTo-SecureString $Value -AsPlainText -Force |
				ConvertTo-PowerShell -Credential $credential |
				Out-String
			$expression |Should -BeLike '*ConvertTo-SecureString*'
		}
	}
	Context 'Serialize secure strings secured with a provided zero key' -Tag ctpsKeyBytes {
		It "Should generate PowerShell for secure '<Value>', using key bytes '<Secret>'" -TestCases @(
			@{ Value = 'Test'; Secret = 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 }
			@{ Value = 'Lorem ipsum dolor'; Secret = 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 }
		) {
			Param([string] $Value, [byte[]] $Secret)
			$expression = ConvertTo-SecureString $Value -AsPlainText -Force |
				ConvertTo-PowerShell -Key $Secret |
				Out-String
			$expression |Should -BeLike '*ConvertTo-SecureString*'
		}
	}
}
AfterAll {
	Remove-Module $module.BaseName -Force
}
