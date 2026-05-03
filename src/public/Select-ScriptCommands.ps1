<#
.SYNOPSIS
Returns the commands used by the specified script.

.FUNCTIONALITY
Scripts

.INPUTS
System.String containing the path to a script file to parse.

.OUTPUTS
System.Management.Automation.PSCustomObject with these properties:

* CommandName: The text used as the name of the command.
* CommandType: The specific kind of command.
* Tokens: A System.Management.Automation.Language.Token list, each containing an Extent
  (System.Management.Automation.Language.IScriptExtent) value for where this command was found.

.LINK
https://learn.microsoft.com/dotnet/api/system.management.automation.language.parser.parsefile

.LINK
Get-Command

.EXAMPLE
Select-ScriptCommands Select-ScriptCommands.ps1 |Format-Table -AutoSize

CommandName        CommandType Tokens
-----------        ----------- ------
ForEach-Object          Cmdlet {ForEach-Object}
Get-Command             Cmdlet {Get-Command}
Get-ScriptCommands      Filter {Get-ScriptCommands}
Group-Object            Cmdlet {Group-Object}
Out-Null                Cmdlet {Out-Null}
Resolve-Path            Cmdlet {Resolve-Path}
Where-Object            Cmdlet {Where-Object, Where-Object}
#>

[CmdletBinding()][OutputType([System.Management.Automation.CommandInfo])] Param(
# A script file path (wildcards are accepted).
[Parameter(Position=0,ValueFromPipeline=$true)][string] $Path,
# Specifies the types of commands that this cmdlet gets.
[Alias('Type')][Management.Automation.CommandTypes] $CommandType
)
Begin
{
    $Script:parseErrors = [Management.Automation.Language.ParseError[]]@()
    $Script:tokens = [Management.Automation.Language.Token[]]@()
    filter Get-ScriptCommands
    {
        [CmdletBinding()] Param(
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string] $Path
        )
		Write-Debug "$($MyInvocation.MyCommand.Name): Scanning '$Path'"
        [Management.Automation.Language.Parser]::ParseFile($Path,
            [ref]$Script:tokens, [ref]$Script:parseErrors) |Out-Null
        $commands = $Script:tokens |
            Where-Object {$_.TokenFlags -band [Management.Automation.Language.TokenFlags]::CommandName} |
            Group-Object Text |
			ForEach-Object {
				$cmd = Get-Command $_.Name -ErrorAction Ignore ||
					[pscustomobject]@{ Name = $_.Name; CommandType = $_.Name -like '*.ps1' ? `
						[Management.Automation.CommandTypes]::ExternalScript : [Management.Automation.CommandTypes]::All }
				[pscustomobject]@{
					CommandName = $cmd.Name
					CommandType = $cmd.CommandType
					Tokens      = $_.Group
				}
			}
        return !$CommandType ? $commands : ($commands |Where-Object CommandType -eq $CommandType)
    }
}
Process
{
    Resolve-Path $Path |Get-ScriptCommands
}
