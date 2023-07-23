Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-AdoRs' {
    InModuleScope EulandaConnect {

        It 'Throws an error when no parameter is passed' {
            { Get-AdoRs } | Should -Throw
        }

        It 'Do not throws an error when recordset is null' {
            { Get-AdoRs -recordset $null } | Should -Not -Throw
        }

        It 'Returns null when the recordset is empty' {
            $mockRecordset = New-Object PSObject
            $mockRecordset | Add-Member -MemberType NoteProperty -Name 'State' -Value $adStateClosed
            $mockRecordset | Add-Member -MemberType NoteProperty -Name 'eof' -Value $true
            $mockRecordset | Add-Member -MemberType ScriptMethod -Name 'NextRecordset' -Value { return $null }

            Get-AdoRs -recordset $mockRecordset | Should -Be $null
        }

        It 'Returns the recordset when it is not empty' {
            $mockRecordset = New-Object PSObject
            $mockRecordset | Add-Member -MemberType NoteProperty -Name 'State' -Value $adStateOpen
            $mockRecordset | Add-Member -MemberType NoteProperty -Name 'eof' -Value $false

            Get-AdoRs -recordset $mockRecordset | Should -Be $mockRecordset
        }
    }
}
