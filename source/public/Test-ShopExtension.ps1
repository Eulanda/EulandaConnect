function Test-ShopExtension {
    [CmdletBinding()]
    param(
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

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'nullValue' -Scope 'Private' -Value ($null)
        New-Variable -Name 'objectId' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'Sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        try {
            [string]$Sql = "SELECT OBJECT_ID('esolArtikelShop') [ObjectId]"
            $rs = $myConn.Execute($sql)
            $rs = Get-AdoRs -recordset $rs
            if ($rs) {
                $nullValue = [DBNull]::Value
                $objectId = $rs.fields('ObjectId').value
                if ($nullValue -eq $objectId) {
                    [bool]$result = $false
                } else {
                    [bool]$result = $true
                }
            }
        }

        catch {
            Throw "$_ Function: $($myInvocation.Mycommand)"
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Test-ShopExtension -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}
