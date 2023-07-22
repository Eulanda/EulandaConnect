Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-Conn' {

    It "Checks if Get-Conn returns the correct object when given a udl parameter" {
        $udl = Resolve-Path '.\source\tests\EULANDA_1 Pester.udl'
        $result = Get-Conn -udl $udl
        $result.state | Should -Be 1
    }

    It "Checks if Get-Conn returns the correct object when given a connStr parameter" {
        $connStr = 'Provider=SQLOLEDB.1;Password=bond007;Persist Security Info=True;User ID=eulanda;Initial Catalog=Eulanda_Pester;Data Source=.\PESTER'
        $result = Get-Conn -connStr $connStr
        $result.state | Should -Be 1
    }

    It "Checks if Get-Conn throws an exception when no parameters are given" {
        { Get-Conn } | Should -Throw
    }
}
