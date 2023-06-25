function Convert-Slugify {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$value = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'value', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateStringCase $_ })]
        [string]$strCase = 'none'
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet('-', '_')]
        [string]$delimiter = '_'
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'regex' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ('')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $regex = [System.Text.RegularExpressions.Regex]
        $result = convert-accent -value $value
        $result = [Regex]::Replace($result, [char]0x20AC, ' EUR ')  # For compatibility with powerShell 5.x
        $result = $result.replace('$',' USD ')
        $result = $result.replace('£',' GBP ')
        $result = $result.replace('²','2')
        $result = $result.replace('³','3')
        $result = $result.replace('-',' ')
        $result = $result.replace('_',' ')
        $result = $regex::Replace($result, "[^a-zA-Z0-9\s-]", "")
        $result = $regex::Replace($result, "\s+", " ").Trim()
        $result = $regex::Replace($result, "\s", $delimiter)
        $result = $result = Convert-StringCase -value $result -strCase $strCase
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Convert-Slugify -value 'This is Österreich where you pan pay in € or $ but all in m³ and never in m²'
}
