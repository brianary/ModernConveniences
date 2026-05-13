<#
.SYNOPSIS
Reduces a collection to unique items that can be used for mathematical set operations.

.FUNCTIONALITY
Set

.INPUTS
Values to add to the HashSet.

.LINK
https://learn.microsoft.com/dotnet/api/system.collections.generic.hashset-1

.EXAMPLE
ConvertTo-Hashset -FromCollection @(1,2,6,2)

1
2
6

.EXAMPLE
$set = Get-Values |ConvertTo-Hashset

Returns a hashset of values from the pipeline.
#>

[CmdletBinding()][OutputType([HashSet`1])] Param(
# A collection to build a HashSet from.
[Parameter(ParameterSetName='FromCollection',Position=0,Mandatory=$true)][Collections.IEnumerable] $FromCollection,
# Values from pipeline to build a HashSet from.
[Parameter(ParameterSetName='InputObject',ValueFromPipeline=$true)][object] $InputObject,
# Specifies that strings in the set will be compared ignoring case.
[switch] $CaseInsensitive
)
End
{
	if(${FromCollection}?.GetType()?.Name -eq 'HashSet`1') {return $FromCollection}
	[array] $values = switch($PSCmdlet.ParameterSetName)
	{
		InputObject {@($input)}
		FromCollection {@($FromCollection.GetEnumerator())}
	}
	$type = [System.Collections.Generic.HashSet`1].MakeGenericType($values[0].GetType())
	$set = $CaseInsensitive ?
		[activator]::CreateInstance($type,@([StringComparer]::OrdinalIgnoreCase)) :
		[activator]::CreateInstance($type)
	$values |ForEach-Object {[void]$set.Add($_)}
	return,$set
}
