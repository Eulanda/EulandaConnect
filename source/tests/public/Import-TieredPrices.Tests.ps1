Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Import-TieredPrices' {

    BeforeAll {
        $udl = Resolve-Path ".\source\tests\Eulanda_1 Pester.udl"

        # Test-MssqlAdministartor rights
        $skipTest = -not (Test-MssqlAdministrator -udl $udl)

        # Skip backup because for restoring you need special rights
        if (! $skipTest) {
            Backup-MssqlDatabase -udl $udl

            . source\tests\include\Include-InsertArticle.ps1

            $randomFileName = [System.IO.Path]::GetRandomFileName()
            $randomFileName = $randomFileName.Split('.')[0] + ".csv"
            $tempPath = [System.IO.Path]::GetTempPath()

            $testFilePath = Join-Path -Path $tempPath -ChildPath $randomFileName
            $testParams = @{
                path = $testFilePath
                articleNoName = 'ArticleNo'
                price1Name = 'SalesPrice'
                priceList = 'Retail'
                udl = $udl
            }

            # Create a pricelist
            $sql = "INSERT INTO PreisListe ([Name],[Beschreibung]) VALUES ('Retail', 'Retail')"
            $myConn = Get-Conn -udl $udl
            $myConn.Execute($sql)
        }
    }


    AfterAll {
        # Skip restore because for restoring you need special rights
        if (! $skipTest) {
            Restore-MssqlDatabase -udl $udl

            Remove-Item $testFilePath
        }
    }


    It 'should import from CSV' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }
        $csv = "ArticleNo;SalesPrice`r`n4711;31.5`r`n"
        Set-Content -Path $testFilePath -Value $csv
        { Import-TieredPrices @testParams } | Should -Not -Throw

        $sql = "SELECT Vk FROM Preis WHERE ArtikelId = $articleId AND Preisliste = (SELECT Id From Preisliste WHERE Name = 'Retail')"
        $rs = $myConn.Execute($sql)
        if (($rs) -and (!$rs.eof)) {
            $price = $rs.fields(0).value
        } else {
            $price = [double]0.0
        }
        $price | Should -Be 31.5
    }
}
