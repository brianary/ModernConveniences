<#
.SYNOPSIS
Cleans up old modules.

.FUNCTIONALITY
PowerShell Modules

.LINK
Uninstall-OldModules

.EXAMPLE
Update-Modules

Updates installed modules and purges old versions.
#>

[CmdletBinding()] Param()
Update-Module -Force
Uninstall-OldModules
