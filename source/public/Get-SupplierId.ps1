function Get-SupplierId {
    param(
        [int]$addressMatch
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
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

        $sql = @"
            SELECT k.Id [Id]
            FROM Kreditor k
            JOIN Adresse adr ON adr.Id = k.AdresseID and Match = '$addressMatch'
"@

        $rs = $myConn.Execute($sql)
        if ($rs) {
            if (! $rs.eof) {
                [int]$result = $rs.fields('Id').value
            }
        }
    }


    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }

}