function Get-DataFromSql {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string[]]$sql = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'sql', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$arrRoot = 'Items'
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'field' -Scope 'Private' -Value ($null)
        New-Variable -Name 'i' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'record' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([System.Collections.ArrayList]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $result = New-Object System.Collections.ArrayList
        $rs = $Null
        $rs = $myConn.Execute($sql[0])
        $rs = Get-AdoRs -recordset $rs
        if ($rs) {
            while (! $rs.eof) {
                $record = [ordered]@{}
                for ($i=0; $i -lt $rs.fields.count; $i++) {
                    $field = $rs.fields[$i]
                    $record.add($field.name, $field.value) | Out-Null
                }
                if ($sql.Count -gt 1) {
                    # Detail exists
                    [string]$sqlTemp= $sql[1]
                    if ($sql.Count -gt 2) {
                        # Master / Detail Link exists
                        [string]$sqlLink= $rs.fields[$sql[2]].value.replace("'","''")
                        $sqlTemp = ($sqlTemp -f $sqlLink)
                    }
                    $record.add($arrRoot, (Get-DataFromSql -sql @($sqlTemp) -conn $myConn -udl $udl -connStr $connStr )) | Out-Null
                }
                $result.Add($record) | Out-Null
                $rs.MoveNext() | Out-Null
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-DataFromSql -sql @('SELECT TOP 10 ArtNummer, Vk, Kurztext1 FROM Artikel')  -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}
