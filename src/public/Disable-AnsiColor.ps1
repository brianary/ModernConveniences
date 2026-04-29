<#
.SYNOPSIS
Disables ANSI terminal colors.

.FUNCTIONALITY
Console

.LINK
https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_ansi_terminals

.EXAMPLE
Disable-AnsiColor

Disables ANSI terminal colors.
#>

[CmdletBinding()] Param(
# Disable colors only for text redirected to files.
[switch] $HostOnly
)

$PSStyle.OutputRendering = $HostOnly ? 'Host' : 'PlainText'
