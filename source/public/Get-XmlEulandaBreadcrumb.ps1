Function Get-XmlEulandaBreadcrumb {
    param(
        [Parameter(Mandatory = $false)]
        [string]$barcode
        ,
        [Parameter(Mandatory = $false)]
        [string]$articleNo
        ,
        [Parameter(Mandatory = $false)]
        [int]$articleId
        ,
        [Parameter(Mandatory = $false)]
        [guid]$articleUid
        ,
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

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $tablename = Test-ValidateMapping -strValue $tablename -mapping (Get-MappingTablename)
        Test-ValidateSingle -validParams (Get-SingleArticleKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'memoryStream' -Scope 'Private' -Value ($null)
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'nodeName' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'nodeValue' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'paramsArticle' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'streamReader' -Scope 'Private' -Value ($null)
        New-Variable -Name 'writer' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlWriterSettings' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        $paramsArticle = Get-UsedParameters -validParams (Get-SingleArticleKeys) -boundParams $PSBoundParameters
        try {
            $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
            $articleId = Get-ArticleId  @paramsArticle  -conn $myConn

            [string]$sql = @"
            DECLARE @root VARCHAR(128)
            DECLARE @keyid int
            DECLARE @bs VARCHAR(2)
            DECLARE @blank VARCHAR(2)
            SET @bs = '\'
            SET @blank = ''
            SET @root = '$breadcrumbPath'
            IF @root = @blank SET @root=@bs
            IF LEN(@root)>1 AND SUBSTRING(@root,LEN(@root),1) <> @bs SET @root = @root + @bs
            EXEC cn_MerkOpenPath @keyid=@keyid OUT, @basekeyid=0, @path=@root, @tablename='$tablename'
            SELECT @bs + dbo.cnf_merkpfad(m.id,@keyid) [PFAD]
            FROM Merkmalelement me
            LEFT JOIN merkmal m ON m.id=me.kopfid
            WHERE m.tabelle = '$tablename' and
            m.merkmaltyp = 1 and
            me.objektid = (SELECT id FROM $tablename WHERE Id = $articleId) and
            @bs + dbo.cnf_merkpfad(m.id,@keyid) <> '\' and
            not @bs + dbo.cnf_merkpfad(m.id,@keyid) like '%.USER%'
            ORDER BY @bs + dbo.cnf_merkpfad(m.id,@keyid)
"@
            $rs = $Null
            $rs = $myConn.Execute($sql)
            $rs = Get-AdoRs -recordset $rs
            if ($rs) {
                # Creating a MemoryStream object to store the XML text
                $memoryStream = New-Object System.IO.MemoryStream

                # Use xmlWriterSettings to change the default settings of the xmlWriter
                $xmlWriterSettings = New-Object System.Xml.XmlWriterSettings
                $xmlWriterSettings.Encoding = [System.Text.UTF8Encoding]::new()
                # Prevent the declaration at the beginning like: <?xml version="1.0" encoding="utf-8"?>
                $xmlWriterSettings.OmitXmlDeclaration = $true

                # Creating an XmlWriter object to write the XML structure
                $writer = [System.Xml.XmlWriter]::Create($memoryStream, $xmlWriterSettings)
                # Writing the XML structure with the XmlWriter object
                $writer.WriteStartElement('MERKMALLISTE')
                while (! $rs.eof) {
                    $writer.WriteStartElement('MERKMAL')
                        [string]$nodeName = $rs.fields[0].Name.ToUpper()
                        [string]$nodeValue = [string]$rs.fields[0].value
                        $writer.WriteElementString($nodeName,$nodeValue)
                    $writer.WriteEndElement()

                   $rs.movenext()
                }
                $writer.WriteEndElement()
                # Exiting the XmlWriter object
                $writer.Flush()
                $writer.Close()

                # Read memoryStream with streamreader
                $memoryStream.Position = 0
                $streamReader = New-Object System.IO.StreamReader($memoryStream)
                [string]$result = $streamReader.ReadToEnd()
            }

        }

        catch {
            if ($Error.Count -gt 0) {
                $line = $myInvocation.ScriptLineNumber - 1
                Throw ((Get-ResStr 'EXCEPTION_GENERAL_EXT') -f $_, $($myInvocation.Mycommand), $($line), $($Error[0].Exception.Message) )
            } else {
                Throw ((Get-ResStr 'EXCEPTION_GENERAL') -f $_, $($myInvocation.Mycommand))
            }
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-XmlEulandaBreadcrumb -articleNo '130100' -tablename 'Article' -breadcrumbpath '\shop' -udl 'C:\temp\Eulanda_1 Truccamo.udl'
}