<#
.SYNOPSIS
Test variable import.
#>

[CmdletBinding()] Param()
Begin
{
	$varname = "TestVariable_$((New-Guid).ToString('N'))"
	function Trace-DepthVariables
	{
		[CmdletBinding()] Param(
		[Parameter(Position=0)][ValidateRange(1,16)][int] $Depth = 1,
		[Parameter(Position=1)][string] $Scope = 'Local'
		)
		if($Depth -eq 1)
		{
			$guid = (New-Guid).ToString('N')
			$object = [pscustomobject]@{ "Id_$guid" = 1; "Name_$guid" = 'VariableTesting' }
			Import-Variables $object -Scope $Scope
			$callstack = @(Get-PSCallStack)
			foreach($prop in $object.PSObject.Properties)
			{
				if(!(Get-Variable $prop.Name -ErrorAction Ignore -OutVariable variable))
				{
					Write-Warning "'$($prop.Name)' is not set!"
				}
				for($i = 1; $i -lt $callstack.Count; $i++)
				{
					$where = "$($callstack[$i].Command) in $($callstack[$i].ScriptName):$($callstack[$i].ScriptLineNumber)"
					if(Get-Variable $prop.Name -Scope "$i" -ErrorAction Ignore)
					{
						Write-Warning "'$($prop.Name)' variable overshot local scope to $i, $where"
					}
				}
				if(!(Get-Variable $prop.Name -Scope Local -ErrorAction Ignore))
				{
					Write-Warning "Variable does not exist in local scope!"
				}
				if($prop.Value -ne (Get-Variable $prop.Name -ValueOnly -Scope Local -ErrorAction Ignore))
				{
					Write-Warning "Variable value does not match!"
				}
			}
			for($i = $callstack.Count -1; $i -ge 0; $i--)
			{
				Write-Information "$($MyInvocation.MyCommand.Name) : importing '$varname' into scope $i"
				[pscustomobject]@{ $varname = "Scope: $i" } |Import-Variables -Scope "$i"
			}
		}
		else
		{
			Trace-DepthVariables ($Depth-1) -Scope $Scope
			$varvalue = Get-Value $varname -ValueOnly -ErrorAction Ignore
			Write-Information "$($MyInvocation.MyCommand.Name) -Depth $Depth -Scope $Scope # $varvalue"
		}
	}

	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Process
{
	Trace-DepthVariables
}
