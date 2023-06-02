function Get-AdoRs {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        $recordset = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'recordset', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($recordset) {
            # Toggle all record sets until you find an open one
            Do {
                If ($recordset.State -ne $adStateOpen) {
                    $recordset = $recordset.NextRecordset()
                }
            } until ( (! $recordset) -or ($recordset.State -eq $adStateOpen) )

            if ($recordset) {
                if ($recordset.eof) {
                    $recordset= $null
                }
            }
        }

        $result = $recordset
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-AdoRs (Get-Conn -udl 'C:\temp\Eulanda_1 Eulanda.udl').Execute('SELECT COUNT(*) FROM Artikel')
}
