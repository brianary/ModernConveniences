<#
.SYNOPSIS
Returns each element from a collection for the next process in the pipeline, individually.

.INPUTS
Any collection type.

.OUTPUTS
Each item contained in the collection.

.FUNCTIONALITY
Collection

.EXAMPLE
@{A=1;B=2;C=3} |Select-Each |Measure-Object |Select-Object -ExpandProperty Count

3
#>

#Requires -Version 7.3
[CmdletBinding()] Param(
# The collection to return each item from.
[Parameter(ValueFromPipeline=$true)][psobject] $InputObject
)
Process
{
	if(Get-Member -InputObject $InputObject -Type Method -Name GetEnumerator -ErrorAction Ignore)
	{
		return $InputObject.GetEnumerator()
	}
	else
	{
		Write-Warning "Unable to reliably return each item from type '$($null -eq $InputObject ?
			'(null)' : $InputObject.GetType().FullName)'."
		return ($InputObject)
	}
}
