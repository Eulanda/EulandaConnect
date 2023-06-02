function Unprotect-String {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $false)]
        $protectedText = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'protectedText', $myInvocation.Mycommand))
        ,
        [Parameter(Position = 1, Mandatory = $false)]
        $key = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'key', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $key = Get-ProtectedKey $key
        $result = $protectedText | ConvertTo-SecureString -key $key |
            ForEach-Object {
                [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($_))
            }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Unprotect-String -protectedText "76492d1116743f0423413b16050a5345MgB8AEUAUgAxAEkASwBQAGUAWAA4AFcAMwBhADgANgArAFUANAA3AHIAZgBvAEEAPQA9AHwAZAA5AGEAMAA2ADQAZAAxAGEAZgA1ADkAYgA3ADcANwBlADAAOQBmADUAZgA4ADcANAA3ADUAOAA1ADgAYgAwADUAMAA1AGMAOABmADMAOAA0ADIAOQAzADQAMQA1AGQAMgAzADgAYwBlADkAMgBhADAAYwAyADAAOABiAGUANwA5AGIAOQBkAGUANQA5AGUAYwA4ADMAZQAxAGQANgA0ADIAMABkADYAYwA2ADEAZQA1ADEAZQBjADQAMAAxADkAOQA5AGYAOABkADcAYQA2AGYAZAA5ADEAYwBmADYANwAyADUAOAA1ADYAZQAxADQANgA0AGYAOQBjAGUAMQAyAA==" -key 'MySpecialKey'
}
