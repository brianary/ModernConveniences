<#
.SYNOPSIS
Enables ANSI terminal colors.

.FUNCTIONALITY
Console

.LINK
https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_ansi_terminals

.EXAMPLE
Enable-AnsiColor

Enables ANSI terminal colors.
#>

[CmdletBinding()] Param(
# Enable colors only for host console output.
[switch] $HostOnly
)

$PSStyle.OutputRendering = $HostOnly ? 'Host' : 'Ansi'
