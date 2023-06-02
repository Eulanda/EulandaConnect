function Get-Filename {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [ValidateScript({
            switch ($PSItem[-1]) {
                '.' {Throw 'A valid filepath cannot end with a period.'}
                '\' {Throw 'A valid filepath cannot end with a backslash.'}
                {$PSItem -match '\s'} {Throw 'A valid filepath cannot end with a blank character.'}
                Default {$true}
            }
        })]
        [string]$path = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'path', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $result = [string](Split-Path -Path $path -Leaf)
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-Filename -path 'C:\temp\test.txt'
}
