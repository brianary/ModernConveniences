<#
.SYNOPSIS
Rounds off a number to the requested number of digits.

.INPUTS
System.Decimal or System.Double or other numeric type that is implicitly convertible
to those types.

.OUTPUTS
System.Decimal or System.Double depending on input type.

.FUNCTIONALITY
Data

.EXAMPLE
[math]::PI |Limit-Digits 4

3.1416

.EXAMPLE
1.5 |Limit-Digits -Mode ToZero

1
#>

[CmdletBinding()] Param(
# The number of digits following the decimal to truncate the value to.
[Parameter(Position=0)][int] $Digits = 0,
# A numeric value to round off.
[Parameter(Position=1,Mandatory=$true,ValueFromPipeline=$true)] $InputObject,
# The rounding methodology to use.
[MidpointRounding] $Mode = [MidpointRounding]::ToEven
)
Process { return [Math]::Round($InputObject, $Digits, $Mode) }
