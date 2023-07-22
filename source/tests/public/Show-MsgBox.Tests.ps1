Import-Module -Name .\EulandaConnect.psd1

Describe 'Show-MsgBox' -Tag 'input' {

    BeforeAll {
        $env:PESTER_TEST_RUN = '1'
    }

    AfterAll {
        Remove-Item Env:\PESTER_TEST_RUN
    }

    It "Should abort when in test environment" {
        { Show-MsgBox -prompt 'Do you want to continue?' } | Should -Throw -ExpectedMessage "Test environment detected, aborting Show-MsgBox"
    }
}

