Import-Module -Name .\EulandaConnect.psd1

Describe 'Test-HasProperty' {

    BeforeAll {
        $testObj = New-Object PSObject -Property @{
            TestProp = "TestValue"
        }
    }

    It "Returns true when the property exists" {
        Test-HasProperty -inputVar $testObj -propertyName 'TestProp' | Should -Be $true
    }

    It "Returns false when the property does not exist" {
        Test-HasProperty -inputVar $testObj -propertyName 'NonExistentProp' | Should -Be $false
    }
}
