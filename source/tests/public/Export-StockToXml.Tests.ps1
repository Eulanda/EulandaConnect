Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Export-StockToXml' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {

    BeforeAll {
        $udl = Resolve-Path ".\source\tests\Eulanda_1 Pester.udl"

        # Test-MssqlAdministartor rights
        $skipTest = -not (Test-MssqlAdministrator -udl $udl)

        # Skip backup because for restoring you need special rights
        if (! $skipTest) {
            Backup-MssqlDatabase -udl $udl

            . source\tests\include\Include-InsertArticle.ps1

            [System.Array]$quantities = @()
            $hash = @{}
            $hash['articleNo'] = $articleNo
            $hash['qty'] = 20
            $quantities += $hash

            Set-StockQty -quantities $quantities -bookingInfo "Pestertest" -udl $udl
        }
    }


    AfterAll {
        # Skip restore because for restoring you need special rights
        if (! $skipTest) {
            Restore-MssqlDatabase -udl $udl
        }
    }


    It 'Exports one existing article stock to xml' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        [string]$xmlStr = Export-StockToXml -udl $udl -filter "ArtNummer = '$articleNo'"
        [xml]$xml = $xmlStr
        $selectedNode = $xml.EULANDA.LAGERLISTE.ARTIKEL | Where-Object { $_.KONTO -eq '1000' }
        $selectedNode.MENGE | Should -Be 20
    }


    It 'Handle filter with no result' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        [string]$xmlStr = Export-StockToXml -udl $udl -filter "ArtNummer = 'UNKNOWN_SKU'"
        [xml]$xml = $xmlStr

        if ($xml.EULANDA.PSObject.Properties.Name -contains 'LAGERLISTE') {
            $xml.EULANDA.LAGERLISTE | Should -BeNullOrEmpty
        }
        else {
            $true | Should -BeTrue
        }
    }


    It 'Handles connection errors and missing UDL file appropriately' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $nonExistentUdl = 'C:\path\to\nonexistent.udl'
        { Export-StockToXml -udl $nonExistentUdl } | Should -Throw
    }


    It 'Handles invalid connection object' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $invalidConn = 'invalid connection'
        { Export-StockToXml -conn $invalidConn } | Should -Throw
    }


    It 'Handles closed database connection appropriately' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $closedConn = Get-Conn -udl $udl
        $closedConn.close() # close it
        [string]$xmlStr = Export-StockToXml -conn $closedConn -filter "ArtNummer = '$articleNo'"
        [xml]$xml = $xmlStr
        $selectedNode = $xml.EULANDA.LAGERLISTE.ARTIKEL | Where-Object { $_.KONTO -eq '1000' }
        $selectedNode.MENGE | Should -Be 20
    }

}
