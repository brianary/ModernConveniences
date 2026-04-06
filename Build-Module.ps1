<#
.SYNOPSIS
Assembles the module file.
#>

#Requires -Version 7
[CmdletBinding()] Param()
Begin
{
    filter Format-Function
    {
        [CmdletBinding()] Param(
        [Parameter(ValueFromPipelineByPropertyName=$true,Mandatory=$true)][string] $BaseName,
        [Parameter(ValueFromPipelineByPropertyName=$true,Mandatory=$true)][string] $FullName
        )
        $Local:OFS = [Environment]::NewLine
        return @"

function $BaseName
{
$(Get-Content $FullName -Raw)
}
"@
    }

    function Out-Module
    {
        [CmdletBinding()] Param()
        $Local:OFS = [Environment]::NewLine
        return @"
$(Get-Item $PSScriptRoot\src\public\*.ps1 |Format-Function)
"@ |Out-File ([io.path]::ChangeExtension($(git rev-parse --show-toplevel |Split-Path -Leaf),'psm1')) utf8BOM
    }

}
Process
{
    try
    {
        Push-Location $PSScriptRoot
        Out-Module
    }
    finally
    {
        Pop-Location
    }
}
