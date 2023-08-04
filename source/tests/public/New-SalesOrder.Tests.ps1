Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'New-SalesOrder' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {

    BeforeAll {
        $udl = Resolve-Path ".\source\tests\Eulanda_1 Pester.udl"

        # Test-MssqlAdministartor rights
        $skipTest = -not (Test-MssqlAdministrator -udl $udl)

        # Skip backup because for restoring you need special rights
        if (! $skipTest) {
            Backup-MssqlDatabase -udl $udl

          . source\tests\include\Include-InsertAddress.ps1
        }
    }


    AfterAll {
        # Skip restore because for restoring you need special rights
        if (! $skipTest) {
            Restore-MssqlDatabase -udl $udl
        }
    }


    It 'Creates a sales order from existing address' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $id = New-SalesOrder -invoiceAddressId $addressId -udl ".\source\tests\Eulanda_1 Pester.udl"
        $id | should -BeGreaterThan 0
    }

}
