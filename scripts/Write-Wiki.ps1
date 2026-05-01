<#
.SYNOPSIS
Uses PlatyPS to create pages for the wiki.
#>

#Requires -Version 7.3
[CmdletBinding()] Param()
Begin
{
	if(!(Get-Module PlatyPS -ListAvailable))
	{
		Install-PSResource PlatyPS -Repository PSGallery -Scope CurrentUser -TrustRepository
	}
	Push-Location "$PSScriptRoot/.."
}
Process
{
	& './scripts/Build-Module.ps1'
	Import-Module (Get-Item src/.publish/*.psd1)
	New-MarkdownHelp -Module ModernConveniences -OutputFolder .github/wiki
}
Clean {Pop-Location}
