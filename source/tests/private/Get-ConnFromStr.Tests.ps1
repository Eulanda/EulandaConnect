Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-ConnFromStr' -Tag 'integration', 'sql' {
    InModuleScope EulandaConnect {

        It 'should establish a connection to the MASTER database' {
            $connStr = 'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=master;Data Source=.\PESTER'
            $conn = Get-ConnFromStr -connStr $connStr
            $conn.State | Should -Be 1  # 1 is open
            $conn.close()
        }
    }
}
