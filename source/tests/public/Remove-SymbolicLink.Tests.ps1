Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Remove-SymbolicLink' -Tag 'mock' {
    InModuleScope EulandaConnect {

        It "removes symbolic link when run as administrator and link exists" {
            Mock Get-ResStr { return [string]$args[0] }
            Mock Test-Administrator { return $true }
            Mock Test-Path { return $true }
            Mock Get-Item { return @{
                Attributes = [System.IO.FileAttributes]::ReparsePoint
            }}
            Mock Remove-Item {}
            { Remove-SymbolicLink -symbolicLink 'C:\MySymbolicLink' } | Should -Not -Throw
            Assert-MockCalled -CommandName 'Remove-Item' -Times 1 -Exactly
        }

        It "throws when not run as administrator" {
            Mock Get-ResStr { return [string]$args[1] }
            Mock Test-Administrator { return $false }
            Mock Test-Path { return $true }
            Mock Get-Item { return @{
                Attributes = [System.IO.FileAttributes]::ReparsePoint
            }}
            Mock Remove-Item {}
            { Remove-SymbolicLink -symbolicLink 'C:\MySymbolicLink' } | Should -Throw -ExpectedMessage "ADMIN_RIGHTS_NEEDED"
            Assert-MockCalled -CommandName 'Remove-Item' -Times 0
        }


        It "does nothing when symbolic link does not exist" {
            Mock Get-ResStr { return [string]$args[0] }
            Mock Test-Administrator { return $true }
            Mock Test-Path { return $false }
            Mock Get-Item { return @{
                Attributes = [System.IO.FileAttributes]::ReparsePoint
            }}
            Mock Remove-Item {}
            { Remove-SymbolicLink -symbolicLink 'C:\MySymbolicLink' } | Should -Not -Throw
            Assert-MockCalled -CommandName 'Remove-Item' -Times 0
        }
    }
}
