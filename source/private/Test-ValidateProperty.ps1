function Test-ValidateProperty {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$id
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$propertyId = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'propertyId', $myInvocation.Mycommand))
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
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

        # Make sure that everything is present, the propertyId and also the record to be inserted into the tree

        if ($id -eq $null -or $id -eq 0) {
            $throwMsg = ( "The property for -propertyId '{0}' do not exist. Function: {1}" -f $propertyId, $myInvocation.Mycommand)
            # If $id is NULL or 0, check only the table name
            [string]$sql = @"
            DECLARE @TabellenName nvarchar(128);
            SELECT @TabellenName = Tabelle FROM Merkmal WHERE ID = $propertyId;

            IF @TabellenName IS NOT NULL
            BEGIN
                SELECT 1 AS Result;
            END
            ELSE
            BEGIN
                SELECT 0 AS Result;
            END
"@
        } else {
            # Otherwise check both the table name and the ID
            $throwMsg = ("The -id '{0}' for the object or the property for -propertyId {1} do not exist. Function: {2}" -f $id, $propertyId, $myInvocation.Mycommand)
            [string]$sql = @"
            DECLARE @TabellenName nvarchar(128), @Sql nvarchar(max), @RowCount int, @IgnoredId int;
            SELECT @TabellenName = Tabelle FROM Merkmal WHERE ID = $propertyId;

            IF @TabellenName IS NOT NULL
            BEGIN
                SET @Sql = N'SELECT @IgnoredId = ID FROM ' + QUOTENAME(@TabellenName) + ' WHERE ID = $id; SET @RowCount = @@ROWCOUNT;';

                -- Execute the SQL statement and save the number of rows returned
                EXEC sp_executesql @Sql, N'@IgnoredId int OUTPUT, @RowCount int OUTPUT', @IgnoredId=@IgnoredId OUTPUT, @RowCount=@RowCount OUTPUT;

                SELECT CASE WHEN @RowCount > 0 THEN 1 ELSE 0 END AS Result;
            END
            ELSE
            BEGIN
                SELECT 0 AS Result;
            END
"@
        }

        $rs = $myConn.Execute($sql)
        if ((!$rs) -or ($rs.eof) -or (!$rs.fields(0).value))  {
            Throw $throwMsg
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test:  Test-ValidateProperty -id 42 -propertyId 4711 -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}
