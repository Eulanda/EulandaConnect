Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Join-PathUri Function' {
    InModuleScope EulandaConnect {

        It 'Should return correct URL when base and path are provided without slashes' {
            $base = "http://example.com"
            $path = "api/v1"
            $expected = "http://example.com/api/v1"
            $actual = Join-PathUri -base $base -path $path
            $actual | Should -BeExactly $expected
        }

        It 'Should return correct URL when base and path are provided with slashes' {
            $base = "http://example.com/"
            $path = "/api/v1"
            $expected = "http://example.com/api/v1"
            $actual = Join-PathUri -base $base -path $path
            $actual | Should -BeExactly $expected
        }

        It 'Should return correct URL when only base is provided' {
            $base = "http://example.com"
            $expected = "http://example.com/"
            $actual = Join-PathUri -base $base
            $actual | Should -BeExactly $expected
        }

        It 'Should return correct URL when only path is provided' {
            $path = "api/v1"
            $expected = "/api/v1"
            $actual = Join-PathUri -path $path
            $actual | Should -BeExactly $expected
        }

        It 'Should return slash when neither base nor path is provided' {
            $expected = "/"
            $actual = Join-PathUri
            $actual | Should -BeExactly $expected
        }
    }
}
