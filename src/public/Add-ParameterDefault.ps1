<#
.SYNOPSIS
Appends or creates a value to use for the specified cmdlet parameter to use when one is not specified.

.DESCRIPTION
This conveniently sets cmdlet defaults.

.FUNCTIONALITY
Parameters

.INPUTS
System.Object containing a default value to include.

.LINK
Stop-ThrowError

.LINK
Get-Command

.LINK
about_Scopes

.EXAMPLE
Add-ParameterDefault $Local:PSDefaultParameterValues epcsv nti $true

Establishes that the -NoTypeInformation param of the Export-Csv cmdlet will be true if not otherwise specified,
globally for the PowerShell session.

.EXAMPLE
Add-ParameterDefault Select-Xml Namespace @{svg = 'http://www.w3.org/2000/svg'}

Adds the SVG namespace to any existing namespaces used by Select-Xml when none are given explicitly.
#>

[CmdletBinding()][OutputType([System.Management.Automation.DefaultParameterDictionary])] Param(
# The collection of defaults, e.g. $Global:PSDefaultParameterValues or $Local:PSDefaultParameterValues.
[Parameter(Position=0,Mandatory=$true)][System.Management.Automation.DefaultParameterDictionary] $Defaults,
# The name of a cmdlet, function, script, or alias to include a default parameter value for.
[Parameter(Position=1,Mandatory=$true)][ValidateNotNullOrEmpty()][Alias('CmdletName')][string] $CommandName,
# The name or alias of the parameter to include a default value for.
[Parameter(Position=2,Mandatory=$true)][ValidateNotNullOrEmpty()][string] $ParameterName,
# The value to include as a default.
[Parameter(Position=3,Mandatory=$true,ValueFromPipeline=$true)] $Value
)
Begin
{
	$cmd = Get-Command $CommandName -ErrorAction Ignore
	if(!$cmd) {Stop-ThrowError "Could not find command '$CommandName'" -Argument CommandName}
	if($cmd.CommandType -eq 'Alias') {$cmd = Get-Command $cmd.ResolvedCommandName}
	if($cmd.CommandType -notin 'Cmdlet','ExternalScript','Function','Script')
	{Stop-ThrowError "Command '$CommandName' ($($cmd.CommandType)) not supported" -Argument CommandName}
	$name =
		try {"$($cmd.Name):$($cmd.ResolveParameter($ParameterName).Name)"}
		catch {Stop-ThrowError "Could not find parameter '$ParameterName' for cmdlet '$CommandName'" -Argument ParameterName}
}
Process
{
	Write-Verbose "Setting default parameter '$name' to '$Value'"
	if($Defaults.ContainsKey($name)) {$Defaults[$name] += $Value}
	else {$Defaults[$name] = $Value}
	return $Defaults
}
