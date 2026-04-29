<#
.SYNOPSIS
Determines whether both the user and process are interactive.

.OUTPUTS
System.Boolean indicating whether the session is interactive.

.FUNCTIONALITY
PowerShell

.EXAMPLE
Test-Interactive

True
#>

[CmdletBinding()][OutputType([bool])] Param()
[Environment]::UserInteractive -and
    !([Environment]::GetCommandLineArgs() |Where-Object {$_ -ilike '-NonI*'})
