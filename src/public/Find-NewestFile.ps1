<#
.SYNOPSIS
Finds the most recent file.

.INPUTS
System.IO.FileInfo[] a list of files to compare.

.OUTPUTS
System.IO.FileInfo representing the newest of the files compared.

.FUNCTIONALITY
Files

.LINK
Test-NewerFile

.EXAMPLE
ls C:\java.exe -Recurse -ErrorAction Ignore |Find-NewestFile

Directory: C:\Program Files (x86)\Minecraft\runtime\jre-x64\1.8.0_25\bin

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----       2017-02-05     15:03         190888 java.exe
#>

[CmdletBinding()][OutputType([IO.FileInfo])] Param(
# The list of files to search.
[Parameter(ValueFromPipeline=$true,ValueFromRemainingArguments=$true)]
[IO.FileInfo[]] $Files
)
Begin   { $NewestFile = $null }
Process { $Files |ForEach-Object {if(Test-NewerFile $NewestFile $_){$NewestFile=$_}} }
End     { $NewestFile }
