function New-PropertyItem {
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

        Test-ValidateProperty -id $id -propertyId $propertyId -conn $myConn

        [string]$sql = @"
            DECLARE @KopfId INT;
            DECLARE @ObjektId INT;
            SELECT TOP 1 @ObjektId = $id
            SET @KopfId = $propertyId;
            INSERT INTO MerkmalElement (KopfId, ObjektId)
            SELECT @KopfId, @ObjektId
            WHERE NOT EXISTS (SELECT 1 FROM MerkmalElement WHERE KopfId = @KopfId AND ObjektId = @ObjektId);
"@
        $myConn.Execute($sql) | out-null
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test:  New-PropertyItem -id 42 -propertyId 4711 -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}
