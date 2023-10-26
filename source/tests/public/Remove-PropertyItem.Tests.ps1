Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Remove-PropertyItem' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {

    BeforeAll {
        $udl = Resolve-Path ".\source\tests\Eulanda_1 Pester.udl"

        # Test-MssqlAdministartor rights
        $skipTest = -not (Test-MssqlAdministrator -udl $udl)

        # Skip backup because for restoring you need special rights
        if (! $skipTest) {
            Backup-MssqlDatabase -udl $udl

            . source\tests\include\Include-InsertArticle.ps1
            . source\tests\include\Include-InsertProperty.ps1
        }
    }


    AfterAll {
        # Skip restore because for restoring you need special rights
        if (! $skipTest) {
            Restore-MssqlDatabase -udl $udl
        }
    }


    It 'Sets a new property element with an illegal article id' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

          # Act
        New-PropertyItem -id $articleId -propertyId $propertyId -udl $udl

        # Verify that the property is now set
        $itemExists = Test-PropertyItem -id $articleId -propertyId $propertyId -udl $udl
        $itemExists | should -BeTrue

        # Remove the property
        Remove-PropertyItem -id $articleId -propertyId $propertyId -udl $udl

        # Verfy that the database is as it was at the beginning
        $itemExists = Test-PropertyItem -id $articleId -propertyId $propertyId -udl $udl
        $itemExists | should -BeFalse
    }

}
