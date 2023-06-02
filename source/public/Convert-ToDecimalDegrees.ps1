function Convert-ToDecimalDegrees {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [ValidateRange(0,180)]
        [int]$degrees
        ,
        [parameter(Mandatory = $false)]
        [ValidateRange(0,59)]
        [int]$minutes
        ,
        [parameter(Mandatory = $false)]
        [ValidateRange(0,59)]
        [int]$seconds
        ,
        [parameter(Mandatory = $false)]
        [ValidateSet('N', 'S', 'E', 'W')]
        [string]$direction
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $result = $degrees + $minutes / 60 + $seconds / 3600

        # Convert direction to upper case
        $direction = $direction.ToUpper()

        # If the direction is South or West, make the result negative
        if ($direction -eq 'S' -or $direction -eq 'W') {
            $result *= -1
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Convert-ToDecimalDegrees
}
