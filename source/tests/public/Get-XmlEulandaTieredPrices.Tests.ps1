Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-XmlEulandaTieredPrices' {

    BeforeAll {
        $udl = Resolve-Path ".\source\tests\Eulanda_1 Pester.udl"

        # Test-MssqlAdministartor rights
        $skipTest = -not (Test-MssqlAdministrator -udl $udl)

        # Skip backup because for restoring you need special rights
        if (! $skipTest) {
            Backup-MssqlDatabase -udl $udl

            . source\tests\include\Include-InsertArticle.ps1

            # Create a pricelist
            $sql = "INSERT INTO PreisListe ([Name],[Beschreibung]) VALUES ('Retail', 'Retail')"
            $myConn = Get-Conn -udl $udl
            $myConn.Execute($sql)

            # Create price
            $sql = "INSERT INTO Preis ([Vk],[ArtikelId],[Preisliste],[Staffel],[MengeAb]) VALUES (35.5, $articleId, (SELECT top 1 Id From Preisliste WHERE Name = 'Retail'),1,1)"
            $myConn = Get-Conn -udl $udl
            $myConn.Execute($sql)
        }
    }


    AfterAll {
        # Skip restore because for restoring you need special rights
        if (! $skipTest) {
            Restore-MssqlDatabase -udl $udl
        }
    }


    It 'should get a valid tired price' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $xmlStr = Get-XmlEulandaTieredPrices -articleId $articleId -udl $udl
        [xml]$xml = $xmlStr
        $xml.PREISLISTE.PREIS.VK | Should -Be 35.5
    }
}
