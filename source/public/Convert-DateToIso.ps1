function Convert-DateToIso {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [datetime]$value = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'value', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [switch]$asUtc
        ,
        [Parameter(Mandatory = $false)]
        [switch]$noTime
        ,
        [Parameter(Mandatory = $false)]
        [switch]$noDate
        ,
        [Parameter(Mandatory = $false)]
        [switch]$noTimeZone
        ,
        [Parameter(Mandatory = $false)]
        [switch]$zeroTime
        ,
        [Parameter(Mandatory = $false)]
        [switch]$noonTime
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'date' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ('')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($noTime) {
            [datetime]$date = [datetime]::new($value.Year, $value.Month, $value.Day, 12, 0, 0)

            if ($noTimeZone) {
                if ($asUtc) {
                    [string]$result = $(Get-Date -Date $date.ToUniversalTime() -format "yyyy-MM-dd")
                } else {
                    [string]$result = $(Get-Date -Date $date -format "yyyy-MM-dd")
                }
            } else {
                if ($asUtc) {
                    [string]$result = $(Get-Date -Date $date.ToUniversalTime() -format "yyyy-MM-ddZ")
                } else {
                    [string]$result = $(Get-Date -Date $date -format "yyyy-MM-dd.0zzz")
                }
            }
        } elseif ($noDate) {
            if ($noonTime) {
                [datetime]$date = [datetime]::new(1, 1, 1, 12, 0, 0)
            } elseif ($zeroTime) {
                [datetime]$date = [datetime]::new($value.Year, $value.Month, $value.Day, 0, 0, 0)
            } else
             {
                [datetime]$date = [datetime]::new(1, 1, 1, $value.Hour, $value.Minute, $value.Second)
            }

            if ($noTimeZone) {
                if ($asUtc) {
                    [string]$result = $(Get-Date -Date $date.ToUniversalTime() -format "HH:mm:ss")
                } else {
                    [string]$result = $(Get-Date -Date $date -format "HH:mm:ss")
                }
            } else {
                if ($asUtc) {
                    [string]$result = $(Get-Date -Date $date.ToUniversalTime() -format "HH:mm:ss.0Z")
                } else {
                    [string]$result = $(Get-Date -Date $date -format "HH:mm:ss.0zzz")
                }
            }
        } else { # time AND date
            if ($noonTime) {
                [datetime]$date = [datetime]::new($value.Year, $value.Month, $value.Day, 12, 0, 0)
            } elseif ($zeroTime) {
                [datetime]$date = [datetime]::new($value.Year, $value.Month, $value.Day, 0, 0, 0)
            } else {
                [datetime]$date = [datetime]::new($value.Year, $value.Month, $value.Day, $value.Hour, $value.Minute, $value.Second)
            }

            if ($noTimeZone) {
                if ($asUtc) {
                    [string]$result = $(Get-Date -Date $date.ToUniversalTime() -format "yyyy-MM-ddTHH:mm:ss")
                } else {
                    [string]$result = $(Get-Date -Date $date -format "yyyy-MM-ddTHH:mm:ss")
                }
            } else {
                if ($asUtc) {
                    [string]$result = $(Get-Date -Date $date.ToUniversalTime() -format "yyyy-MM-ddTHH:mm:ssZ")
                } else {
                    [string]$result = $(Get-Date -Date $date.ToUniversalTime() -format "yyyy-MM-ddTHH:mm:ss.0zzz")
                }
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Convert-DateToIso -value (get-date) -noontime -debug
}
