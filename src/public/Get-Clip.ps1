<#
.SYNOPSIS
Gets the contents of the clipboard (cross-platform, and more reliably on Linux Wayland).

.FUNCTIONALITY
Clipboard

.OUTPUTS
System.String data from the system clipboard.

.LINK
https://github.com/PowerShell/PowerShell/issues/26832#issuecomment-4104212817

.LINK
Get-Clipboard

.EXAMPLE
Get-Clip

(returns clipboard contents)
#>

[CmdletBinding()][OutputType([string])] Param(
# Specifies HTML clipboard data should be returned.
[switch] $AsHtml
)
if(!$IsLinux)
{
	if(!$AsHtml) {return Get-Clipboard}
	else
	{
		if($PSVersionTable.PSEdition -eq 'Desktop') {return Get-Clipboard -Format Text -TextFormatType Html -ErrorAction Ignore}
		else {return Invoke-WindowsPowerShell { Get-Clipboard -Format Text -TextFormatType Html -ErrorAction Ignore }}
	}
}
elseif(Get-Command wl-paste -Type Application -ErrorAction Ignore)
{
	return $AsHtml ? (wl-paste -t text/html) : (wl-paste)
}
elseif(Get-Command xclip -Type Application -ErrorAction Ignore)
{
	return $AsHtml ? (xclip -o -t text/html) : (xclip -o)
}
else {Write-Warning "Unable to find wl-copy or xclip!"}
