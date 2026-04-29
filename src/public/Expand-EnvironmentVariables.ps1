<#
.SYNOPSIS
Replaces the name of each environment variable embedded in the specified string with the string equivalent of the value of the variable, then returns the resulting string.

.FUNCTIONALITY
EnvironmentVariables

.LINK
https://docs.microsoft.com/dotnet/api/system.environment.expandenvironmentvariables

.EXAMPLE
Expand-EnvironmentVariables %SystemRoot%\System32\cmd.exe

C:\WINDOWS\System32\cmd.exe
#>

[CmdletBinding()] Param(
# The string to be expanded.
[Parameter(Position=0,Mandatory=$true,ValueFromPipeline=$true)][string] $Value
)
Process { return [Environment]::ExpandEnvironmentVariables($Value) }
