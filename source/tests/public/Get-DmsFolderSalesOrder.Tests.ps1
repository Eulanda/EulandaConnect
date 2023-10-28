Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-DmsFolderSalesOrder' -Tag 'integration', 'sql', 'eulanda' {

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

    Context 'Parameter Tests' {

        It 'should throw an error when no parameters are provided' {
            { Get-DmsFolderSalesOrder } | Should -Throw
        }

        It 'should throw an error if both deliveryId and deliveryNo are provided' {
            { Get-DmsFolderSalesOrder -salesOrderId 1 -salesOrderNo 1 -udl $udl  } | Should -Throw
        }

    }


}
