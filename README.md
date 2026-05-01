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

- [Add-CapturesToMatches](https://github.com/brianary/ModernConveniences/wiki/Add-CapturesToMatches): Adds named capture group values as note properties to Select-String MatchInfo objects.
- [Add-Counter](https://github.com/brianary/ModernConveniences/wiki/Add-Counter): Adds an incrementing integer property to each pipeline object.
- [Add-DynamicParam](https://github.com/brianary/ModernConveniences/wiki/Add-DynamicParam): Adds a dynamic parameter to a script, within a DynamicParam block.
- [Add-NoteProperty](https://github.com/brianary/ModernConveniences/wiki/Add-NoteProperty): Adds a NoteProperty to a PSObject, calculating the value with the object in context.
- [Add-NugetPackage](https://github.com/brianary/ModernConveniences/wiki/Add-NugetPackage): Loads a NuGet package DLL, downloading as needed.
- [Add-ParameterDefault](https://github.com/brianary/ModernConveniences/wiki/Add-ParameterDefault): Appends or creates a value to use for the specified cmdlet parameter to use when one is not specified.
- [Add-TimeSpan](https://github.com/brianary/ModernConveniences/wiki/Add-TimeSpan): Adds a timespan to DateTime values.
- [Compare-Keys](https://github.com/brianary/ModernConveniences/wiki/Compare-Keys): Returns the differences between two dictionaries.
- [Compare-Properties](https://github.com/brianary/ModernConveniences/wiki/Compare-Properties): Compares the properties of two objects.
- [Convert-ClipboardTsvToHtml](https://github.com/brianary/ModernConveniences/wiki/Convert-ClipboardTsvToHtml): Parses TSV clipboard data into HTML table data which is copied back to the clipboard as formatted HTML.
- [Convert-ICalToMermaidGantt](https://github.com/brianary/ModernConveniences/wiki/Convert-ICalToMermaidGantt): Imports iCal events and converts them into a Mermaid Gantt chart for each day, sectioned by location.
- [ConvertFrom-Base64](https://github.com/brianary/ModernConveniences/wiki/ConvertFrom-Base64): Converts base64-encoded text to bytes or text.
- [ConvertFrom-Duration](https://github.com/brianary/ModernConveniences/wiki/ConvertFrom-Duration): Parses a Timespan from a ISO8601 duration string.
- [ConvertFrom-EpochTime](https://github.com/brianary/ModernConveniences/wiki/ConvertFrom-EpochTime): Converts an integer Unix (POSIX) time (seconds since Jan 1, 1970) into a DateTime value.
- [ConvertFrom-Hex](https://github.com/brianary/ModernConveniences/wiki/ConvertFrom-Hex): Convert a string of hexadecimal digits into a byte array.
- [ConvertFrom-IsoWeekDate](https://github.com/brianary/ModernConveniences/wiki/ConvertFrom-IsoWeekDate): Returns a DateTime object from an ISO week date string.
- [ConvertTo-Base64](https://github.com/brianary/ModernConveniences/wiki/ConvertTo-Base64): Converts bytes or text to base64-encoded text.
- [ConvertTo-EpochTime](https://github.com/brianary/ModernConveniences/wiki/ConvertTo-EpochTime): Converts a DateTime value into an integer Unix (POSIX) time, seconds since Jan 1, 1970.
- [ConvertTo-FileName](https://github.com/brianary/ModernConveniences/wiki/ConvertTo-FileName): Returns a valid and safe filename from a given string.
- [ConvertTo-OrderedDictionary](https://github.com/brianary/ModernConveniences/wiki/ConvertTo-OrderedDictionary): Converts an object to an ordered dictionary of properties and values.
- [ConvertTo-PowerShell](https://github.com/brianary/ModernConveniences/wiki/ConvertTo-PowerShell): Serializes complex content into PowerShell literals.
- [ConvertTo-RomanNumeral](https://github.com/brianary/ModernConveniences/wiki/ConvertTo-RomanNumeral): Convert a number to a Roman numeral.
- [ConvertTo-SafeEntities](https://github.com/brianary/ModernConveniences/wiki/ConvertTo-SafeEntities): Encode text as XML/HTML, escaping all characters outside 7-bit ASCII.
- [Copy-Html](https://github.com/brianary/ModernConveniences/wiki/Copy-Html): Copies objects as an HTML table.
- [Disable-AnsiColor](https://github.com/brianary/ModernConveniences/wiki/Disable-AnsiColor): Disables ANSI terminal colors.
- [Enable-AnsiColor](https://github.com/brianary/ModernConveniences/wiki/Enable-AnsiColor): Enables ANSI terminal colors.
- [Expand-EnvironmentVariables](https://github.com/brianary/ModernConveniences/wiki/Expand-EnvironmentVariables): Replaces the name of each environment variable embedded in the specified string with the string equivalent of the value of the variable, then returns the resulting string.
- [Export-MermaidXY](https://github.com/brianary/ModernConveniences/wiki/Export-MermaidXY): Generates a Mermaid XY bar/line chart for the values of a series of properties.
- [Find-NewestFile](https://github.com/brianary/ModernConveniences/wiki/Find-NewestFile): Finds the most recent file.
- [Format-ByteUnits](https://github.com/brianary/ModernConveniences/wiki/Format-ByteUnits): Converts bytes to largest possible units, to improve readability.
- [Format-Date](https://github.com/brianary/ModernConveniences/wiki/Format-Date): Returns a date/time as a named format.
- [Format-EscapedUrl](https://github.com/brianary/ModernConveniences/wiki/Format-EscapedUrl): Escape URLs more aggressively.
- [Format-HtmlDataTable](https://github.com/brianary/ModernConveniences/wiki/Format-HtmlDataTable): Right-aligns numeric data in an HTML table for emailing, and optionally zebra-stripes &c.
- [Format-Permutations](https://github.com/brianary/ModernConveniences/wiki/Format-Permutations): Builds format strings using every combination of elements from multiple arrays.
- [Get-Clip](https://github.com/brianary/ModernConveniences/wiki/Get-Clip): Gets the contents of the clipboard (cross-platform, and more reliably on Linux Wayland).
- [Get-CommandParameters](https://github.com/brianary/ModernConveniences/wiki/Get-CommandParameters): Returns the parameters of the specified cmdlet.
- [Get-CommandPath](https://github.com/brianary/ModernConveniences/wiki/Get-CommandPath): Locates a command.
- [Get-ConsoleHistory](https://github.com/brianary/ModernConveniences/wiki/Get-ConsoleHistory): Returns the DOSKey-style console command history (up arrow or F8).
- [Get-EnumValues](https://github.com/brianary/ModernConveniences/wiki/Get-EnumValues): Returns the possible values of the specified enumeration.
- [Get-FrenchRepublicanDate](https://github.com/brianary/ModernConveniences/wiki/Get-FrenchRepublicanDate): Returns a date and time converted to the French Republican Calendar.
- [Get-ModuleScope](https://github.com/brianary/ModernConveniences/wiki/Get-ModuleScope): Returns the scope of an installed module.
- [Get-OutdatedModules](https://github.com/brianary/ModernConveniences/wiki/Get-OutdatedModules): Returns a list of modules that have upgrades available.
- [Get-RandomBytes](https://github.com/brianary/ModernConveniences/wiki/Get-RandomBytes): Returns random bytes.
- [Get-TypeAccelerators](https://github.com/brianary/ModernConveniences/wiki/Get-TypeAccelerators): Returns the list of PowerShell type accelerators.
- [Import-ClipboardTsv](https://github.com/brianary/ModernConveniences/wiki/Import-ClipboardTsv): Parses TSV clipboard data into objects.
- [Import-Variables](https://github.com/brianary/ModernConveniences/wiki/Import-Variables): Creates local variables from a data row or dictionary (hashtable).
- [Invoke-CachedCommand](https://github.com/brianary/ModernConveniences/wiki/Invoke-CachedCommand): Caches the output of a command for recall if called again.
- [Invoke-WindowsPowerShell](https://github.com/brianary/ModernConveniences/wiki/Invoke-WindowsPowerShell): Runs commands in Windows PowerShell (typically from PowerShell Core).
- [Join-Keys](https://github.com/brianary/ModernConveniences/wiki/Join-Keys): Combines dictionaries together into a single dictionary.
- [Limit-Digits](https://github.com/brianary/ModernConveniences/wiki/Limit-Digits): Rounds off a number to the requested number of digits.
- [Measure-Properties](https://github.com/brianary/ModernConveniences/wiki/Measure-Properties): Provides frequency details about the properties across objects in the pipeline.
- [Measure-Values](https://github.com/brianary/ModernConveniences/wiki/Measure-Values): Provides analysis of supplied values.
- [Merge-PSObject](https://github.com/brianary/ModernConveniences/wiki/Merge-PSObject): Create a new PSObject by recursively combining the properties of PSObjects.
- [Read-Choice](https://github.com/brianary/ModernConveniences/wiki/Read-Choice): Returns choice selected from a list of options.
- [Remove-ConsoleHistory](https://github.com/brianary/ModernConveniences/wiki/Remove-ConsoleHistory): Removes an entry from the DOSKey-style console command history (up arrow or F8).
- [Remove-NullValues](https://github.com/brianary/ModernConveniences/wiki/Remove-NullValues): Removes dictionary entries with null vaules.
- [Remove-ParameterDefault](https://github.com/brianary/ModernConveniences/wiki/Remove-ParameterDefault): Removes a value that would have been used for a parameter if none was specified, if one existed.
- [Repair-MarkdownHeaders](https://github.com/brianary/ModernConveniences/wiki/Repair-MarkdownHeaders): Updates markdown content to replace level 1 & 2 ATX headers to Setext headers.
- [Select-CapturesFromMatches](https://github.com/brianary/ModernConveniences/wiki/Select-CapturesFromMatches): Selects named capture group values as note properties from Select-String MatchInfo objects.
- [Select-ScriptCommands](https://github.com/brianary/ModernConveniences/wiki/Select-ScriptCommands): Returns the commands used by the specified script.
- [Set-Clip](https://github.com/brianary/ModernConveniences/wiki/Set-Clip): Sets the contents of the clipboard with formatted HTML support (cross-platform, and more reliably on Linux Wayland).
- [Set-ParameterDefault](https://github.com/brianary/ModernConveniences/wiki/Set-ParameterDefault): Assigns a value to use for the specified cmdlet parameter to use when one is not specified.
- [Set-RegexReplace](https://github.com/brianary/ModernConveniences/wiki/Set-RegexReplace): Updates text found with Select-String, using a regular expression replacement template.
- [Show-Progress](https://github.com/brianary/ModernConveniences/wiki/Show-Progress): Performs an operation against each item in a collection of input objects, with a progress bar.
- [Show-PSDriveUsage](https://github.com/brianary/ModernConveniences/wiki/Show-PSDriveUsage): Displays drive usage graphically, and with a human-readable summary.
- [Show-Status](https://github.com/brianary/ModernConveniences/wiki/Show-Status): Displays requested system status values using powerline font characters.
- [Show-Time](https://github.com/brianary/ModernConveniences/wiki/Show-Time): Displays a formatted date using powerline font characters.
- [Split-Keys](https://github.com/brianary/ModernConveniences/wiki/Split-Keys): Clones a dictionary keeping only the specified keys.
- [Split-Uri](https://github.com/brianary/ModernConveniences/wiki/Split-Uri): Splits a URI into component parts.
- [Stop-ThrowError](https://github.com/brianary/ModernConveniences/wiki/Stop-ThrowError): Throws a better error than "throw".
- [Test-Administrator](https://github.com/brianary/ModernConveniences/wiki/Test-Administrator): Checks whether the current session has administrator privileges.
- [Test-DateTime](https://github.com/brianary/ModernConveniences/wiki/Test-DateTime): Tests whether the given string can be parsed as a date.
- [Test-FileTypeMagicNumber](https://github.com/brianary/ModernConveniences/wiki/Test-FileTypeMagicNumber): Tests for a given common file type by magic number.
- [Test-Interactive](https://github.com/brianary/ModernConveniences/wiki/Test-Interactive): Determines whether both the user and process are interactive.
- [Test-MagicNumber](https://github.com/brianary/ModernConveniences/wiki/Test-MagicNumber): Tests a file for a "magic number" (identifying sequence of bytes) at a given location.
- [Test-NewerFile](https://github.com/brianary/ModernConveniences/wiki/Test-NewerFile): Returns true if the difference file is newer than the reference file.
- [Test-NoteProperty](https://github.com/brianary/ModernConveniences/wiki/Test-NoteProperty): Looks for any matching NoteProperties on an object.
- [Test-Range](https://github.com/brianary/ModernConveniences/wiki/Test-Range): Returns true from an initial condition until a terminating condition; a latching test.
- [Test-Uri](https://github.com/brianary/ModernConveniences/wiki/Test-Uri): Determines whether a string is a valid URI.
- [Test-USFederalHoliday](https://github.com/brianary/ModernConveniences/wiki/Test-USFederalHoliday): Returns true if the given date is a U.S. federal holiday.
- [Test-Variable](https://github.com/brianary/ModernConveniences/wiki/Test-Variable): Indicates whether a variable has been defined.
- [Trace-VariableScope](https://github.com/brianary/ModernConveniences/wiki/Trace-VariableScope): Returns details about a variable by name in all available scopes.
- [Uninstall-OldModules](https://github.com/brianary/ModernConveniences/wiki/Uninstall-OldModules): Uninstalls old module versions (ignoring old Windows PowerShell modules).
- [Update-Files](https://github.com/brianary/ModernConveniences/wiki/Update-Files): Copies specified source files that exist in the destination directory.
- [Update-Modules](https://github.com/brianary/ModernConveniences/wiki/Update-Modules): Cleans up old modules.
- [Use-ProgressView](https://github.com/brianary/ModernConveniences/wiki/Use-ProgressView): Sets the progress bar display view.
- [Use-ReasonableDefaults](https://github.com/brianary/ModernConveniences/wiki/Use-ReasonableDefaults): Sets certain cmdlet parameter defaults to rational, useful values.
- [Write-CallInfo](https://github.com/brianary/ModernConveniences/wiki/Write-CallInfo): Prints caller name and parameters to the host for debugging purposes.
- [Write-Info](https://github.com/brianary/ModernConveniences/wiki/Write-Info): Writes to the information stream, with color support and more.
- [Write-VisibleString](https://github.com/brianary/ModernConveniences/wiki/Write-VisibleString): Displays a string, showing nonprintable characters.
