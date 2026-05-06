<#
.SYNOPSIS
Does simple detection of a file's text encoding.
#>

[CmdletBinding()] Param(
[Parameter(Position=0,Mandatory=$true)][string] $Path
)
if('EFBBBF' -eq ('{0:X2}{1:X2}{2:X2}' -f  (Get-Content ./README.md -AsByteStream -TotalCount 3))) {return 'utf8BOM'}
$sr = New-Object System.IO.StreamReader $Path,$true
$sr.Peek() |Out-Null
switch($sr.CurrentEncoding.WebName)
{
	'utf-8'    {return 'utf8NoBOM'} # will also match Windows-1252, iso-8859-1, iso-8859-15
	'utf-16'   {return 'unicode'}
	'utf-16BE' {return 'bigendianunicode'}
	'utf-32'   {return 'utf32'}
	'utf-32BE' {return 'bigendianutf32'}
	default    {return 'utf8BOM'}
}
