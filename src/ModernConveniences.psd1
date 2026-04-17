# see https://docs.microsoft.com/powershell/scripting/developer/module/how-to-write-a-powershell-module-manifest
# and https://docs.microsoft.com/powershell/module/microsoft.powershell.core/new-modulemanifest
@{
RootModule = 'ModernConveniences.psm1'
ModuleVersion = '0.0.1.1'
CompatiblePSEditions = @('Core')
GUID = 'd81982a2-0e28-463f-b63d-1d26c49a6b9b'
Author = 'Brian Lalonde'
CompanyName = 'Unknown'
Copyright = 'Copyright © 2026 Brian Lalonde'
Description = 'Quality of life improvements and enhancements to core PowerShell functionality. '
PowerShellVersion = '7.0'
# RequiredModules = ,'Microsoft.PowerShell.Utility'
FunctionsToExport = @('*') # '*'
CmdletsToExport = @() # '*'
VariablesToExport = @() # '*'
# AliasesToExport = @()
FileList = @('ModernConveniences.psd1','ModernConveniences.psm1')
PrivateData = @{
	PSData = @{
		Tags = 'Extensions', 'Utility'
		LicenseUri = 'https://github.com/brianary/ModernConveniences/blob/master/LICENSE'
		ProjectUri = 'https://github.com/brianary/ModernConveniences/'
		IconUri = 'http://webcoder.info/images/ModernConveniences.svg'
		# ReleaseNotes = ''
		# PS7: A list of external modules that this module is dependent upon.
		# ExternalModuleDependencies = ,'Microsoft.PowerShell.Utility'
	}
}
}
