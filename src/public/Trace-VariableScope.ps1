<#
.SYNOPSIS
Returns details about a variable by name in all available scopes.

.FUNCTIONALITY
PowerShell

.EXAMPLE
Trace-VariableScope result

Name   Value       Type           Scope Description Attributes Options Visibility ModuleName
------ -----       ----           ----- ----------- ---------- ------- ---------- ----------
result LocalValue  System.String      1             {}            None     Public
result ScriptValue System.String      2             {}            None     Public
result ScriptValue System.String Global             {}            None     Public
#>

[CmdletBinding()] Param(
# The name of the variable to find in all available scopes.
[Parameter(Position=0,Mandatory=$true)][string] $Name
)
$depth = Get-PSCallStack |Measure-Object |Select-Object -ExpandProperty Count
foreach($scope in (0..($depth-1))+('Local','Script','Global'))
{
	$variable = Get-Variable $Name -Scope $scope -ErrorAction Ignore
	if($variable)
	{
		[pscustomobject]@{
			Name        = $variable.Name
			Value       = $variable.Value
			Type        = $variable.Value.GetType()
			Scope       = $scope
			Description = $variable.Description
			Attributes  = $variable.Attributes
			Options     = $variable.Options
			Visibility  = $variable.Visibility
			ModuleName  = $variable.ModuleName
		}
	}
}
