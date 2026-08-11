<#
.SYNOPSIS
Updates modules that have new versions available.

.FUNCTIONALITY
PowerShell Modules

.LINK
Get-OutdatedModules

.EXAMPLE
Update-OutdatedModules

(updates available modules)
#>

[CmdletBinding(ConfirmImpact='High')] Param()
Get-OutdatedModules |
	Where-Object {$PSCmdlet.ShouldProcess($_.Name,"update from $($_.CurrentVersion) to $($_.Version)")} |
	ForEach-Object {Update-PSResource -Repository $_.Repository -TrustRepository -Scope $_.Scope -Name $_.Name}
