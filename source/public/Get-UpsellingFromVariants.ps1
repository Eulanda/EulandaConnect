function Get-UpsellingFromVariants {
    [CmdletBinding()]
    param (
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
        Test-ValidateSingle -validParams (Get-SingleArticleKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'item' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFrag' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string[]]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        try {
            if ($barcode) {
                [string]$sqlFrag = "Barcode = '$barcode'"
            } elseif ($articleNo) {
                [string]$sqlFrag = "ArtNummer = '$articleNo'"
            } elseif($articleUid) {
                [string]$sqlFrag = "Uid = '$articleUid'"
            } else {
                [string]$sqlFrag = "Id = $articleId"
            }
            [string]$sql = @"
            DECLARE @Master VARCHAR(100);
            DECLARE @Variant VARCHAR(100);

            SELECT @Variant = ArtNummer FROM Artikel WHERE $sqlFrag
            SET @Master = NULL;

            SELECT @Master = eart.MasterArticle FROM esolArtikelshop [eart]
            JOIN Artikel [art] on art.Id = eart.Id
            WHERE art.ArtNummer =  @Variant;
            SELECT art.ArtNummer [ArticleNo] FROM Artikel [art]
            JOIN esolArtikelShop [eart] ON art.Id = eart.Id
            WHERE eart.MasterArticle = @Master AND art.ArtNummer <> @Variant
            ORDER BY 1;
"@

            $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

            if (! (Test-ShopExtension -conn $myConn)) {
                Throw ((Get-ResStr 'FUNCTION_NEEDS_SHOP_EXTENSIONS') -f $($myInvocation.Mycommand))
            }

            $rs = $myConn.Execute($sql)
            $rs = Get-AdoRs -recordset $rs
            if ($rs) {
                while (! $rs.eof) {
                    [string]$item = $rs.fields('ArticleNo').Value
                    $result += $item
                    $rs.MoveNext()
                }
            }
        } catch {
            Throw  ((Get-ResStr 'EXCEPTION_GENERAL') -f $_, $($myInvocation.Mycommand))
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-UpsellingFromVariants -articleNo '130100' -udl 'C:\temp\Eulanda_1 Truccamo.udl'
}
