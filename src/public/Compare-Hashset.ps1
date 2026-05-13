<#
.SYNOPSIS
Returns differences between sets.

.FUNCTIONALITY
Set

.OUTPUTS
System.Management.Automation.PSObject with the properties:
* Value: The value found by the comparison.
* SideIndicator: Points left for values only in the reference object,
| points right for values only in the difference object.

.LINK
https://learn.microsoft.com/dotnet/api/system.collections.generic.hashset-1

.EXAMPLE
Compare-Hashset @(1,2,4) @(2,3,4,5)

|Value SideIndicator
|----- -------------
|    1 <=
|    3 =>
|    5 =>

.EXAMPLE
Compare-Hashset @(1,2,4) @(2,3,4,5) -IncludeEqual -ExcludeDifferent

|Value SideIndicator
|----- -------------
|    2 ==
|    4 ==
#>

[CmdletBinding()][OutputType([pscustomobject])] Param(
# The base set to compare.
[Parameter(Position=0,Mandatory=$true)] $ReferenceObject,
# The set to contrast with the base set.
[Parameter(Position=1,Mandatory=$true)] $DifferenceObject,
# Specifies that strings in the set will be compared ignoring case.
[switch] $CaseInsensitive,
# Indicates that differences should be skipped.
[switch] $ExcludeDifferent,
# Indicates that matches should be included.
[switch] $IncludeEqual
)
filter Add-SideIndicator
{
	[CmdletBinding()] Param(
	[Parameter(Position=0,Mandatory=$true)][string] $SideIndicator,
	[Parameter(ValueFromPipeline=$true,Mandatory=$true)] $InputObject
	)
	return [pscustomobject]@{Value=$InputObject;SideIndicator=$SideIndicator}
}
if($ReferenceObject.GetType().Name -ne 'HashSet`1')
{
	$ReferenceObject = $ReferenceObject |ConvertTo-Hashset -CaseInsensitive:$CaseInsensitive
}
if($DifferenceObject.GetType().Name -ne 'HashSet`1')
{
	$DifferenceObject = $DifferenceObject |ConvertTo-Hashset -CaseInsensitive:$CaseInsensitive
}
$refonly = ConvertTo-Hashset @($ReferenceObject) -CaseInsensitive:$CaseInsensitive
$refonly.ExceptWith($DifferenceObject)
$diffonly = ConvertTo-Hashset @($DifferenceObject) -CaseInsensitive:$CaseInsensitive
$diffonly.ExceptWith($ReferenceObject)
if($IncludeEqual)
{
	$both = ConvertTo-Hashset @($ReferenceObject) -CaseInsensitive:$CaseInsensitive
	$both.IntersectWith($DifferenceObject)
	if($ExcludeDifferent) {return @($both |Add-SideIndicator '==')}
	else
	{
		return @($both |Add-SideIndicator '==') + @($refonly |Add-SideIndicator '<=') +
			@($diffonly |Add-SideIndicator '=>')
	}
}
elseif($ExcludeDifferent) {return}
else {return @($refonly |Add-SideIndicator '<=') + @($diffonly |Add-SideIndicator '=>')}
