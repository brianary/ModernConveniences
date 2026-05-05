<#
.SYNOPSIS
Returns the parsed PowerShell tokens from a script file.

.FUNCTIONALITY
PowerShell

.INPUTS
System.String containing the path to a file to be parsed.

.OUTPUTS
Management.Automation.Language.Token values parsed from the file.

.LINK
https://learn.microsoft.com/dotnet/api/system.management.automation.language.token

.EXAMPLE
Get-ScriptTokens Get-ScriptTokens.ps1 |Format-Table Kind,TokenFlags,Text

|      Kind              TokenFlags Text
|      ----              ---------- ----
|   Comment      ParseModeInvariant <#…
|   NewLine      ParseModeInvariant …
|   NewLine      ParseModeInvariant …
|  LBracket                    None [
|Identifier TypeName, AttributeName CmdletBinding
...
#>

[CmdletBinding()][OutputType([Management.Automation.Language.Token])] Param(
# The file to parse.
[Parameter(Position=0,Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string] $Path
)
Process
{
	$parseErrors = [Management.Automation.Language.ParseError[]]@()
    $tokens = [Management.Automation.Language.Token[]]@()
	[Management.Automation.Language.Parser]::ParseFile($Path,
		[ref]$tokens, [ref]$parseErrors) |Out-Null
	return $tokens
}
