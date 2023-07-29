Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-XmlEulandaStock' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {

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


    It 'Get stock for an existing article' {
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
        [string]$xmlStr = Get-XmlEulandaStock -articleNo $articleNo -udl $udl
        [xml]$xml = $xmlStr
        $xml.LAGER.BESTANDVERFUEGBAR | Should -be 20
    }


    It 'Get an empty result for a non existing article' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        [string]$xmlStr = Get-XmlEulandaStock -articleNo 'NON_EXISTING_SKU'-udl $udl
        $xmlStr | Should -BeNullOrEmpty
    }

}
