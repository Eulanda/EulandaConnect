Import-Module .\EulandaConnect.psd1

Describe 'Test New-ConnStr' {
    It 'returns the correct connection string for integrated security' {
        $result = New-ConnStr -database 'TestDB' -server 'TestServer'
        $expectedResult = "Provider=SQLOLEDB.1;Data Source=TestServer;Initial Catalog=TestDB;Integrated Security=SSPI"
        $result | Should -Be $expectedResult
    }

    It 'returns the correct connection string for SQL authentication' {
        $result = New-ConnStr -database 'TestDB' -server 'TestServer' -user 'TestUser' -password 'TestPassword'
        $expectedResult = "Provider=SQLOLEDB.1;Data Source=TestServer;Initial Catalog=TestDB;Persist Security Info=True;User ID=TestUser;Password=TestPassword"
        $result | Should -Be $expectedResult
    }
}
