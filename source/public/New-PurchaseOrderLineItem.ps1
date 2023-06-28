function New-PurchaseOrderLineItem {
    param(
        [int]$purchaseOrderId
        ,
        [int]$purchaseOrderNo
        ,
        [Parameter(Mandatory = $false)]
        [string]$barcode
        ,
        [Parameter(Mandatory = $false)]
        [string]$articleNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$articleId
        ,
        [Parameter(Mandatory = $false)]
        [guid]$articleUid
        ,
        [decimal]$quantity
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
        $result = 0

        if (! $purchaseOrderId) {
            $sql = "SELECT Id From KrAuftrag Where KopfNummer = $purchaseOrderNo"
            $rs =  $myConn.Execute($sql)
            if ($rs -and !$rs.EOF) {
                $purchaseOrderId = $rs.Fields('Id').Value
            }
            if (! $purchaseOrderId) {
                Throw ("There was no valid PurchaseOrderId found. Function: {0}" -f $myInvocation.Mycommand)
            }
        }


        $paramsArticle = Get-UsedParameters -validParams (Get-SingleArticleKeys) -boundParams $PSBoundParameters
        $articleId = Get-ArticleId @paramsArticle -conn $myConn
        if (! $articleId) {
            Throw ("Could not find the article id. Function: {0}" -f $myInvocation.Mycommand)
        }

        $cmd = New-Object -ComObject ADODB.Command
        $cmd.ActiveConnection = $myConn
        $cmd.CommandType = 4 #adCmdStoredProc
        $cmd.CommandText = "[dbo].[cn_KfpNew]"

        $cmd.Parameters.Append(($cmd.CreateParameter("@KopfId", 3, 1,4, $purchaseOrderId))) #adInteger
        $cmd.Parameters.Append(($cmd.CreateParameter("@ArtikelId", 3, 1,4, $articleId))) #adInteger
        $cmd.Parameters.Append(($cmd.CreateParameter("@AutoAddKrArtikel", 11, 1, 1, 0))) #adBoolean, setting it to False
        $cmd.Parameters.Append(($cmd.CreateParameter("@Menge", 5, 1,4, $quantity))) #adDouble

        $cmd.Execute() | Out-Null

        $sql = "SELECT MAX(Id) AS LastId FROM KrAuftragPos WHERE KopfId = $purchaseOrderId"
        $rs =  $myConn.Execute($sql)
        if ($rs -and !$rs.EOF) {
            $result = $rs.Fields('LastId').Value
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
}
