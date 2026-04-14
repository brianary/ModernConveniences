<#
.SYNOPSIS
Copies objects as an HTML table.

.INPUTS
System.Management.Automation.PSObject to be turned into a table row.

.LINK
Format-HtmlDataTable

.LINK
ConvertTo-SafeEntities

.LINK
Invoke-WindowsPowerShell

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
Begin
{
	if(!$IsWindows) {Stop-ThrowError 'Only supported on Windows.' -OperationContext $PSVersionTable}
	$data = @()
}
Process
{
	$data += $InputObject
}
End
{
	$data |
		Select-Object -Property $Property |
		ConvertTo-Html -Fragment |
		Format-HtmlDataTable |
		ConvertTo-SafeEntities |
		Out-String |
		Set-Clipboard
	Invoke-WindowsPowerShell { Get-Clipboard |Set-Clipboard -AsHtml }
}
