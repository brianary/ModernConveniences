<#
.SYNOPSIS
Returns a list of modules that have upgrades available.

.FUNCTIONALITY
PowerShell Modules

.LINK
Get-ModuleScope

.EXAMPLE
Get-OutdatedModules

Name       Scope       Source    CurrentVersion AvailableVersion
----       -----       ------    -------------- ----------------
Pester     CurrentUser PSGallery 6.0.0          6.0.1
SelectHtml CurrentUser PSGallery 1.0.15         1.1.16
#>

[CmdletBinding()] Param()

Get-Module -ListAvailable |
    Group-Object Name |
    ForEach-Object -Parallel {
        $name, $group = $_.Name, $_.Group
		$module = $_.Group |Sort-Object Version -Descending |Select-Object -First 1
        try
        {[pscustomobject]@{
            Name             = $name
            Scope            = $module.ModuleBase.StartsWith($HOME) ? 'CurrentUser' : 'AllUsers'
			Source           = Get-PSRepository |
				Where-Object Uri -eq $module.RepositorySourceLocation |
				Select-Object -ExpandProperty Name
            CurrentVersion   = $group |Measure-Object Version -Maximum |Select-Object -ExpandProperty Maximum
            AvailableVersion = Find-Module $name -infa Ignore -ErrorAction Stop |
				Measure-Object -Maximum Version |
				Select-Object -ExpandProperty Maximum
        }}
        catch{}
    } |
    Where-Object {$_.CurrentVersion -lt $_.AvailableVersion}
