<#
.SYNOPSIS
Parses TSV clipboard data into HTML table data which is copied back to the clipboard as formatted HTML.

.FUNCTIONALITY
Clipboard

.LINK
Import-ClipboardTsv

.LINK
ConvertTo-Html

.LINK
ConvertTo-SafeEntities

.LINK
Set-Clip

.EXAMPLE
Convert-ClipboardTsvToHtml

TSV clipboard data may now be pasted into an email or document as a table.
#>

[CmdletBinding()] Param()
Import-ClipboardTsv |
	ConvertTo-Html -Fragment |
	ConvertTo-SafeEntities |
	Set-Clip -AsHtml
