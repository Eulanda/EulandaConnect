function Get-BreadcrumbId {
    param(
        [Parameter(Mandatory = $false)]
        [string]$breadcrumbPath = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'breadcrumbPath', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateMapping -strValue $_ -mapping (Get-MappingTablename) })]
        [string]$tablename = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'tablename', $myInvocation.Mycommand))
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
        # DO NOT use connection validation, because params are optional
        $tablename = Test-ValidateMapping -strValue $tablename -mapping (Get-MappingTablename)
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$sql = @"
        -- Format path 'subpath1\subpath2\subpath3' without leading or trailing backslashes
        DECLARE @BreadcrumbPath VARCHAR(100) = '$breadCrumbPath';
        SET @BreadcrumbPath = REPLACE(@BreadcrumbPath, '\\', '')
        IF LEFT(@BreadcrumbPath, 1) = '\' SET @BreadcrumbPath = SUBSTRING(@BreadcrumbPath, 2, LEN(@BreadcrumbPath) - 1)
        IF RIGHT(@BreadcrumbPath, 1) = '\' SET @BreadcrumbPath = SUBSTRING(@BreadcrumbPath, 1, LEN(@BreadcrumbPath) - 1)
        SET @BreadcrumbPath = LTRIM(RTRIM(@BreadcrumbPath))

        DECLARE @ParentId INT = NULL;
        DECLARE @BreadcrumbId INT = NULL;
        DECLARE @Crumb VARCHAR(1024);

        SELECT @ParentId=Id From merkmal where tabelle = '$tablename' and merkmaltyp=0 and ParentId is Null
        WHILE LEN(@BreadcrumbPath) > 0
        BEGIN
          SET @Crumb = LEFT(@BreadcrumbPath, CHARINDEX('\', @BreadcrumbPath + '\') - 1);
          SET @BreadcrumbPath = SUBSTRING(@BreadcrumbPath, LEN(@Crumb) + 2, 1024);
          SELECT @ParentId = Id
            FROM Merkmal
            WHERE [Name] = @Crumb AND
              IsNull(ParentId, -1) = IsNull(@ParentId, -1)  AND
              Tabelle = '$tablename';
          IF @@ROWCOUNT = 0 SET @ParentId = -1;
        END;

        SET @BreadcrumbId = @ParentId;
        -- Result is: @BreadcrumbId
"@
        if (($conn) -or ($udl) -or ($connStr)) {
            $sql = "$sql`r`n    SELECT @BreadcrumbId [BreadcrumbId];"
            $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
            $rs = $myConn.Execute($sql)
            $rs = Get-AdoRs -recordset $rs
            if ($rs) {
                [int]$result = $rs.fields('BreadcrumbId').value
            }
        } else {
            [string]$result = [string]$sql
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-BreadcrumbId -breadcrumbPath '\Shop' -tablename 'Artikel' -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}
