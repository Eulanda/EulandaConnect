function Get-FieldTruncated {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false)]
        $rs = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'rs', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$fieldname = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'fieldname', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateRange("Positive")]
        [int]$maxLen = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'maxLen', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$result = $rs.fields($fieldName).Value
        $result = $result.Trim()
        $result = $result.Substring(0, [System.Math]::Min($maxLen, $result.Length))
        $result = $result.Trim()
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-FieldTruncated -rs (Get-Conn -udl 'C:\temp\Eulanda_1 Eulanda.udl').Execute('SELECT top 1 Kurztext1 FROM Artikel WHERE LEN(Kurztext1) = (SELECT MAX(LEN(Kurztext1)) FROM Artikel)') -fieldname 'Kurztext1' -maxLen 20
}
