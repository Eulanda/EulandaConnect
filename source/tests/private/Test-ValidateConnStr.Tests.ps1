Import-Module -Name .\EulandaConnect.psd1

Describe 'Test-ValidateConnStr' {
    InModuleScope 'EulandaConnect' {

        It 'should return true when the connection string is valid' {
            $validConnStr = "Data Source=myServerAddress;Initial Catalog=myDataBase;User Id=myUsername;Password=myPassword;"

            $result = Test-ValidateConnStr -connStr $validConnStr

            $result | Should -Be $true
        }

        It 'should throw an error when the connection string is not valid' {
            $invalidConnStr = "User Id=myUsername;Password=myPassword;"

            { Test-ValidateConnStr -connStr $invalidConnStr } | Should -Throw "The connection string '$invalidConnStr' is not valid."
        }
    }
}
