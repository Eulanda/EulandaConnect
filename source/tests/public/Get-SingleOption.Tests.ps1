Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-SingleOption' {

    It 'returns the same value when it is in the list' {
        $result = Get-SingleOption -value 'bravo' -list @('default','bravo','charlie','delta','echo')
        $result | Should -Be 'bravo'
    }

    It 'returns the default value when the input value is not in the list' {
        $result = Get-SingleOption -value 'zulu' -list @('default','bravo','charlie','delta','echo')
        $result | Should -Be 'default'
    }

    It 'returns the default value when the input value is empty' {
        $result = Get-SingleOption -value '' -list @('default','bravo','charlie','delta','echo')
        $result | Should -Be 'default'
    }

    It 'throws an exception when the value parameter is not provided' {
        { Get-SingleOption -list @('default','bravo','charlie','delta','echo') } | Should -Throw
    }

    It 'throws an exception when the list parameter is not provided' {
        { Get-SingleOption -value 'alpha' } | Should -Throw
    }
}
