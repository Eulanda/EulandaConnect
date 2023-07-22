Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-LogName' {

    It 'Should return a log name with default ident when no ident is provided' {
        $logName = Get-LogName
        $logName | Should -Match "LOG-DEF-\d{4}-\d{2}-\d{2}--\d{2}-\d{2}-\d{2}-\d{3}.txt"
    }


    It 'Should include the ident in the log name when an ident is provided' {
        $logName = Get-LogName -ident 'STANDARD'
        $logName | Should -Match "LOG-STANDARD-\d{4}-\d{2}-\d{2}--\d{2}-\d{2}-\d{2}-\d{3}.txt"
    }


    It 'Should format the log name according to the dateMask when a dateMask is provided' {
        $logName = Get-LogName -ident 'STANDARD' -dateMask 'yyyy-MM'
        $logName | Should -Match "LOG-STANDARD-\d{4}-\d{2}.txt"
    }
}
