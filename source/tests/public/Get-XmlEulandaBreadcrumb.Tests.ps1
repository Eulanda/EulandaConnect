Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-XmlEulandaBreadcrumb' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {

    BeforeAll {
        $udl = Resolve-Path ".\source\tests\Eulanda_1 Pester.udl"

        # Test-MssqlAdministartor rights
        $skipTest = -not (Test-MssqlAdministrator -udl $udl)

        # Skip backup because for restoring you need special rights
        if (! $skipTest) {
            Backup-MssqlDatabase -udl $udl

            . source\tests\include\Include-InsertArticle.ps1

            New-PropertyItem -id $articleId -propertyId $propertyId -udl $udl
        }
    }


    AfterAll {
        # Skip restore because for restoring you need special rights
        if (! $skipTest) {
            Remove-PropertyItem -id $articleId -propertyId $propertyId -udl $udl

            Restore-MssqlDatabase -udl $udl
        }
    }


    It 'Sets a new property element with an illegal article id' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        New-PropertyItem -id $articleId -propertyId $propertyId -udl $udl
        $xmlStr = Get-XmlEulandaBreadcrumb -BreadcrumbRoot '\Shop' -id $articleId -tablename 'article' -udl $udl
        [xml]$xml = $xmlStr
        $xml.MERKMALLISTE.MERKMAL.PFAD | Should -Be '\Hardware'
    }

}
