<#
.SYNOPSIS
Returns the scope of an installed module.

.FUNCTIONALITY
PowerShell Modules

.INPUTS
System.Object with a "Name" or "ModuleName" property containing a module name.

.OUTPUTS
System.Management.Automation.PSObject with the following properties:
* ModuleName: The name of the module.
* Scope: The value "CurrentUser" if the module is found within $HOME\Documents\PowerShell\Modules, "AllUsers" if found anywhere else.

.EXAMPLE
Get-ModuleScope Detextive

ModuleName Scope
---------- -----
Detextive  CurrentUser

.EXAMPLE
Get-ModuleScope Pester

ModuleName      Version Scope      	 Source
----------      ------- -----      	 ------
Pester          6.0.0   CurrentUser	 PSGallery
platyPS         0.14.2  CurrentUser	 PSGallery
powershell-yaml 0.4.12  CurrentUser	 PSGallery
PSReadLine      2.4.5   AllUsers
#>

[CmdletBinding()][OutputType([string])] Param(
# Specifies names or name patterns of modules that this cmdlet gets. Wildcard characters are permitted.
[Parameter(Position=0,ValueFromPipelineByPropertyName=$true)][Alias('ModuleName')][string] $Name = '*'
)
Begin
{
	$Script:Source = @{}
	Get-PSRepository |ForEach-Object {$Source[$_.Uri] = $_.Name}
}
Process
{
    foreach($moduleName in Get-Module $Name -ListAvailable |Select-Object -ExpandProperty Name -Unique)
    {
        Get-Module $moduleName -ListAvailable -pv module |
            Select-Object -ExpandProperty ModuleBase |
            Split-Path |
            Select-Object -Unique |
            ForEach-Object {$_.StartsWith($HOME) ? 'CurrentUser' : 'AllUsers'} |
            Select-Object -Unique |
            ForEach-Object {[pscustomobject]@{
				ModuleName = $moduleName
				Version    = $module.Version
				Scope      = $_
				Source     = $module.RepositorySourceLocation ? $Source[$module.RepositorySourceLocation] : $null
			}}
    }
}
