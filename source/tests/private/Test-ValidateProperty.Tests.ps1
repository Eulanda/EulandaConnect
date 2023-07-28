Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Test-ValidateProperty' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {
    InModuleScope EulandaConnect {
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


        It 'Should not throw with existing id and propertyId' {
            if ($skipTest) {
                Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
                Return
            }

            { Test-ValidateProperty -id $articleId -propertyId $propertyId -ud $udl } | Should -Not -Throw
        }


        It 'Should throw with not existing propertyId' {
            if ($skipTest) {
                Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
                Return
            }

            { Test-ValidateProperty -propertyId 999999 -ud $udl } | Should -Throw
        }


        It 'Should throw with not existing id' {
            if ($skipTest) {
                Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
                Return
            }

            { Test-ValidateProperty -id 9999999 -propertyId $propertyId -ud $udl } | Should -Throw
        }


        It 'Should throw with not existing id and not existing propertyId' {
            if ($skipTest) {
                Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
                Return
            }

            { Test-ValidateProperty -id 9999999 -propertyId 9999999 -ud $udl } | Should -Throw
        }
    }

}
