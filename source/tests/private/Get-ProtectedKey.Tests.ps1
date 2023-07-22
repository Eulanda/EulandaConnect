Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-ProtectedKey' {
    InModuleScope EulandaConnect {

        It 'should return byte array when the key length is less than 16' {
            $result = Get-ProtectedKey -key 'test'
            $result | ForEach-Object { $_ | Should -BeOfType [Byte] }
            $result.Length | Should -Be 32
        }

        It 'should return byte array when the key length is less than 32 but more than 16' {
            $result = Get-ProtectedKey -key 'ThisIsALongerTestKey'
            $result | ForEach-Object { $_ | Should -BeOfType [Byte] }
            $result.Length | Should -Be 32
        }

        It 'should throw exception when the key length is 32 or more' {
            { Get-ProtectedKey -key 'ThisIsAnEvenLongerTestKeyThatIsOver32Characters' } | Should -Throw
        }

        It 'should throw exception when no key is provided' {
            { Get-ProtectedKey } | Should -Throw
        }
    }
}
