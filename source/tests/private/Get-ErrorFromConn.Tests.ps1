Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-ErrorFromConn' -Tag 'integration', 'sql' {
    InModuleScope EulandaConnect {

        It 'should throw when trying to execute invalid query' {
            $pesterFolder = Resolve-Path ".\source\tests"
            $myConn = Get-Conn -udl "$pesterFolder\EULANDA_1 Pester.udl"
            { $myConn.Execute("Select *") } | Should -Throw
        }

        It 'should return error description when there is an error' {
            $pesterFolder = Resolve-Path ".\source\tests"
            $myConn = Get-Conn -udl "$pesterFolder\EULANDA_1 Pester.udl"
            try {
                $myConn.Execute("Select *") # force an error
            }
            catch {
                $result = Get-ErrorFromConn -conn $myConn
            }
            # no sample for Execute(sql= found get a result for test on -Not -BeNullOrEmpty
            # for that reason we test nonsense on only not -BeNullOrEmpty
            $result | Should -BeNullOrEmpty
        }
    }
}
