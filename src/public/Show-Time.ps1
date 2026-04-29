<#
.SYNOPSIS
Displays a formatted date using powerline font characters.

.LINK
Get-Unicode

.LINK
Format-Date

.LINK
Get-Date

.FUNCTIONALITY
Date and time

.EXAMPLE
Show-Time Iso8601Z Iso8601WeekDate Iso8601OrdinalDate -Separator ' * '

( 2020-12-08T03:59:39Z * 2020-W50-1 * 2020-342 )
(but using powerline graphics)
#>

[CmdletBinding()][OutputType([void])] Param(
# The format to serialize the date as.
[Parameter(Position=0,Mandatory=$true,ValueFromRemainingArguments=$true)]
[ValidateSet('FrenchRepublicanDateTime','Iso8601','Iso8601Date','Iso8601OrdinalDate',
'Iso8601Week','Iso8601WeekDate','Iso8601Z','LocalLongDate','LocalLongDateTime','Rfc1123','Rfc1123Gmt')]
[string[]] $Format,
# The date/time value to format.
[Parameter(ValueFromPipeline=$true)][datetime] $Date = (Get-Date),
# The separator to use between formatted dates.
[string] $Separator = " $(Get-Unicode 0x2022) ",
# The foreground console color to use.
[consolecolor] $ForegroundColor = $host.UI.RawUI.BackgroundColor,
# The background console color to use.
[consolecolor] $BackgroundColor = $host.UI.RawUI.ForegroundColor
)
Process
{
	Write-Info (Get-Unicode 0xE0B6) -ForegroundColor $BackgroundColor -NoNewline
	Write-Info ' ' -ForegroundColor $ForegroundColor -BackgroundColor $BackgroundColor -NoNewline
	Write-Info (($Format |ForEach-Object {Format-Date $_ -Date $Date}) -join $Separator) `
		-ForegroundColor $ForegroundColor -BackgroundColor $BackgroundColor -NoNewline
	Write-Info ' ' -ForegroundColor $ForegroundColor -BackgroundColor $BackgroundColor -NoNewline
	Write-Info (Get-Unicode 0xE0B4) -fore $BackgroundColor
}
