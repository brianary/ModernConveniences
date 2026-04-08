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
        $public = Get-Item src/public/*.ps1
        return @"
$(Get-Item src/private/*.ps1 |Format-Function)
$($public |Format-Function)
Export-ModuleMember -Function $($public.BaseName -join ',')
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
