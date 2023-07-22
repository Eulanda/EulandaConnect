Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-MultipleOptions' {

    It "Runs without throwing" {
        { Get-MultipleOptions -values 'alpha,bravo,charlie' -list @('default','bravo','charlie','delta','echo') } | Should -Not -Throw
    }

    It "Returns correct output when values are in list" {
        $result = Get-MultipleOptions -values 'alpha,bravo,charlie' -list @('default','bravo','charlie','delta','echo')
        $result | Should -Be 'default,bravo,charlie'
    }

    It "Returns first item from list when no values provided" {
        $result = Get-MultipleOptions -values '' -list @('default','bravo','charlie','delta','echo')
        $result | Should -Be 'default'
    }

    It "Returns first item from list when values are not in list" {
        $result = Get-MultipleOptions -values 'foxtrot,golf,horse' -list @('default','bravo','charlie','delta','echo')
        $result | Should -Be 'default'
    }
}
