function Get-BreadcrumbPath {
    param(
        [Parameter(Mandatory = $false)]
        [int]$breadcrumbId = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'breadcrumbId', $myInvocation.Mycommand))
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

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        # DO NOT use connection validation, because params are optional
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$sql = @"
        DECLARE @BreadcrumbPath varchar(1024);
        DECLARE @ID int = $breadcrumbId;
        WITH CTE AS (
            SELECT ID, ParentID, Name, CAST(Name AS varchar(1024)) AS Pfad
            FROM Merkmal
            WHERE ID = @ID
            UNION ALL
            SELECT M.ID, M.ParentID, M.Name, CAST(M.Name + '\' + MK.Pfad AS varchar(1024))
            FROM Merkmal AS M
            JOIN CTE AS MK ON M.ID = MK.ParentID
        )
        SELECT TOP 1 @BreadcrumbPath=Pfad
        FROM CTE
        WHERE ParentID IS NULL
        ORDER BY ID DESC;

        IF CHARINDEX('\', @BreadcrumbPath) > 0
        BEGIN
            -- Path found, cut the beginning like ':AR@1047' and start with first backslash
            SET @BreadcrumbPath = SUBSTRING(@BreadcrumbPath, CHARINDEX('\', @BreadcrumbPath), LEN(@BreadcrumbPath))
        END
        ELSE
        BEGIN
            IF CHARINDEX(':', @BreadcrumbPath) > 0
            BEGIN
            -- Path is the root
            SET @BreadcrumbPath = '\'
            END
            ELSE
            BEGIN
            -- Path or Id not found
            SET @BreadcrumbPath = ''
            END;
        END;

        -- Result is: @BreadcrumbPath
"@
        if (($conn) -or ($udl) -or ($connStr)) {
            $sql = "$sql`r`n    SELECT @BreadcrumbPath [BreadcrumbPath];"
            $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
            $rs = $myConn.Execute($sql)
            $rs = Get-AdoRs -recordset $rs
            if ($rs) {
                [string]$result = $rs.fields('BreadcrumbPath').value
            }
        } else {
            [string]$result = [string]$sql
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-BreadcrumbPath -breadcrumbId 2280 -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}
