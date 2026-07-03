<#
.SYNOPSIS
Creates local variables from a data row or dictionary (hashtable).

.INPUTS
System.Collections.IDictionary with keys and values to import as variables,
or System.Management.Automation.PSCustomObject with properties to import as variables.

.FUNCTIONALITY
PowerShell

.LINK
https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_scopes#modules

.LINK
https://github.com/PowerShell/PowerShell/issues/27614

.LINK
https://learn.microsoft.com/dotnet/api/system.management.automation.engineintrinsics

.LINK
https://learn.microsoft.com/dotnet/api/system.management.automation.pscmdlet

.LINK
https://learn.microsoft.com/dotnet/api/system.management.automation.sessionstate

.LINK
https://learn.microsoft.com/dotnet/api/system.management.automation.psvariableintrinsics.set

.EXAMPLE
if($line -match '\AProject\("(?<TypeGuid>[^"]+)"\)') {Import-Variables $Matches}

Copies $Matches.TypeGuid to $TypeGuid if a match is found.

.EXAMPLE
Import-Csv |ForEach-Object {$_ |Import-Variables; Write-Host "Properties: $Name $Id $Description"}

Copies field values into $ProductID, $Name, and $ListPrice.

.EXAMPLE
Invoke-RestMethod https://api.github.com/ |Import-Variables -Global ; Invoke-RestMethod $emojis_url

Sets variables from the fields returned by the web service: $current_user_url, $emojis_url, &c.
Then fetches the list of GitHub emojis.
#>

[CmdletBinding()][OutputType([void])] Param(
<#
A hash of string names to any values to set as variables,
or a DataRow or object with properties to set as variables.
Works with DataRows.
#>
[Parameter(Position=0,Mandatory=$true,ValueFromPipeline=$true)][PSObject] $InputObject,
# The type of object members to convert to variables.
[Alias('Type')][Management.Automation.PSMemberTypes] $MemberType = 'Properties',
# The SessionState object to use to import the variables.
[Management.Automation.SessionState] $SessionState = $ExecutionContext.SessionState.Module.GetVariableFromCallersModule('PSCmdlet')?.Value?.SessionState,
# Specifies to create the variables within the global scope.
[switch] $Global,
# Indicates that created variables should be hidden from child scopes.
[switch] $Private
)
Begin
{
	[Management.Automation.ScopedItemOptions] $option = $Private ? 'Private' : 'None'
}
Process
{
	[psvariable[]] $variables = $InputObject -is [Collections.IDictionary] ?
		($InputObject.GetEnumerator() |ForEach-Object {New-Object psvariable $_.Key,$_.Value,$option}) :
		(Get-Member -InputObject $InputObject -MemberType $MemberType |
			Select-Object -ExpandProperty Name |
			ForEach-Object {New-Object psvariable $_,$InputObject.$_,$option})
	if(!$variables) {return}
	if($Global)
	{
		Write-Debug "Globally importing $($variables.Count) items: $($variables.Name -join ', ')"
		$variables |ForEach-Object {Set-Variable $_.Name $_.Value -Option $_.Options -Scope Global}
	}
	elseif(!$SessionState)
	{
		throw 'Missing a SessionState object.'
	}
	else
	{
		$variables |ForEach-Object {$SessionState.PSVariable.Set($_)}
	}
}
