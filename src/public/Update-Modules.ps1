<#
.SYNOPSIS
Cleans up old modules.

.FUNCTIONALITY
PowerShell Modules

.LINK
Uninstall-OldModules.ps1

.EXAMPLE
Update-Modules.ps1

Updates installed modules and purges old versions.
#>

[CmdletBinding()] Param()
Update-Module -Force
Uninstall-OldModules.ps1
