ModernConveniences
==================

<!-- To publish to PowerShell Gallery, commit an update to the .psd1 file -->
<img src="images/ModernConveniences.svg" alt="ModernConveniences icon" align="right" height="256" width="256" />

[![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/ModernConveniences)](https://www.powershellgallery.com/packages/ModernConveniences/)
[![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/ModernConveniences)](https://www.powershellgallery.com/packages/ModernConveniences/)
[![Actions Status](https://github.com/brianary/ModernConveniences/actions/workflows/continuous.yml/badge.svg)](https://github.com/brianary/ModernConveniences/actions/workflows/continuous.yml)
[![Mastodon: @dataelemental@mastodon.social](https://badgen.net/badge/@dataelemental/@mastodon.social/blue?icon=mastodon)](https://mastodon.social/@dataelemental "DataElemental Mastodon profile")

A collection of general-purpose functions for objects, properties, and more.

<img src="images/demo.gif" alt="a demonstration of the module commands" height="300" width="600" />

- [Add-Counter](src/public/Add-Counter.ps1): Adds an incrementing integer property to each pipeline object.
- [Add-DynamicParam](src/public/Add-DynamicParam.ps1): Adds a dynamic parameter to a script, within a DynamicParam block.
- [Add-NoteProperty](src/public/Add-NoteProperty.ps1): Adds a NoteProperty to a PSObject, calculating the value with the object in context.
- [Add-NugetPackage](src/public/Add-NugetPackage.ps1): Loads a NuGet package DLL, downloading as needed.
- [Add-ParameterDefault](src/public/Add-ParameterDefault.ps1): Appends or creates a value to use for the specified cmdlet parameter to use when one is not specified.
- [Compare-Properties](src/public/Compare-Properties.ps1): Compares the properties of two objects.
- [ConvertTo-SafeEntities](src/public/ConvertTo-SafeEntities.ps1): Encode text as XML/HTML, escaping all characters outside 7-bit ASCII.
- [Copy-Html](src/public/Copy-Html.ps1): Copies objects as an HTML table.
- [Format-ByteUnits](src/public/Format-ByteUnits.ps1): Converts bytes to largest possible units, to improve readability.
- [Format-HtmlDataTable](src/public/Format-HtmlDataTable.ps1): Right-aligns numeric data in an HTML table for emailing, and optionally zebra-stripes &c.
- [Format-Permutations](src/public/Format-Permutations.ps1): Builds format strings using every combination of elements from multiple arrays.
- [Get-EnumValues](src/public/Get-EnumValues.ps1): Returns the possible values of the specified enumeration.
- [Get-ModuleScope](src/public/Get-ModuleScope.ps1): Returns the scope of an installed module.
- [Get-RandomBytes](src/public/Get-RandomBytes.ps1): Returns random bytes.
- [Get-TypeAccelerators](src/public/Get-TypeAccelerators.ps1): Returns the list of PowerShell type accelerators.
- [Import-Variables](src/public/Import-Variables.ps1): Creates local variables from a data row or dictionary (hashtable).
- [Invoke-WindowsPowerShell](src/public/Invoke-WindowsPowerShell.ps1): Runs commands in Windows PowerShell (typically from PowerShell Core).
- [Merge-PSObject](src/public/Merge-PSObject.ps1): Create a new PSObject by recursively combining the properties of PSObjects.
- [Read-Choice](src/public/Read-Choice.ps1): Returns choice selected from a list of options.
- [Remove-ParameterDefault](src/public/Remove-ParameterDefault.ps1): Removes a value that would have been used for a parameter if none was specified, if one existed.
- [Set-ParameterDefault](src/public/Set-ParameterDefault.ps1): Assigns a value to use for the specified cmdlet parameter to use when one is not specified.
- [Show-Progress](src/public/Show-Progress.ps1): Performs an operation against each item in a collection of input objects, with a progress bar.
- [Stop-ThrowError](src/public/Stop-ThrowError.ps1): Throws a better error than "throw".
- [Test-Administrator](src/public/Test-Administrator.ps1): Checks whether the current session has administrator privileges.
- [Test-NoteProperty](src/public/Test-NoteProperty.ps1): Looks for any matching NoteProperties on an object.
- [Test-Range](src/public/Test-Range.ps1): Returns true from an initial condition until a terminating condition; a latching test.
- [Test-Variable](src/public/Test-Variable.ps1): Indicates whether a variable has been defined.
- [Trace-VariableScope](src/public/Trace-VariableScope.ps1): Returns details about a variable by name in all available scopes.
- [Uninstall-OldModules](src/public/Uninstall-OldModules.ps1): Uninstalls old module versions (ignoring old Windows PowerShell modules).
- [Update-Modules](src/public/Update-Modules.ps1): Cleans up old modules.
- [Use-ProgressView](src/public/Use-ProgressView.ps1): Sets the progress bar display view.
- [Use-ReasonableDefaults](src/public/Use-ReasonableDefaults.ps1): Sets certain cmdlet parameter defaults to rational, useful values.
- [Write-CallInfo](src/public/Write-CallInfo.ps1): Prints caller name and parameters to the host for debugging purposes.
- [Write-Info](src/public/Write-Info.ps1): Writes to the information stream, with color support and more.
- [Write-VisibleString](src/public/Write-VisibleString.ps1): Displays a string, showing nonprintable characters.
