<#
.SYNOPSIS
Runs commands in Windows PowerShell (typically from PowerShell Core).

.FUNCTIONALITY
PowerShell

.LINK
Stop-ThrowError

.EXAMPLE
Invoke-WindowsPowerShell '$PSVersionTable.PSEdition'

Desktop

.EXAMPLE
Invoke-WindowsPowerShell {Param($n); Get-WmiObject Win32_Process -Filter "Name like '$n'" |foreach ProcessName} power%

PowerToys.exe
PowerToys.Awake.exe
PowerToys.FancyZones.exe
PowerToys.KeyboardManagerEngine.exe
PowerLauncher.exe
powershell.exe
powershell.exe

.EXAMPLE
Invoke-WindowsPowerShell { Get-ADDefaultDomainPasswordPolicy }

ComplexityEnabled           : True
DistinguishedName           : DC=fabrikam,DC=com
LockoutDuration             : 00:20:00
LockoutObservationWindow    : 00:20:00
LockoutThreshold            : 3
MaxPasswordAge              : 90.00:00:00
MinPasswordAge              : 2.00:00:00
MinPasswordLength           : 12
objectClass                 : {domainDNS}
objectGuid                  : 1d032086-5e5b-434c-a028-9eba90b663be
PasswordHistoryCount        : 5
ReversibleEncryptionEnabled : False

.EXAMPLE
Invoke-WindowsPowerShell { Get-ADGroupMembers Taskmaster |Select-Object -ExpandProperty Name }

Greg Davies
Alex Horne

.EXAMPLE
Invoke-WindowsPowerShell { Get-ADPrincipalGroupMembership  alexh |Select-Object -ExpandProperty Name }

Taskmaster
The Horne Section
#>

[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidGlobalVars','',
Justification='A global variable is used to cache values.')]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingInvokeExpression','',
Justification='Invoke-Expression is neccessary for the purpose of this script.')]
[CmdletBinding()] Param(
# A script block to run.
[Parameter(ParameterSetName='CommandBlock',Position=0,Mandatory=$true)][scriptblock] $CommandBlock,
# Parameters to the script block.
[Parameter(ParameterSetName='CommandBlock',Position=1,ValueFromRemainingArguments=$true)][psobject[]] $BlockArgs = @(),
# The text of the command to run.
[Parameter(ParameterSetName='CommandText',Position=0,Mandatory=$true)][string] $CommandText
)

if(!$IsWindows) {Stop-ThrowError 'Only supported on Windows.' -OperationContext $PSVersionTable}

if($PSVersionTable.PSEdition -eq 'Desktop')
{
	if($PSCmdlet.ParameterSetName -eq 'CommandText') {Invoke-Expression $CommandText}
	else {$CommandBlock.InvokeReturnAsIs($BlockArgs)}
	return
}

if(!(Get-Command powershell -CommandType Application -ErrorAction Ignore))
{
	${powershell.exe} = "$env:SystemRoot\system32\windowspowershell\v1.0\powershell.exe"
	if(!(Test-Path ${powershell.exe} -Type Leaf))
	{
		Stop-ThrowError 'powershell.exe was not found' -OperationContext ${powershell.exe}
	}
	Set-Alias -Name powershell -Value ${powershell.exe} -Scope Script -Option Private `
		-Description "PowerShell 5 application"
}

if(!(Get-Variable WPSModulePath -Scope Global -ValueOnly -ErrorAction Ignore))
{
	$addmodules = @()
	if('C:\Windows\System32\WindowsPowerShell\v1.0\Modules\' -notin ($env:PSModulePath -split ';'))
	{ $addmodules += 'C:\Windows\System32\WindowsPowerShell\v1.0\Modules\' }
	if("C:\Users\$env:UserName\Documents\WindowsPowerShell\Modules\" -notin ($env:PSModulePath -split ';'))
	{ $addmodules += "C:\Users\$env:UserName\Documents\WindowsPowerShell\Modules\" }
	$Global:WPSModulePath = if($addmodules.Count) {"$($addmodules -join ';');$env:PSModulePath"} else {$env:PSModulePath}
}
$PSModulePath = $env:PSModulePath # save current module path
$env:PSModulePath = $Global:WPSModulePath # use Windows PowerShell module path
if($PSCmdlet.ParameterSetName -eq 'CommandText')
{
	$CommandText |& "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -NonInteractive -Command -
}
else
{
	if($Host.Name -eq 'Visual Studio Code Host')
	{
		Stop-ThrowError 'ScriptBlocks not supported by VSCode prompt' -OperationContext $CommandBlock
	}
	& "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -NonInteractive `
		-Command $CommandBlock -args $BlockArgs
}
$env:PSModulePath = $PSModulePath # restore module path
