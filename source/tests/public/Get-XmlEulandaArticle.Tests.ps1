Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-XmlEulandaArticle' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {

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


    It 'Get one existing article as xml string' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        [string]$xmlStr = Get-XmlEulandaArticle -udl $udl -filter "ArtNummer = '$articleNo'"
        [xml]$xml = $xmlStr
        $xml.ARTIKELLISTE.ARTIKEL.ARTNUMMER | should -Be $articleNo
    }


    It 'Handle filter with no result' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        [string]$xmlStr = Get-XmlEulandaArticle -udl $udl -filter "ArtNummer = 'nonexistingSKU'"
        $xmlStr | should -BeNullOrEmpty
    }


    It 'Handles connection errors and missing UDL file appropriately' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $nonExistentUdl = 'C:\path\to\nonexistent.udl'
        { Get-XmlEulandaArticle -udl $nonExistentUdl } | Should -Throw
    }


    It 'Handles invalid connection object' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $invalidConn = 'invalid connection'
        { Get-XmlEulandaArticle -conn $invalidConn } | Should -Throw
    }


    It 'Handles closed database connection appropriately' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $closedConn = Get-Conn -udl $udl
        $closedConn.close() # close it
        $xmlStr = Get-XmlEulandaArticle -conn $closedConn -filter "ArtNummer = '$articleNo'"
        [xml]$xml = $xmlStr
        $xml.ARTIKELLISTE.ARTIKEL.ARTNUMMER | should -Be $articleNo
    }

}
