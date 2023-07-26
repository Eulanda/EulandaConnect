Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Set-StockQty' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {

    BeforeAll {
        $udl = Resolve-Path ".\source\tests\Eulanda_1 Pester.udl"

        # Test-MssqlAdministartor rights
        $skipTest = -not (Test-MssqlAdministrator -udl $udl)

        # Skip backup because for restoring you need special rights
        if (! $skipTest) {
            Backup-MssqlDatabase -udl $udl

            . source\tests\include\Include-InsertArticle.ps1
        }
    }


    AfterAll {
        # Skip restore because for restoring you need special rights
        if (! $skipTest) {
            Restore-MssqlDatabase -udl $udl
        }
    }


    It 'Set absolute stock qty to an existing article' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        [System.Array]$quantities = @()
        $hash = @{}
        $hash['articleNo'] = $articleNo
        $hash['qty'] = 20
        $quantities += $hash

        { Set-StockQty -quantities $quantities -bookingInfo "Pestertest" -udl $udl } | Should -Not -Throw
        [string]$xmlStr = Get-XmlEulandaArticle  -udl $udl -filter "ArtNummer = '$articleNo'"
        [xml]$xml = $xmlStr
        $xml.ARTIKELLISTE.ARTIKEL.LAGER.BESTANDVERFUEGBAR | Should -be 20
    }


    It 'Set absolute stock to an non existing article should not throw' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        [System.Array]$quantities = @()
        $hash = @{}
        $hash['articleNo'] = 'NON_EXISTING_SKU'
        $hash['qty'] = 20
        $quantities += $hash

        { Set-StockQty -quantities $quantities -bookingInfo "Pestertest" -udl $udl } | Should -Not -Throw
    }


    It 'Set absolute stock to an non existing article should throw' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        [System.Array]$quantities = @()
        $hash = @{}
        $hash['articleNo'] = 'NON_EXISTING_SKU'
        $hash['qty'] = 20
        $quantities += $hash

        { Set-StockQty -quantities $quantities -bookingInfo "Pestertest" -throwOnError -udl $udl } | Should -Throw
    }


    It 'Handles connection errors and missing UDL file appropriately' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $nonExistentUdl = 'C:\path\to\nonexistent.udl'
        { Set-StockQty -quantities $quantities -bookingInfo "Pestertest" -udl $nonExistentUdl } | Should -Throw
    }


    It 'Handles invalid connection object' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $invalidConn = 'invalid connection'
        { Set-StockQty -quantities $quantities -bookingInfo "Pestertest" --conn $invalidConn  } | Should -Throw
    }


    It 'Handles closed database connection appropriately' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $closedConn = Get-Conn -udl $udl
        $closedConn.close() # close it

        [System.Array]$quantities = @()
        $hash = @{}
        $hash['articleNo'] = $articleNo
        $hash['qty'] = 30
        $quantities += $hash

        { Set-StockQty -quantities $quantities -bookingInfo "Pestertest" -conn $closedConn } | Should -Not -Throw
        [string]$xmlStr = Get-XmlEulandaArticle  -conn $closedConn -filter "ArtNummer = '$articleNo'"
        [xml]$xml = $xmlStr
        $xml.ARTIKELLISTE.ARTIKEL.LAGER.BESTANDVERFUEGBAR | Should -be 30
    }

}
