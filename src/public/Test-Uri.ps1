<#
.SYNOPSIS
Determines whether a string is a valid URI.

.INPUTS
System.String value to test for a valid URI format.

.OUTPUTS
System.Boolean indicating that the string can be parsed as a URI.

.FUNCTIONALITY
Data formats

.EXAMPLE
Test-Uri http://example.org

True

.EXAMPLE
Test-Uri 0

False

.EXAMPLE
Test-Uri https://webcoder.info/wps-to-psc.html -IsDefaultPort

True
#>

[CmdletBinding(DefaultParameterSetName='__AllParameterSets')][OutputType([bool])] Param(
# The string to test.
[Parameter(Position=0,Mandatory=$true,ValueFromPipeline=$true)][AllowEmptyString()][AllowNull()][string] $InputObject,
# What kind of URI to test for: Absolute, Relative, or RelativeOrAbsolute.
[Parameter(Position=1)][UriKind] $UriKind = 'Absolute',
# Indicates $true should be returned if the URI specifies a default port, $false otherwise.
[Parameter(ParameterSetName='IsDefaultPort')][switch] $IsDefaultPort,
# Indicates $true should be returned if the URI is a file: URI, $false otherwise.
[Parameter(ParameterSetName='IsFile')][switch] $IsFile,
# Indicates $true should be returned if the URI references the localhost, $false otherwise.
[Parameter(ParameterSetName='IsLoopback')][switch] $IsLoopback,
# Indicates $true should be returned if the URI is a UNC path, $false otherwise.
[Parameter(ParameterSetName='IsUnc')][switch] $IsUnc
)
Process
{
    if(!$InputObject) {return $false}
	[uri] $Uri = ''
	if(![uri]::TryCreate($InputObject,$UriKind,[ref]$Uri)) {return $false}
	switch($PSCmdlet.ParameterSetName)
	{
		IsAbsoluteUri {return $Uri.IsAbsoluteUri}
		IsDefaultPort {return $Uri.IsDefaultPort}
		IsFile {return $Uri.IsFile}
		IsLoopback {return $Uri.IsLoopback}
		IsUnc {return $Uri.IsUnc}
		default {return $true}
	}
}
