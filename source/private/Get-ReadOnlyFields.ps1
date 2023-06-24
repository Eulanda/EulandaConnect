function Get-ReadOnlyFields {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$tableName
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
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

        $readOnlyFields = @()

        $rs = New-Object -ComObject ADODB.Recordset
        $query = "SELECT TOP 0 * FROM $tableName"
        $rs.Open($query, $myConn)

        for ($i=0; $i -lt $rs.Fields.Count; $i++) {
            $field = $rs.Fields.Item($i)
            # write-host "$($field.name) $($field.attributes)"
            if (-not ($field.Attributes -band 0x8)) {  # 0x8 is adFldUpdatable
                $readOnlyFields += $field.Name
            }
        }
        $rs.Close()
        # $readOnlyFields | ForEach-Object { $_.ToUpper() }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        return $readOnlyFields
    }
}
