<#
.SYNOPSIS
Returns a list of modules that have upgrades available.

.FUNCTIONALITY
PowerShell Modules

.LINK
Get-ModuleScope

.EXAMPLE
Get-OutdatedModules

Name       Scope       Source    CurrentVersion AvailableVersion Repository
----       -----       ------    -------------- ---------------- ----------
Pester     CurrentUser PSGallery 6.0.0          6.0.1            PSGallery
SelectHtml CurrentUser PSGallery 1.0.15         1.1.16           PSGallery
#>

[CmdletBinding()] Param()

Get-Module -ListAvailable |
    Group-Object Name |
    ForEach-Object -Parallel {
        $name, $group = $_.Name, $_.Group
		$module = $_.Group |Sort-Object Version -Descending |Select-Object -First 1
        try
        {
			$source = Get-PSRepository |
				Where-Object Uri -eq $module.RepositorySourceLocation |
				Select-Object -ExpandProperty Name
			Find-PSResource -Name $name -Type Module -infa Ignore -ErrorAction Stop |
				ForEach-Object {[pscustomobject]@{
					Name             = $name
					Scope            = $module.ModuleBase.StartsWith($HOME) ? 'CurrentUser' : 'AllUsers'
					Source           = $source
					CurrentVersion   = $group |Measure-Object Version -Maximum |Select-Object -ExpandProperty Maximum
					AvailableVersion = $_.Version
					Repository       = $_.Repository
				}}
		}
        catch{}
    } |
    Where-Object {$_.CurrentVersion -lt $_.AvailableVersion}
