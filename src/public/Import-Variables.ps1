<#
.SYNOPSIS
Creates local variables from a data row or dictionary (hashtable).

.NOTES
Due to a limitation of PowerShell modules, variables may only be imported
into the global namespace.

.INPUTS
System.Collections.IDictionary with keys and values to import as variables,
or System.Management.Automation.PSCustomObject with properties to import as variables.

.FUNCTIONALITY
PowerShell

.LINK
https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_scopes#modules

.EXAMPLE
if($line -match '\AProject\("(?<TypeGuid>[^"]+)"\)') {Import-Variables $Matches}

Copies $Matches.TypeGuid to $TypeGuid if a match is found.

.EXAMPLE
Import-Csv |ForEach-Object {$_ |Import-Variables; Write-Host "Properties: $Name $Id $Description"}

Copies field values into $ProductID, $Name, and $ListPrice.

.EXAMPLE
if($env:ComSpec -match '^(?<ComPath>.*?\\)(?<ComExe>[^\\]+$)'){Import-Variables $Matches -Verbose}

Sets $ComPath and $ComExe from the regex captures if the regex matches.

.EXAMPLE
Invoke-RestMethod https://api.github.com/ |Import-Variables ; Invoke-RestMethod $emojis_url

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
# Indicates that created variables should be hidden from child scopes.
[switch] $Private
)
Begin
{
	$sv = if($Private) {@{Scope='2';Option='Private'}} else {@{Scope='2'}}
}
Process
{
    $isDict = $InputObject -is [Collections.IDictionary]
    [string[]]$vars =
        if($isDict) {$InputObject.Keys |Where-Object {$_ -is [string]}}
        else {Get-Member -InputObject $InputObject -MemberType $MemberType |Select-Object -ExpandProperty Name}
    if(!$vars){return}
    Write-Verbose "Importing $($vars.Count) $(if($isDict){'keys'}else{"$MemberType properties"}): $vars"
    foreach($var in $vars) {Set-Variable $var $InputObject.$var @sv}
}
