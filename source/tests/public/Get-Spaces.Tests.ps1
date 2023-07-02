Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-Spaces' {

    It "should return one space character when called without parameters" {
        Get-Spaces | Should -Be " "
    }

    It "should return five space characters when called with 5 as parameter" {
        Get-Spaces -Count 5 | Should -Be "     "
    }

    It "should not throw an exception when called with 10KB (10240) as parameter" {
        { Get-Spaces -Count 10240 } | Should -Not -Throw
    }

    It "should throw an exception when called with 11KB (11264) as parameter" {
        { Get-Spaces -Count 11264 } | Should -Throw
    }
}
