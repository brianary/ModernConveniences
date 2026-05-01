<#
.SYNOPSIS
Sets the contents of the clipboard with formatted HTML support (cross-platform, and more reliably on Linux Wayland).

.FUNCTIONALITY
Clipboard

.INPUTS
System.String to store to the system clipboard.

.OUTPUTS
System.String data from the system clipboard.

.LINK
https://github.com/PowerShell/PowerShell/issues/26832#issuecomment-4104212817

.LINK
Invoke-WindowsPowerShell

.LINK
Get-Clip

.LINK
Set-Clipboard

.EXAMPLE
Get-Content README.md |Set-Clip -PassThru

(copies file contents and returns the value copied)

.EXAMPLE
Get-Content index.html |Set-Clip -AsHtml

(copies file contents as HTML for pasting formatted into a document or email)
#>

[CmdletBinding()][OutputType([string])] Param(
# Indicates that the cmdlet should add to the clipboard instead of replacing it.
[switch] $Append,
# Indicates that the cmdlet renders the content as formatted HTML to the clipboard.
[switch] $AsHtml,
# Returns an object representing the item with which you're working.
[switch] $PassThru,
# Specifies, as a string array, the content to copy to the clipboard.
[Parameter(ValueFromPipeline=$true)][string[]] $Value
)
End
{
	[string[]] $data = @($input)
	if(!$data) {$data = $Value}
	if(!$IsLinux)
	{
		if($AsHtml)
		{
			if($PSVersionTable.PSEdition -ne 'Desktop')
			{
				Invoke-WindowsPowerShell { Set-Clipboard -Value $data -Append:$Append -AsHtml }.GetNewClosure()
			}
			else
			{
				Set-Clipboard -Value $data -AsHtml -Append:$Append
			}
			if($PassThru) {return $data}
		}
	}
	elseif(Get-Command wl-copy -Type Application -ErrorAction Ignore)
	{
		if($Append) {$data = @(Get-Clip)+$data}
		if($AsHtml) {$data |wl-copy -t text/html -n}
		else {$data |wl-copy -n}
		if($PassThru) {return $data}
	}
	elseif(Get-Command xclip -Type Application -ErrorAction Ignore)
	{
		if($Append) {$data = @(Get-Clip)+$data}
		if($AsHtml) {$data |xclip -t text/html -r}
		else {$data |xclip -r}
		if($PassThru) {return $data}
	}
	else {Write-Warning "Unable to find wl-copy or xclip!"}
}
