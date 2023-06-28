function Get-SupplierAddressId {
    [CmdletBinding()]
    param(
        [int]$supplierID
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
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

        $sql = @"
            SELECT ans.ID [SupplierAddressId]
            FROM Kreditor k
            JOIN Adresse adr ON adr.Id = k.AdresseID
            JOIN (
                SELECT ID, AdresseID, AdresseRevision
                FROM (
                    SELECT ID, AdresseID, AdresseRevision,
                        ROW_NUMBER() OVER (PARTITION BY AdresseID ORDER BY AdresseRevision DESC) as row_num
                    FROM cnAnschrift
                ) sub
                WHERE sub.row_num = 1
            ) ans ON ans.AdresseID = adr.ID
            WHERE k.ID = $supplierID;
"@

        $rs = $myConn.Execute($sql)
        if ($rs) {
            if (! $rs.eof) {
                [int]$result = $rs.fields('SupplierAddressId').value
            }
        }
    }


    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test $id = Get-SupplierAddressId -supplierID 15 -udl 'C:\temp\Eulanda_1 JohnDoe.udl'
}