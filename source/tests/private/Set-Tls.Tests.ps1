Import-Module -Name .\EulandaConnect.psd1

Describe 'Set-Tls' {
    InModuleScope 'EulandaConnect' {

        It 'should set the correct TLS protocols' {
            # Save the original SecurityProtocol
            $originalSecurityProtocol = [Net.ServicePointManager]::SecurityProtocol

            # Call Set-Tls
            Set-Tls

            # Assert
            [Net.ServicePointManager]::SecurityProtocol | Should -Be ([Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls12)

            # Reset the original SecurityProtocol
            [Net.ServicePointManager]::SecurityProtocol = $originalSecurityProtocol
        }
    }
}
