<#
.SYNOPSIS
Indicates whether a variable has been defined.

.INPUTS
System.String name of a variable.

.OUTPUTS
System.Boolean indicating whether the variable name is defined.

.FUNCTIONALITY
PowerShell

.LINK
Get-Variable

.EXAMPLE
Test-Variable true

True

.EXAMPLE
Test-Variable ''

False

A variable can't have an empty string for a name.

.EXAMPLE
Test-Variable $null

False

A variable can't have a null name.

.EXAMPLE
Test-Variable null

True

.EXAMPLE
'PSVersionTable','false' |Test-Variable

True
True

.EXAMPLE
'PWD','PID' |Test-Variable -Scope Global

True
True
#>

[CmdletBinding()][OutputType([bool])] Param(
	# A variable name to test the existence of.
	[Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)][AllowEmptyString()][AllowNull()][string] $Name,
	# The scope of the variable to test, Global, Local, Script, or the number of a calling parent context.
	[Parameter(Position = 1)][string] $Scope
)
Process
{
	if ($Name -in $null, '')
	{
		return $false
	}
	elseif (!$Scope)
	{
		if (Get-Variable -Name $Name -ErrorAction Ignore) { return $true }
		Write-Debug "$($MyInvocation.MyCommand.Name): $Name not found in default scope"
		return $false
	}
	else
	{
		$Scope = Add-ScopeLevel $Scope
		if (Get-Variable -Name $Name -Scope $Scope -ErrorAction Ignore) { return $true }
		Write-Debug "$($MyInvocation.MyCommand.Name): $Name not found in $Scope scope"
		return $false
	}
}
