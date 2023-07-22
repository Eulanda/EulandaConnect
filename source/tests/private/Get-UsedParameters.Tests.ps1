Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-UsedParameters' {
    InModuleScope EulandaConnect {

        It 'should return the bound parameters that are valid' {
            # Arrange
            $validParams = @('param1', 'param2', 'param3')
            $boundParams = @{ param1 = 'value1'; param2 = 'value2'; param4 = 'value4'}

            # Act
            $result = Get-UsedParameters -validParams $validParams -boundParams $boundParams

            # Assert
            $result.Keys.Count | Should -Be 2
            $result['param1'] | Should -Be 'value1'
            $result['param2'] | Should -Be 'value2'
            $result.ContainsKey('param3') | Should -Be $false
            $result.ContainsKey('param4') | Should -Be $false
        }
    }
}
