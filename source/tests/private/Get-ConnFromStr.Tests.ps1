Import-Module -Name .\EulandaConnect.psd1

# ATTENTION: This integration test requires a locally installed MSSQL PESTER instance with built-in security

Describe 'Get-ConnFromStr' {
    InModuleScope 'EulandaConnect' {
        It 'should establish a connection to the MASTER database' {
            $connStr = 'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=master;Data Source=.\PESTER'
            $conn = Get-ConnFromStr -connStr $connStr
            $conn.State | Should -Be 1  # 1 is open
            $conn.close()
        }
    }
}
