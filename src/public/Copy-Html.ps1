<#
.SYNOPSIS
Copies objects as an HTML table.

.INPUTS
System.Management.Automation.PSObject to be turned into a table row.

.LINK
Set-Clip

.LINK
Format-HtmlDataTable

.LINK
ConvertTo-SafeEntities

.LINK
ConvertTo-Html

.EXAMPLE
Get-PSDrive |Copy-Html Name,Description

Copies an HTML table with two columns to the clipboard as formatted text
that can be pasted into emails or other formatted documents.
#>

[CmdletBinding()][OutputType([void])] Param(
# Columns to include in the copied table.
[Parameter(Position=0)][array] $Property,
# The objects to turn into table rows.
[Parameter(ValueFromPipeline=$true)][psobject] $InputObject
)
End
{
	$data = @($input)
	if(!$data) {$data = @($InputObject)}
	$data |
		Select-Object -Property $Property |
		ConvertTo-Html -Fragment |
		Format-HtmlDataTable |
		ConvertTo-SafeEntities |
		Out-String |
		Set-Clip -AsHtml
}
