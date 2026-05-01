ModernConveniences
==================

<!-- To publish to PowerShell Gallery, commit an update to the .psd1 file -->
<img src="images/ModernConveniences.svg" alt="ModernConveniences icon" align="right" height="200" width="200" />

[![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/ModernConveniences)](https://www.powershellgallery.com/packages/ModernConveniences/)
[![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/ModernConveniences)](https://www.powershellgallery.com/packages/ModernConveniences/)
[![Actions Status](https://github.com/brianary/ModernConveniences/actions/workflows/continuous.yml/badge.svg)](https://github.com/brianary/ModernConveniences/actions/workflows/continuous.yml)
[![Mastodon: @dataelemental@mastodon.social](https://badgen.net/badge/@dataelemental/@mastodon.social/blue?icon=mastodon)](https://mastodon.social/@dataelemental "DataElemental Mastodon profile")

A collection of general-purpose functions for objects, properties, and more.

<img src="images/demo.gif" alt="a demonstration of the module commands" height="300" width="600" />

- [Add-CapturesToMatches](./src/public/Add-CapturesToMatches.ps1): Adds named capture group values as note properties to Select-String MatchInfo objects.
- [Add-Counter](./src/public/Add-Counter.ps1): Adds an incrementing integer property to each pipeline object.
- [Add-DynamicParam](./src/public/Add-DynamicParam.ps1): Adds a dynamic parameter to a script, within a DynamicParam block.
- [Add-NoteProperty](./src/public/Add-NoteProperty.ps1): Adds a NoteProperty to a PSObject, calculating the value with the object in context.
- [Add-NugetPackage](./src/public/Add-NugetPackage.ps1): Loads a NuGet package DLL, downloading as needed.
- [Add-ParameterDefault](./src/public/Add-ParameterDefault.ps1): Appends or creates a value to use for the specified cmdlet parameter to use when one is not specified.
- [Add-TimeSpan](./src/public/Add-TimeSpan.ps1): Adds a timespan to DateTime values.
- [Compare-Keys](./src/public/Compare-Keys.ps1): Returns the differences between two dictionaries.
- [Compare-Properties](./src/public/Compare-Properties.ps1): Compares the properties of two objects.
- [Convert-ClipboardTsvToHtml](./src/public/Convert-ClipboardTsvToHtml.ps1): Parses TSV clipboard data into HTML table data which is copied back to the clipboard as formatted HTML.
- [Convert-ICalToMermaidGantt](./src/public/Convert-ICalToMermaidGantt.ps1): Imports iCal events and converts them into a Mermaid Gantt chart for each day, sectioned by location.
- [ConvertFrom-Base64](./src/public/ConvertFrom-Base64.ps1): Converts base64-encoded text to bytes or text.
- [ConvertFrom-Duration](./src/public/ConvertFrom-Duration.ps1): Parses a Timespan from a ISO8601 duration string.
- [ConvertFrom-EpochTime](./src/public/ConvertFrom-EpochTime.ps1): Converts an integer Unix (POSIX) time (seconds since Jan 1, 1970) into a DateTime value.
- [ConvertFrom-Hex](./src/public/ConvertFrom-Hex.ps1): Convert a string of hexadecimal digits into a byte array.
- [ConvertFrom-IsoWeekDate](./src/public/ConvertFrom-IsoWeekDate.ps1): Returns a DateTime object from an ISO week date string.
- [ConvertTo-Base64](./src/public/ConvertTo-Base64.ps1): Converts bytes or text to base64-encoded text.
- [ConvertTo-EpochTime](./src/public/ConvertTo-EpochTime.ps1): Converts a DateTime value into an integer Unix (POSIX) time, seconds since Jan 1, 1970.
- [ConvertTo-FileName](./src/public/ConvertTo-FileName.ps1): Returns a valid and safe filename from a given string.
- [ConvertTo-OrderedDictionary](./src/public/ConvertTo-OrderedDictionary.ps1): Converts an object to an ordered dictionary of properties and values.
- [ConvertTo-PowerShell](./src/public/ConvertTo-PowerShell.ps1): Serializes complex content into PowerShell literals.
- [ConvertTo-RomanNumeral](./src/public/ConvertTo-RomanNumeral.ps1): Convert a number to a Roman numeral.
- [ConvertTo-SafeEntities](./src/public/ConvertTo-SafeEntities.ps1): Encode text as XML/HTML, escaping all characters outside 7-bit ASCII.
- [Copy-Html](./src/public/Copy-Html.ps1): Copies objects as an HTML table.
- [Disable-AnsiColor](./src/public/Disable-AnsiColor.ps1): Disables ANSI terminal colors.
- [Enable-AnsiColor](./src/public/Enable-AnsiColor.ps1): Enables ANSI terminal colors.
- [Expand-EnvironmentVariables](./src/public/Expand-EnvironmentVariables.ps1): Replaces the name of each environment variable embedded in the specified string with the string equivalent of the value of the variable, then returns the resulting string.
- [Export-MermaidXY](./src/public/Export-MermaidXY.ps1): Generates a Mermaid XY bar/line chart for the values of a series of properties.
- [Find-NewestFile](./src/public/Find-NewestFile.ps1): Finds the most recent file.
- [Format-ByteUnits](./src/public/Format-ByteUnits.ps1): Converts bytes to largest possible units, to improve readability.
- [Format-Date](./src/public/Format-Date.ps1): Returns a date/time as a named format.
- [Format-EscapedUrl](./src/public/Format-EscapedUrl.ps1): Escape URLs more aggressively.
- [Format-HtmlDataTable](./src/public/Format-HtmlDataTable.ps1): Right-aligns numeric data in an HTML table for emailing, and optionally zebra-stripes &c.
- [Format-Permutations](./src/public/Format-Permutations.ps1): Builds format strings using every combination of elements from multiple arrays.
- [Get-Clip](./src/public/Get-Clip.ps1): Gets the contents of the clipboard (cross-platform, and more reliably on Linux Wayland).
- [Get-CommandParameters](./src/public/Get-CommandParameters.ps1): Returns the parameters of the specified cmdlet.
- [Get-CommandPath](./src/public/Get-CommandPath.ps1): Locates a command.
- [Get-ConsoleHistory](./src/public/Get-ConsoleHistory.ps1): Returns the DOSKey-style console command history (up arrow or F8).
- [Get-EnumValues](./src/public/Get-EnumValues.ps1): Returns the possible values of the specified enumeration.
- [Get-FrenchRepublicanDate](./src/public/Get-FrenchRepublicanDate.ps1): Returns a date and time converted to the French Republican Calendar.
- [Get-ModuleScope](./src/public/Get-ModuleScope.ps1): Returns the scope of an installed module.
- [Get-OutdatedModules](./src/public/Get-OutdatedModules.ps1): Returns a list of modules that have upgrades available.
- [Get-RandomBytes](./src/public/Get-RandomBytes.ps1): Returns random bytes.
- [Get-TypeAccelerators](./src/public/Get-TypeAccelerators.ps1): Returns the list of PowerShell type accelerators.
- [Import-ClipboardTsv](./src/public/Import-ClipboardTsv.ps1): Parses TSV clipboard data into objects.
- [Import-Variables](./src/public/Import-Variables.ps1): Creates local variables from a data row or dictionary (hashtable).
- [Invoke-CachedCommand](./src/public/Invoke-CachedCommand.ps1): Caches the output of a command for recall if called again.
- [Invoke-WindowsPowerShell](./src/public/Invoke-WindowsPowerShell.ps1): Runs commands in Windows PowerShell (typically from PowerShell Core).
- [Join-Keys](./src/public/Join-Keys.ps1): Combines dictionaries together into a single dictionary.
- [Limit-Digits](./src/public/Limit-Digits.ps1): Rounds off a number to the requested number of digits.
- [Measure-Properties](./src/public/Measure-Properties.ps1): Provides frequency details about the properties across objects in the pipeline.
- [Measure-Values](./src/public/Measure-Values.ps1): Provides analysis of supplied values.
- [Merge-PSObject](./src/public/Merge-PSObject.ps1): Create a new PSObject by recursively combining the properties of PSObjects.
- [Read-Choice](./src/public/Read-Choice.ps1): Returns choice selected from a list of options.
- [Remove-ConsoleHistory](./src/public/Remove-ConsoleHistory.ps1): Removes an entry from the DOSKey-style console command history (up arrow or F8).
- [Remove-NullValues](./src/public/Remove-NullValues.ps1): Removes dictionary entries with null vaules.
- [Remove-ParameterDefault](./src/public/Remove-ParameterDefault.ps1): Removes a value that would have been used for a parameter if none was specified, if one existed.
- [Repair-MarkdownHeaders](./src/public/Repair-MarkdownHeaders.ps1): Updates markdown content to replace level 1 & 2 ATX headers to Setext headers.
- [Select-CapturesFromMatches](./src/public/Select-CapturesFromMatches.ps1): Selects named capture group values as note properties from Select-String MatchInfo objects.
- [Select-ScriptCommands](./src/public/Select-ScriptCommands.ps1): Returns the commands used by the specified script.
- [Set-Clip](./src/public/Set-Clip.ps1): Sets the contents of the clipboard with formatted HTML support (cross-platform, and more reliably on Linux Wayland).
- [Set-ParameterDefault](./src/public/Set-ParameterDefault.ps1): Assigns a value to use for the specified cmdlet parameter to use when one is not specified.
- [Set-RegexReplace](./src/public/Set-RegexReplace.ps1): Updates text found with Select-String, using a regular expression replacement template.
- [Show-Progress](./src/public/Show-Progress.ps1): Performs an operation against each item in a collection of input objects, with a progress bar.
- [Show-PSDriveUsage](./src/public/Show-PSDriveUsage.ps1): Displays drive usage graphically, and with a human-readable summary.
- [Show-Status](./src/public/Show-Status.ps1): Displays requested system status values using powerline font characters.
- [Show-Time](./src/public/Show-Time.ps1): Displays a formatted date using powerline font characters.
- [Split-Keys](./src/public/Split-Keys.ps1): Clones a dictionary keeping only the specified keys.
- [Split-Uri](./src/public/Split-Uri.ps1): Splits a URI into component parts.
- [Stop-ThrowError](./src/public/Stop-ThrowError.ps1): Throws a better error than "throw".
- [Test-Administrator](./src/public/Test-Administrator.ps1): Checks whether the current session has administrator privileges.
- [Test-DateTime](./src/public/Test-DateTime.ps1): Tests whether the given string can be parsed as a date.
- [Test-FileTypeMagicNumber](./src/public/Test-FileTypeMagicNumber.ps1): Tests for a given common file type by magic number.
- [Test-Interactive](./src/public/Test-Interactive.ps1): Determines whether both the user and process are interactive.
- [Test-MagicNumber](./src/public/Test-MagicNumber.ps1): Tests a file for a "magic number" (identifying sequence of bytes) at a given location.
- [Test-NewerFile](./src/public/Test-NewerFile.ps1): Returns true if the difference file is newer than the reference file.
- [Test-NoteProperty](./src/public/Test-NoteProperty.ps1): Looks for any matching NoteProperties on an object.
- [Test-Range](./src/public/Test-Range.ps1): Returns true from an initial condition until a terminating condition; a latching test.
- [Test-Uri](./src/public/Test-Uri.ps1): Determines whether a string is a valid URI.
- [Test-USFederalHoliday](./src/public/Test-USFederalHoliday.ps1): Returns true if the given date is a U.S. federal holiday.
- [Test-Variable](./src/public/Test-Variable.ps1): Indicates whether a variable has been defined.
- [Trace-VariableScope](./src/public/Trace-VariableScope.ps1): Returns details about a variable by name in all available scopes.
- [Uninstall-OldModules](./src/public/Uninstall-OldModules.ps1): Uninstalls old module versions (ignoring old Windows PowerShell modules).
- [Update-Files](./src/public/Update-Files.ps1): Copies specified source files that exist in the destination directory.
- [Update-Modules](./src/public/Update-Modules.ps1): Cleans up old modules.
- [Use-ProgressView](./src/public/Use-ProgressView.ps1): Sets the progress bar display view.
- [Use-ReasonableDefaults](./src/public/Use-ReasonableDefaults.ps1): Sets certain cmdlet parameter defaults to rational, useful values.
- [Write-CallInfo](./src/public/Write-CallInfo.ps1): Prints caller name and parameters to the host for debugging purposes.
- [Write-Info](./src/public/Write-Info.ps1): Writes to the information stream, with color support and more.
- [Write-VisibleString](./src/public/Write-VisibleString.ps1): Displays a string, showing nonprintable characters.
