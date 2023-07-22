Import-Module -Name .\EulandaConnect.psd1

Describe 'Test-ValidateConn' {
    InModuleScope EulandaConnect {

        # Test case when $conn is a valid COM object
        It 'should return true when $conn is a valid COM object' {
            # Create a mock COM object
            $comObject = New-Object -ComObject ADODB.Connection

            # Call Test-ValidateConn
            $result = Test-ValidateConn -conn $comObject

            # Assert
            $result | Should -Be $true
        }

        # Test case when $conn is not a valid COM object
        It 'should throw an error when $conn is not a valid COM object' {
            # Create a non-COM object
            $nonComObject = New-Object -TypeName PSObject

            # Call Test-ValidateConn and expect an error
            { Test-ValidateConn -conn $nonComObject } | Should -Throw "The connection object is not a valid COM object."
        }
    }
}
